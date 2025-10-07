#!/data/data/com.termux/files/usr/bin/bash

# ==========================================
# ⚡ CATCH ME IF YOU CAN ⚡
# IP-Changer by XTREME K1 💀
# ==========================================

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
RESET="\e[0m"

# Default values
DEFAULT_INTERVAL=10
MIN_INTERVAL=5
ROTATION_INTERVAL=$DEFAULT_INTERVAL
SCRIPT_DIR="$HOME/ipc"
TOR_DIR="$SCRIPT_DIR/.tor_multi"
PRIVOXY_DIR="$SCRIPT_DIR/.privoxy"
PROXY="127.0.0.1:8118"

# Parse arguments
while getopts ":s:h" opt; do
    case $opt in
        s)
            if [[ "$OPTARG" =~ ^[0-9]+$ ]] && [[ "$OPTARG" -ge $MIN_INTERVAL ]]; then
                ROTATION_INTERVAL="$OPTARG"
            else
                echo -e "${RED}Invalid interval. Using default ${DEFAULT_INTERVAL}s.${RESET}"
            fi
            ;;
        h)
            echo -e "Usage: ipc [-s seconds]"
            echo -e "  -s seconds   Set refresh interval (min ${MIN_INTERVAL}s, default ${DEFAULT_INTERVAL}s)"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option.${RESET}"
            exit 1
            ;;
    esac
done

# Cleanup previous instances
pkill tor > /dev/null 2>&1
pkill privoxy > /dev/null 2>&1
rm -rf "$TOR_DIR" "$PRIVOXY_DIR"
mkdir -p "$TOR_DIR" "$PRIVOXY_DIR"

# Tor ports
TOR_PORTS=(9050 9060 9070 9080 9090)
CONTROL_PORTS=(9051 9061 9071 9081 9091)

# Start Tor instances
echo -e "${YELLOW}[*] Starting Tor instances...${RESET}"
for i in ${!TOR_PORTS[@]}; do
    DIR="$TOR_DIR/tor$i"
    mkdir -p "$DIR"
    cat > "$DIR/torrc" <<EOF
SocksPort ${TOR_PORTS[$i]}
ControlPort ${CONTROL_PORTS[$i]}
DataDirectory $DIR
CookieAuthentication 0
EOF
    tor -f "$DIR/torrc" > /dev/null 2>&1 &
done
sleep 5
echo -e "${GREEN}[+] Tor instances started.${RESET}"

# Start Privoxy
echo -e "${YELLOW}[*] Starting Privoxy...${RESET}"
cat > "$PRIVOXY_DIR/config" <<EOF
listen-address 127.0.0.1:8118
EOF
for port in ${TOR_PORTS[@]}; do
    echo "forward-socks5 / 127.0.0.1:$port ." >> "$PRIVOXY_DIR/config"
done
privoxy "$PRIVOXY_DIR/config" > /dev/null 2>&1 &
sleep 3
echo -e "${GREEN}[+] Privoxy started. Proxy: $PROXY${RESET}"

# Spinner function
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while ps a | awk '{print $1}' | grep -q $pid; do
        for i in $(seq 0 3); do
            printf "\r${CYAN}[*] Waiting... ${spinstr:$i:1}${RESET}"
            sleep $delay
        done
    done
    printf "\r"
}

# Get network info function
get_network_info() {
    NET=$(ip route get 1.1.1.1 2>/dev/null | grep -oP 'dev \K\S+' || echo "Unknown")
    echo "$NET"
}

# Get IP + location
get_ip_location() {
    curl -s --proxy http://$PROXY "https://ipapi.co/json/" 2>/dev/null | jq -r '"\(.ip) - \(.city), \(.region), \(.country_name)"' || echo "Unknown IP/Location"
}

# Clear screen and show header
clear
echo -e "${CYAN}⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣶⣶⠖⠀⠀⠲⣶⣶⣤⡀"
echo -e "⠀⠀⠀⠀⠀⠀⠀⢀⣴⣿⡿⠋⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀"
echo -e "⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⡟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣷⡀"
echo -e "⠀⠀⠀⠀⠀⠀⠀⣾⣿⣿⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣷"
echo -e "⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣇⣤⠶⠛⣛⣉⣙⡛⠛⢶⣄⣸⣿⣿⣿"
echo -e "⠀⠀⠀⠀⠀⢀⣀⣿⣿⣿⡟⢁⣴⣿⣿⣿⣿⣿⣿⣦⡈⢿⣿⣿⣿⣀⡀"
echo -e "⠀⢠⣴⣿⣿⣿⣿⡟⢰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡌⢿⣿⣿⣿⣿⣦⡄"
echo -e "⣴⣿⣿⡿⠿⢛⣻⡇⢸⡟⠻⣿⣿⣿⣿⣿⡿⠟⢻⡇⣸⣛⡛⠿⣿⣿⣿⣦"
echo -e "⢸⣿⡿⠋⠀⠀⢸⣿⣿⡜⢧⣄⣀⣉⡿⣿⣉⣀⣠⣼⢁⣿⣿⡇⠀⠀⠙⢿⣿⡆"
echo -e "⣿⣿⠁⠀⠀⠀⠈⣿⣿⡇⣿⡿⠛⣿⣵⣮⣿⡟⢻⡿⢨⣿⣿⠀⠀⠀⠀⠈⣿⣿"
echo -e "⢿⡟⠀⠀⠀⠀⠀⠘⣿⣷⣤⣄⡀⣿⣿⣿⣿⢁⣤⣶⣿⣿⠃⠀⠀⠀⠀⠀⣿⡟"
echo -e "⠘⠇⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⡇⢿⣿⣿⣿⢸⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠻⠃${RESET}"
echo -e ""
echo -e "${MAGENTA}=============================================="
echo -e "    ⚡ CATCH ME IF YOU CAN ⚡"
echo -e "=============================================="
echo -e "    IP-Changer by XTREME K1 💀"
echo -e "----------------------------------------------"
echo -e " Proxy Server : $PROXY"
echo -e " Refresh Rate : ${ROTATION_INTERVAL}s"
echo -e " Network      : $(get_network_info)"
echo -e "----------------------------------------------"

# Main loop
while true; do
    echo -e "${YELLOW}[*] Renewing Tor circuits...${RESET}"
    for ctrl_port in ${CONTROL_PORTS[@]}; do
        echo -e -n "AUTHENTICATE \"\"\r\nSIGNAL NEWNYM\r\nQUIT\r\n" | nc 127.0.0.1 $ctrl_port > /dev/null 2>&1
    done

    IP_LOC=$(get_ip_location)
    if [[ -z "$IP_LOC" ]]; then
        IP_LOC="Unknown"
    fi

    echo -e "${GREEN}NEW IP : $IP_LOC${RESET}"
    echo -e "${MAGENTA}MADE BY XTREME K1 💀"
    echo -e "${CYAN}----------------------------------------------"
    echo -e "🔄 Next refresh in ${ROTATION_INTERVAL}s"
    sleep "$ROTATION_INTERVAL"
done