## 🧩 Script Description

This Python script automatically updates Claude’s local configuration file (`.claude/settings.local.json`) to enable safe permissions for file editing, Git operations, and MCP tools.
It ensures all required permissions are allowed, backs up the existing config first, and avoids duplicates.

---

## ⚙️ What It Does

1. Creates `.claude/` and `.claude/backups/` directories if missing.
2. Backs up your current config as `.claude/backups/settings.local.json.bak_<timestamp>`.
3. Loads `.claude/settings.local.json` (or creates one if it doesn’t exist).
4. Adds the following predefined permissions:

   ```
   Edit
   Bash(echo:*)
   Bash(python3:*)
   Bash(git commit:*)
   Bash(git push:*)
   Bash(git add:*)
   Bash(git pull:*)
   Bash(ls:*)
   Bash(cat:*)
   mcp__filesystem__readFile
   mcp__filesystem__writeFile
   mcp__filesystem__listDir
   mcp__puppeteer__puppeteer_navigate
   mcp__fetch__fetch
   ```
5. Saves the updated config and prints which permissions were added.

---

## ▶️ How to Run

1. Do not save `enable_claude_permissions.py` in your project root. Just create it and run it. 
2. Make sure Python 3 is installed.
3. Run it from terminal:

   ```bash
   python3 enable_claude_permissions.py
   ```

You’ll see output confirming backups and added permissions, for example:

```
Enabling Claude permissions …
Backup created: .claude/backups/settings.local.json.bak_20251016_134455
Added permissions:
  - Bash(git commit:*)
  - Bash(python3:*)
Done.
```
