#!/usr/bin/env bash

# ============================
#   ANSI COLORS
# ============================
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
CYAN="\e[36m"
RESET="\e[0m"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
OUTPUT="traffic_report_$TIMESTAMP.txt"
MIN_PORTS=10

echo -e "${CYAN}[INFO] Starting PRO++ traffic detector...${RESET}"

# ============================
#   LOCAL NETWORK INFORMATION
# ============================
echo -e "${BLUE}[INFO] Gathering local network information...${RESET}"

IFACE=$(ip route | awk '/default/ {print $5}')
LOCAL_IP=$(ip -4 addr show "$IFACE" | awk '/inet/ {print $2}' | cut -d'/' -f1)
LOCAL_MASK=$(ip -4 addr show "$IFACE" | awk '/inet/ {print $2}' | cut -d'/' -f2)
LOCAL_NET=$(ipcalc "$LOCAL_IP/$LOCAL_MASK" | awk -F': *' '/Network/ {print $2}')
LOCAL_GW=$(ip route | awk '/default/ {print $3}')

print_banner() {
    echo "=============================================="
    echo "     TRAFFIC & PORT SCAN DETECTOR (PRO++)     "
    echo "=============================================="
    echo
    echo "Local network information (victim - Kali):"
    echo "  Interface: $IFACE"
    echo "  Local IP: $LOCAL_IP"
    echo "  Netmask: /$LOCAL_MASK"
    echo "  Network: $LOCAL_NET"
    echo "  Gateway: $LOCAL_GW"
    echo
}

# ============================
#   ATTACK DETECTION
# ============================
detect_scans() {

    echo -e "${YELLOW}[INFO] Analyzing firewall logs...${RESET}"

    LOG_DATA=$(sudo journalctl -g "IPTABLES DROP" -o short)

    if [[ -z "$LOG_DATA" ]]; then
        echo "No firewall events detected." > "$OUTPUT"
        return
    fi

    echo "$LOG_DATA" | awk -v min="$MIN_PORTS" -v mask="$LOCAL_MASK" -v net="$LOCAL_NET" -v gw="$LOCAL_GW" '

        function is_private(ip) {
            split(ip, o, ".")
            return ((o[1] == 10) || (o[1] == 172 && o[2] >= 16 && o[2] <= 31) || (o[1] == 192 && o[2] == 168))
        }

        {
            ts = $1 " " $2 " " $3
            src = ""
            dpt = ""
            proto = ""
            icmp = 0
            syn = 0

            for (i=1; i<=NF; i++) {
                if ($i ~ /^SRC=/) { split($i,a,"="); src=a[2] }
                if ($i ~ /^DPT=/) { split($i,b,"="); dpt=b[2] }
                if ($i ~ /^PROTO=/) { split($i,c,"="); proto=c[2] }
                if ($i ~ /^TYPE=/) { icmp=1 }
                if ($i ~ /SYN/) { syn=1 }
            }

            if (src != "") {
                if (dpt != "") ports[src][dpt] = 1

                if (!(src in first)) first[src] = ts
                last[src] = ts

                if (proto != "") protos[src][proto]++
                if (icmp == 1) icmp_count[src]++
                if (syn == 1) syn_count[src]++

                if (dpt == 22) ssh_count[src]++
                if (dpt == 80 || dpt == 8080) http_count[src]++
                if (proto == "UDP") udp_count[src]++
            }
        }

        END {
            for (ip in first) {
                printf "Attacker IP: %s\n", ip

                if (is_private(ip))
                    printf "  IP type: Private (RFC1918)\n"
                else
                    printf "  IP type: Public\n"

                if (is_private(ip)) {
                    printf "  Victim netmask: /%s\n", mask
                    printf "  Network (CIDR): %s\n", net
                    printf "  Local gateway: %s\n", gw
                }

                port_count = 0
                minp = 99999
                maxp = 0

                for (p in ports[ip]) {
                    port_count++
                    if (p < minp) minp = p
                    if (p > maxp) maxp = p
                }

                if (port_count > 0) {
                    printf "  Distinct ports: %d\n", port_count
                    printf "  Port range: %d - %d\n", minp, maxp
                }

                printf "  First event: %s\n", first[ip]
                printf "  Last event: %s\n", last[ip]

                if (port_count >= min) {
                    if (maxp - minp <= port_count + 5)
                        printf "  Scan type: Sequential\n"
                    else
                        printf "  Scan type: Random\n"
                }

                printf "  Traffic nature:\n"

                if (icmp_count[ip] > 0)
                    printf "    - ICMP (possible ping)\n"

                if (ssh_count[ip] > 0)
                    printf "    - SSH (port 22 attempts)\n"

                if (http_count[ip] > 0)
                    printf "    - HTTP (curl or browser)\n"

                if (udp_count[ip] > 0)
                    printf "    - UDP traffic\n"

                if (syn_count[ip] > 0)
                    printf "    - SYN-only packets (possible Nmap scan)\n"

                if (port_count >= min)
                    printf "    - Port scanning (possible nmap)\n"

                if (icmp_count[ip] == 0 && ssh_count[ip] == 0 && http_count[ip] == 0 && udp_count[ip] == 0 && port_count < min)
                    printf "    - Generic TCP traffic\n"

                printf "-----------------------------\n"
            }
        }
    ' > "$OUTPUT"
}

main() {
    print_banner
    detect_scans
    echo -e "${GREEN}[OK] Report generated: ${OUTPUT}${RESET}"
}

main
