# Repository Administration & Git Setup Guide (`README-ADMIN.md`)

A practical runbook and memory aid for configuring Git authentication, SSH keys, credential caching, and remote repositories when setting up a new development machine, WSL instance, or container.

---

## ⚡ Quick Reference: The 60-Second SSH Setup

If you are on a fresh environment and getting `Permission denied (publickey)` or `Authentication failed`:

```bash
# 1. Generate an Ed25519 key pair (Press Enter 3 times for default location and no passphrase)
ssh-keygen -t ed25519 -C "varienjanitra@github"

# 2. Print your PUBLIC key to copy it
cat ~/.ssh/id_ed25519.pub

# 3. Add to GitHub:
#    Open https://github.com/settings/ssh/new
#    Title: e.g. "WSL Laptop"
#    Key type: Authentication Key
#    Key: Paste the output from step 2 -> Click "Add SSH key"

# 4. Verify your connection (Expected: "Hi varienjanitra! You've successfully authenticated...")
ssh -T git@github.com

# 5. Point your repository remote to SSH and push
git remote set-url origin git@github.com:varienjanitra/ai-skills.git
git push -u origin main
```

---

## 🧠 The Mental Model: How It Works & Why It Matters

### 1. Why Git Rejects Your Account Password
Since August 2021, GitHub deprecated account password authentication over HTTPS for security.
- **Passwords are broad and indefinite**: If a tool or machine leaks your password, your entire account is compromised until you reset it.
- **Keys and Tokens are scoped and revocable**: You can grant access to a single machine (SSH key) or specific repository scopes (Personal Access Token). If a laptop is lost, you simply delete that specific key on GitHub without touching anything else.

### 2. The Padlock vs. Key Metaphor (Asymmetric Cryptography)
When you run `ssh-keygen`, it creates two files in `~/.ssh/`:

| File | What It Is | Analogy | Sharing Rule |
| :--- | :--- | :--- | :--- |
| `id_ed25519.pub` | **Public Key** | An **open padlock** stamped with your name. | **Safe to share everywhere.** You copy this padlock to GitHub, servers, or cloud hosts. |
| `id_ed25519` | **Private Key** | The **physical key** that opens your padlocks. | **TOP SECRET.** Never share, commit, email, or copy it off your personal machine. |

**The Handshake:**
1. When you run `git push`, GitHub takes the open padlock (`id_ed25519.pub`) you uploaded earlier.
2. GitHub puts a random challenge inside a digital box, snaps your padlock shut, and sends it across the wire.
3. Your local SSH client uses your private key (`id_ed25519`) to unlock the box and prove identity.
4. Your private key is **never transmitted across the network**.

### 3. File Permissions: Why SSH Is "Paranoid"
SSH requires strict Linux file permissions. If other user accounts or group members could read your private key, SSH refuses to use it.

If you ever see `Permissions 0644 for ... are too open`, fix them with:
```bash
chmod 700 ~/.ssh                  # Only you can enter and list ~/.ssh
chmod 600 ~/.ssh/id_ed25519        # Only you can read/write the private key
chmod 644 ~/.ssh/id_ed25519.pub    # Public key can be world-readable
```

---

## 🔑 Method 2: HTTPS with Personal Access Token (Fallback)

If SSH port 22 is blocked by a corporate firewall or proxy, use HTTPS with a Personal Access Token (PAT).

### Step 1: Generate a Token
1. Go to [GitHub Developer Settings $\to$ Tokens (classic)](https://github.com/settings/tokens/new).
2. Note: `laptop-wsl-token`.
3. Expiration: 90 days or custom.
4. Scope: check **`repo`** (Full control of private repositories).
5. Click **Generate token** and copy the string (`ghp_...`).

### Step 2: Configure Git Credential Store
Store credentials on disk so you only enter the token once:
```bash
# Enable permanent credential caching on your local machine
git config --global credential.helper store

# Ensure remote is HTTPS
git remote set-url origin https://github.com/varienjanitra/ai-skills.git

# Push
git push origin main
```
- **Username:** `varienjanitra`
- **Password:** *[Paste the `ghp_...` token]* *(No characters will appear while pasting)*.

Credentials are saved in `~/.git-credentials`.

---

## 🛠️ Remote Switching & Diagnostic Cheatsheet

### Check Active Remote
```bash
git remote -v
```

### Switch Remote Protocols
```bash
# Switch to SSH:
git remote set-url origin git@github.com:varienjanitra/ai-skills.git

# Switch to HTTPS:
git remote set-url origin https://github.com/varienjanitra/ai-skills.git
```

### Diagnostic & Troubleshooting

#### Tip: Using Passphrases with `ssh-agent` (Avoid Retyping Every Time)
If you created your key with a passphrase (an excellent security practice), you can unlock it once per terminal session so you don't type it on every push:
```bash
# Start ssh-agent in the background and load your key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```
*(To make this automatic on opening your terminal, add those two lines to the bottom of `~/.bashrc`).*

#### Error: `Permission denied (publickey)`
1. Check if your SSH key is loaded into your agent:
   ```bash
   ssh-add -l
   # If empty, add it:
   ssh-add ~/.ssh/id_ed25519
   ```
2. Verify GitHub recognizes the key:
   ```bash
   ssh -T git@github.com
   ```

#### Error: `Host key verification failed`
Your `~/.ssh/known_hosts` file is missing GitHub's fingerprint or contains a stale entry:
```bash
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
```

#### Error: `fatal: Authentication failed for 'https://github.com/...'`
You entered your GitHub website password instead of a Personal Access Token (`ghp_...`). Generate a PAT with `repo` scope and paste that as the password.

---

## 🔒 Security Invariants for AI & Humans

1. **Never commit `.ssh/` files into Git.** Keep `.ssh/` exclusively in `~/.ssh/`, never inside a workspace or repository directory.
2. **Never hardcode tokens in scripts.** If writing automation scripts, read tokens from environment variables (e.g., `GITHUB_TOKEN`), never raw text.
3. **Audit keys annually.** Visit [GitHub SSH and GPG keys](https://github.com/settings/keys) and delete old keys from decommissioned machines or reinstalled operating systems.
