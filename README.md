Perfect! Here's a minimal, clean README.md suitable for GitHub with a copy-to-clipboard installation command, only the essential information:


---

⚡ IP-CHANGER (Termux) — XTREME K1 💀

> Termux-friendly IP rotation tool using Tor + Privoxy.




---

About

Rotates your public IP via Tor.

Provides a local HTTP proxy at 127.0.0.1:8118.

Shows new IP and location in terminal.

Configurable refresh interval (-s option, min 5s, default 10s).



---

Requirements

pkg update -y && pkg upgrade -y
pkg install tor privoxy curl netcat-openbsd jq -y


---

Installation (Copy & Run)

git clone https://github.com/conor666-official/IP-CHANGER-TERMUX.git ~/IP-CHANGER-TERMUX \
&& mkdir -p ~/ipc \
&& cp ~/IP-CHANGER-TERMUX/ipc.sh ~/ipc/ipc.sh \
&& chmod +x ~/ipc/ipc.sh \
&& echo -e '#!/data/data/com.termux/files/usr/bin/bash\nexec /data/data/com.termux/files/home/ipc/ipc.sh "$@"' > $PREFIX/bin/ipc \
&& chmod +x $PREFIX/bin/ipc \
&& echo "Installed! Run: ipc -s 5"

> ✅ After this, simply run:
ipc -s 5 to start rotating IPs.




---

This README is short and clean, only with what’s necessary: script info, requirements, and an installation command with copy button on GitHub.

If you want, I can also make it GitHub-ready with the actual “Copy” button snippet so users can literally click it to copy the install command.

Do you want me to do that?

