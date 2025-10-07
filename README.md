# ⚡ IP-CHANGER (Termux) — XTREME K1 💀

> Termux-friendly Tor + Privoxy IP rotation utility with a live terminal dashboard.  
> Lightweight, configurable and styled for mobile Termux users.

![Preview](./demo-screenshot.txt) <!-- optional: add screenshot or ascii preview file -->

---

## 🔥 Features

- Starts Tor instances and Privoxy to create a local HTTP proxy at `127.0.0.1:8118`.
- Rotate public IPs by signalling Tor (`SIGNAL NEWNYM`) and fetching IP via Privoxy.
- Live ASCII dashboard (colors, emojis) showing:
  - Current IP, city/region/country
  - Network interface / connection
  - Progress bar & countdown for next rotation
  - Recent IP history
- Configurable refresh interval: default 10s, minimum 5s (`ipc -s 5`).
- Termux optimized (uses `~/ipc` for all runtime files and logs).
- Optional dependencies: `jq` (preferred), `termux-api` (optional network detection).

---

## ⚙️ Requirements (Termux)

Install required packages:

```bash
pkg update -y && pkg upgrade -y
pkg install tor privoxy curl netcat-openbsd -y
# recommended:
pkg install jq termux-api -y
