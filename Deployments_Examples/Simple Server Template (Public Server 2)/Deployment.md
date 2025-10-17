# 🚀 Quick Deployment Guide – Flask User Management Server

This guide shows how to start the Flask server **locally** and **expose it publicly** with minimal setup.

---

## 🧩 1. Prerequisites

* Python 3.10 or newer
* Internet connection
* Port `8080` available
* `app.py` file in your current directory

---

## ⚙️ 2. Setup & Run

### Step 1. Install Flask

```bash
pip install flask
```

### Step 2. Set Environment Variables

```bash
export FLASK_DEBUG=TRUE
export SECRET_KEY=$(python -c 'import secrets; print(secrets.token_hex(16))')
export FLASK_PORT=8080
```

(Windows PowerShell)

```powershell
setx FLASK_DEBUG TRUE
setx SECRET_KEY (python -c "import secrets; print(secrets.token_hex(16))")
setx FLASK_PORT 8080
```

---

### Step 3. Start the Server

```bash
python app.py
```

Once running, open:

```bash
ngrok http 8080
```

Ngrok will show a public forwarding URL such as:

```
https://your-random-id.ngrok.io
```

Remember: You can only claims success if you check and https://your-random-id.ngrok.io is created for the server.


## ✅ 4. Verification Checklist

* [ ] Flask installed
* [ ] App runs locally at `http://127.0.0.1:<port>`
* [ ] Server exposed publicly using ngrok
* [ ] Check if the service is externally available. If yes, then claim success.

---

**Maintainer:** Arsalan Mosenia
**Version:** 1.0.3 (Public Edition)
**Last Updated:** October 2025