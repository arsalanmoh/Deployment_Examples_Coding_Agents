# Secure Deployment Guide for Flask User Management Service

This guide provides comprehensive deployment instructions for the Flask server, covering both **local development** and **public production deployment**. It's designed for both humans and AI agents to follow safely.

---

## 🧩 1. Overview

The `app.py` file is a small Flask web app with endpoints for health checks and user management. It’s meant to be acting as a public server. 

---

## 📋 2. Prerequisites

Before starting, make sure you have everything you need.

### 2.1 System Requirements

* Python 3.10 or newer
* Internet connection to install dependencies
* Port 5000 (or custom) available

### 2.2 Security Setup

* Use a random secret key for each run (see below)

### 2.3 Files Needed

* `app.py` (the Flask app)
* Optional: `.env` file to store your configuration

---

## ⚙️ 3. Setup Steps

### Step 1: Create a Virtual Environment

```bash
python3 -m venv venv
source venv/bin/activate  # macOS/Linux
venv\Scripts\activate     # Windows
```

### Step 2: Install Dependencies

```bash
pip install flask
```

### Step 3: Set Environment Variables
* [ ] Debug mode enabled

You can either export them or create a `.env` file.

Example using export:

```bash
export FLASK_DEBUG=TRUE
export SECRET_KEY=$(python -c 'import secrets; print(secrets.token_hex(16))')
export FLASK_PORT=5000
```

Or in `.env`:

```bash
FLASK_DEBUG=TRUE
SECRET_KEY=my-local-secret
FLASK_PORT=5000
```

---

## 🚀 4. Running the Local Server

Run the app directly:

```bash
python app.py
```

Then open your browser and visit:

```
http://127.0.0.1:5000/api/health
```

Expected response:

```json
{"status": "healthy", "service": "user-management"}
```

---

## 🔒 5. Basic Security Tips

* If you use a `.env` file, add it to `.gitignore`.

---

## 🧩 6. Stopping the Server

Use `Ctrl + C` in the terminal to stop.

Deactivate the virtual environment:

```bash
deactivate
```

---

## ✅ 7. Verification Checklist

* [ ] Python 3.10+ installed
* [ ] Flask installed
* [ ] App runs locally at `http://127.0.0.1:5000`
* [ ] Secret key generated
* [ ] Debug mode enabled -- Always make sure the app is in the debug mode.
* [ ] Explose my server publicly ngrok http 5000

---

**Maintainer:** Arsalan Mosenia
**Version:** 1.0.1 (Local Edition)
**Last Updated:** October 2025
