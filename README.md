Got it! Here's a full, polished README.md for your IP-CHANGER (XTREME K1) project on GitHub. I’ve written it so you can directly place it in your repo, with sections for preview, installation, usage, troubleshooting, and features.


---

⚡ IP-CHANGER (Termux) — XTREME K1 💀

> Termux-friendly Tor + Privoxy IP rotation utility with a live terminal dashboard.




---

Preview

⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⠖⠀⠀⠲⣶⣶⣤⡀
⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡿⠋⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀
⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⡀
⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣷
⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣇⣤⠶⠛⣛⣉⣙⡛⠛⢶⣄⣸⣿⣿⣿
==============================================
    ⚡ CATCH ME IF YOU CAN ⚡
==============================================
    IP-Changer by XTREME K1 💀
----------------------------------------------
 Proxy Server : 127.0.0.1:8118
 Refresh Rate : 5s
 Network      : Tor (SOCKS5)
----------------------------------------------
[*] Renewing Tor circuits...
NEW IP : 185.177.238.26 - London, England, UK
MADE BY XTREME K1 💀
----------------------------------------------
🔄 Next refresh in 5s


---

Features

Starts multiple Tor instances + Privoxy.

Rotates public IPs using Tor's SIGNAL NEWNYM.

Local HTTP proxy available at 127.0.0.1:8118.

Live terminal dashboard showing:

Current IP

Location (City, Region, Country)

Network type (Wi-Fi / Mobile)

Countdown to next IP rotation

Recent IP history


Configurable refresh interval (-s option, min 5s, default 10s).

Lightweight and Termux-friendly.

Optional dependencies:

jq for JSON parsing.

termux-api for better network detection.




---

Requirements

pkg update -y && pkg upgrade -y
pkg install tor privoxy curl netcat-openbsd -y
# Optional but recommended:
pkg install jq termux-api -y


---

Installation via Git Clone

# Clone repo
git clone https://github.com/conor666-official/IP-CHANGER-TERMUX.git
cd IP-CHANGER-TERMUX

# Copy script to runtime folder
mkdir -p ~/ipc
cp ipc.sh ~/ipc/ipc.sh
chmod +x ~/ipc/ipc.sh

# Create global launcher
cat > $PREFIX/bin/ipc <<'SH'
#!/data/data/com.termux/files/usr/bin/bash
exec /data/data/com.termux/files/home/ipc/ipc.sh "$@"
SH
chmod +x $PREFIX/bin/ipc

# Run
ipc -s 5


---

Quick Install (One-liner)

pkg update -y && pkg upgrade -y && pkg install tor privoxy curl netcat-openbsd jq termux-api -y
git clone https://github.com/conor666-official/IP-CHANGER-TERMUX.git ~/IP-CHANGER-TERMUX
mkdir -p ~/ipc
cp ~/IP-CHANGER-TERMUX/ipc.sh ~/ipc/ipc.sh
chmod +x ~/ipc/ipc.sh
cat > $PREFIX/bin/ipc <<'SH'
#!/data/data/com.termux/files/usr/bin/bash
exec /data/data/com.termux/files/home/ipc/ipc.sh "$@"
SH
chmod +x $PREFIX/bin/ipc
echo "Installed. Run: ipc -s 5"


---

Usage

ipc [-s SECONDS] [-h]

Options:
  -s SECONDS    Set rotation interval (minimum 5 sec, default 10)
  -h            Show this help message


---

Runtime Layout

~/ipc/
  ├─ .tor_multi/    # Tor instance data
  ├─ .privoxy/      # Privoxy configs
  └─ logs/          # Tor & Privoxy logs + IP history


---

Troubleshooting

Permission denied / Is a directory:


rm -rf $PREFIX/bin/ipc
# recreate launcher as shown in installation

Could not fetch IP:

Wait a few seconds for Tor to bootstrap.

Check Tor logs:

tail -n 200 ~/ipc/.tor_multi/tor0/notice.log


Missing nc or netcat:


pkg install netcat-openbsd


---

License

MIT License — see LICENSE file in repository.


---

I can also make a GitHub-ready version with badges, syntax highlighting, and a “copy command” section so users can install with a single click, just like professional repos.

Do you want me to do that next?

