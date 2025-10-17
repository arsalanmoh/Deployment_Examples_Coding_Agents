#!/usr/bin/env python3
"""
Run locally and expose via ngrok.

Usage:
  - (optional) export NGROK_AUTHTOKEN="your-token"  # to use your paid ngrok account features
  - python app.py
The script prints:
  - local listening address (http://127.0.0.1:PORT)
  - ngrok HTTPS public URL (if pyngrok available)
  - a one-line admin bearer token (JWT, valid 24 hours)
"""

import os
import sys
import atexit
import signal
import logging
from datetime import datetime, timedelta
from threading import Thread

from flask import Flask, request, jsonify, abort
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address

try:
    from pyngrok import ngrok, conf as ngrok_conf
    _HAS_PYNGROK = True
except Exception:
    _HAS_PYNGROK = False

import jwt  # PyJWT

# -------------------------
# Config (change as needed)
# -------------------------
PORT = int(os.getenv("FLASK_PORT", "8080"))
HOST = "0.0.0.0"
JWT_ALGO = "HS256"
JWT_EXP_HOURS = int(os.getenv("ADMIN_TOKEN_EXP_HOURS", "24"))
RATE_LIMIT = "20 per minute"  # safe default for public demos
PRINT_ADMIN_ROUTE = "/admin/info"
# -------------------------

# Logging
logging.basicConfig(level=logging.INFO,
                    format="%(asctime)s %(levelname)s %(message)s")
logger = logging.getLogger("demo-server")

# Flask app
app = Flask(__name__)
# Ensure debug is enabled always
app.config["ENV"] = "production"
app.config["DEBUG"] = True
app.config["JSONIFY_PRETTYPRINT_REGULAR"] = False

# Secret for sessions / signing tokens: persist across restarts by saving
# to file if desired
SECRET_FILE = ".local_secret_key"
if os.path.exists(SECRET_FILE):
    with open(SECRET_FILE, "rb") as f:
        SECRET_KEY = f.read().strip()
        if not SECRET_KEY:
            SECRET_KEY = os.urandom(32)
else:
    SECRET_KEY = os.urandom(32)
    # persist secret so tokens survive a restart for the short demo window
    try:
        with open(SECRET_FILE, "wb") as f:
            f.write(SECRET_KEY)
    except Exception as e:
        logger.warning("Could not write secret file: %s", e)

# JWT secret (can reuse SECRET_KEY)
JWT_SECRET = SECRET_KEY

# Rate limiter
limiter = Limiter(key_func=get_remote_address, default_limits=[RATE_LIMIT])
limiter.init_app(app)

# -------------------------
# Auth helpers
# -------------------------


def create_admin_token(exp_hours=JWT_EXP_HOURS):
    payload = {
        "role": "admin",
        "iat": datetime.utcnow(),
        "exp": datetime.utcnow() + timedelta(hours=exp_hours),
        "note": "temporary-demo-token"
    }
    token = jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGO)
    # PyJWT returns str in v2+, bytes in older. Normalize to str.
    if isinstance(token, bytes):
        token = token.decode()
    return token


def verify_bearer_token_from_request(req):
    auth = req.headers.get("Authorization", "")
    if not auth.startswith("Bearer "):
        return None
    token = auth.split(" ", 1)[1].strip()
    try:
        payload = jwt.decode(token, JWT_SECRET, algorithms=[JWT_ALGO])
        return payload
    except jwt.ExpiredSignatureError:
        abort(401, description="Token expired")
    except jwt.InvalidTokenError:
        abort(401, description="Invalid token")


def require_admin(fn):
    def wrapper(*a, **kw):
        payload = verify_bearer_token_from_request(request)
        if not payload or payload.get("role") != "admin":
            abort(403, description="Forbidden")
        return fn(*a, **kw)
    wrapper.__name__ = fn.__name__
    return wrapper

# -------------------------
# Example endpoints
# -------------------------


@app.route("/health", methods=["GET"])
@limiter.exempt  # health endpoint should be easy to check
def health():
    return jsonify({"status": "ok", "time": datetime.utcnow().isoformat()})

# Public demo endpoint (read-only)


@app.route("/greet", methods=["GET"])
@limiter.limit("50 per minute")
def greet():
    name = request.args.get("name", "friend")
    # simple input hygiene: limit length
    if len(name) > 64:
        abort(400, description="name too long")
    return jsonify({"message": f"hello, {name}!"})

# Admin endpoint that shows internal info (requires Bearer token)


@app.route(PRINT_ADMIN_ROUTE, methods=["GET"])
@require_admin
def admin_info():
    return jsonify({
        "local_addr": f"http://127.0.0.1:{PORT}",
        "public_url": _PUBLIC_URL if "_PUBLIC_URL" in globals() else None,
        "token_exp_hours": JWT_EXP_HOURS,
    })

# A protected POST example that performs a trivial update (validate JSON)


@app.route("/user/create", methods=["POST"])
@require_admin
def create_user():
    j = request.get_json(silent=True)
    if not j:
        abort(400, description="invalid JSON")
    username = j.get("username")
    if not username or not isinstance(username, str) or len(username) > 64:
        abort(400, description="invalid username")
    # Do NOT perform any database actions in this demo script.
    # Return a simulated response:
    return jsonify({"result": "created", "username": username}), 201

# -------------------------
# ngrok management
# -------------------------
NGROK_TUNNEL = None


def start_ngrok_tunnel(local_port):
    global NGROK_TUNNEL, _PUBLIC_URL
    if not _HAS_PYNGROK:
        logger.info(
            "pyngrok not installed; skipping automatic public tunnel creation.")
        return None
    # If user supplied an ngrok authtoken via env, set it
    ngrok_token = os.getenv("NGROK_AUTHTOKEN")
    if ngrok_token:
        try:
            ngrok_conf.get_default().auth_token = ngrok_token
        except Exception:
            # fallback: call set_auth_token
            try:
                ngrok.set_auth_token(ngrok_token)
            except Exception:
                logger.warning(
                    "Couldn't set ngrok auth token; continuing without it.")
    logger.info("Starting ngrok tunnel for port %s...", local_port)
    NGROK_TUNNEL = ngrok.connect(local_port, bind_tls=True)
    _PUBLIC_URL = NGROK_TUNNEL.public_url
    logger.info("ngrok public url: %s", _PUBLIC_URL)
    return NGROK_TUNNEL


def stop_ngrok_tunnel():
    global NGROK_TUNNEL
    if _HAS_PYNGROK and NGROK_TUNNEL:
        try:
            logger.info("Stopping ngrok tunnel...")
            ngrok.disconnect(NGROK_TUNNEL.public_url)
            ngrok.kill()
        except Exception as e:
            logger.warning("Error stopping ngrok: %s", e)
        NGROK_TUNNEL = None

# Ensure ngrok is stopped on exit
atexit.register(stop_ngrok_tunnel)


def _signal_handler(signum, frame):
    logger.info("Signal %s received, shutting down...", signum)
    stop_ngrok_tunnel()
    sys.exit(0)

signal.signal(signal.SIGINT, _signal_handler)
signal.signal(signal.SIGTERM, _signal_handler)

# -------------------------
# Run server + tunnel
# -------------------------


def run_server():
    app.run(host=HOST, port=PORT, debug=True, threaded=True)


def main():
    logger.info("Starting local Flask server (production-mode defaults).")
    admin_token = create_admin_token()
    # print safe instructions and credentials
    logger.info("=== DEMO CREDENTIALS (valid for %s hours) ===", JWT_EXP_HOURS)
    logger.info("ADMIN BEARER TOKEN: %s", admin_token)
    logger.info("To call admin endpoints: Authorization: Bearer <token>")
    logger.info("=============================================")

    # Start ngrok in background if available
    if _HAS_PYNGROK:
        try:
            t = Thread(target=start_ngrok_tunnel, args=(PORT,), daemon=True)
            t.start()
        except Exception as e:
            logger.warning("Could not start ngrok tunnel in background: %s", e)
    else:
        logger.info(
            "pyngrok not installed. Install pyngrok to enable automatic public tunneling.")

    run_server()

if __name__ == "__main__":
    main()
