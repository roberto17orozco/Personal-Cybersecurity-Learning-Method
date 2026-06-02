#!/usr/bin/env bash
#
# Network Traffic Analyzer (Local) - PRO Version
# Modular Architecture with Development Design Order Construction Order.
# Designed in a public cafe, executed in a private home network
# Requires: tshark or tcpdump


set -o errexit
set -o pipefail
set -o nounset


#############################################
# 1. GLOBAL CONFIG & CORE STATE (Core-First)
#############################################

VERSION="1.0.0"
DEFAULT_IFACE="eth0"
DEFAULT_CAPTURE_DURATION=20
DEFAULT_WATCH_INTERVAL=60
DEFAULT_CAPTURE_DIR="$HOME/network_captures"
MIN_SUSPICIOUS_PORTS=10

CAPTURE_TOOL=""


#############################################
# 2. UTILITY LAYER (Cross-cutting utilities)
#############################################


# Color definitions for status messages
BLUE="\e[34m"
RESET="\e[0m"

log_info() { echo "[+] $*"; }
log_warn() { echo "[!] $*" >&2; }
log_error() { echo "[-] $*" >&2; }

timestamp () { date +"%Y-%m-%d_%H-%M-%S"; }

require_cmd() {
    local cmd="$1"
    command -v "$cmd" >/dev/null 2>&1
}

init_capture_dir() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
        log_info "Capture directory created: $dir"
    fi
}

detect_capture_tool() {
    if require_cmd tshark; then
        CAPTURE_TOOL="tshark"
        log_info "Using tshark as capture tool."
    elif require_cmd tcpdump; then
        CAPTURE_TOOL="tcpdump"
        log_info "Using tcpdump as capture tool."
    else
        log_error "Neither tshark nor tcpdump is installed."
        exit 1
    fi
}


#######################################
# 3. CORE CAPTURE ENGINE
#######################################

run_capture_once() {
    local iface="$1"
    local duration="$2"
    local out_dir="$3"

    
    local ts
    ts="$(timestamp)"
    local pcap_file="${out_dir}/capture_${ts}.pcap"

    log_info "Starting packet capture on ${iface} for ${duration}s..." >&2
    
    case "$CAPTURE_TOOL" in
        tshark)
            tshark -i "$iface" -a "duration:${duration}" -w "$pcap_file"
            ;;
        tcpdump)
            timeout --signal=INT "${duration}" tcpdump -i "$iface" -w "$pcap_file" > /dev/null 2>&1 || true
            ;;
    esac

    if [[ -f "$pcap_file" ]]; then
        log_info "Capture completed: $pcap_file" >&2
    else
        log_warn "Capture file was not created." >&2
    fi

    echo "$pcap_file"
}

######################################
# 4. CORE ANALYSIS PRIMITIVES
######################################

analyze_protocols() {
    local pcap="$1"
    [[ -f "$pcap" ]] || { echo "No pcap file available."; return; }

    if [[ "$CAPTURE_TOOL" == "tshark" ]]; then
        tshark -r "$pcap" -q -z io,phs 2>/dev/null
    else
        tcpdump -nn -r "$pcap" 2>/dev/null \
            | awk '{print $5}' | sed 's/://g' \
            | awk -F'.' '{print $NF}' \
            | sort | uniq -c | sort -nr
    fi
}

analyze_endpoints() {
    local pcap="$1"
    [[ -f "$pcap" ]] || { echo "No pcap file available."; return; }
    
    if [[ "$CAPTURE_TOOL" == "tshark" ]]; then
        tshark -r "$pcap" -q -z endpoints,ip 2>/dev/null
    else
        tcpdump -nn -r "$pcap" 2>/dev/null \
            | awk '{print $3, $5}' | sed 's/://g' \
            | sort | uniq -c | sort -nr | head -50
    fi
}

analyze_connections() {
    local pcap="$1"
    [[ -f "$pcap" ]] || { echo "No pcap file available."; return; }

    if [[ "$CAPTURE_TOOL" == "tshark" ]]; then
        tshark -r "$pcap" -T fields \
            -e ip.src -e tcp.srcport -e ip.dst -e tcp.dstport -e tcp.flags\
            -Y "tcp" 2>/dev/null \
            | awk 'NF==5 {printf "%-15s:%-5s -> %-15s:%-5s flags=%s\n", $1,$2,$3,$4,$5}' \
            | sort | uniq -c | sort -nr | head -50
    else
        tcpdump -nn -r "$pcap" tcp 2>/dev/null \
            | awk '{print $3, $5}' | sed 's/://g' \
            | sort | uniq -c | sort -nr | head -50
    fi
}


#########################################
# 5. SUSPICIOUS PATTERN EVALUATOR
#########################################

detect_suspicious_activity() {
    local pcap="$1"
    [[ -f "$pcap" ]] || { echo "No pcap file available."; return; }

    echo "===== Suspicious Activity (simple heuristic) ====="

    if [[ "$CAPTURE_TOOL" == "tshark" ]]; then
        tshark -r "$pcap" -T fields \
            -e ip.src -e ip.dst -e tcp.dstport \
            -Y "tcp" 2>/dev/null \
            | awk 'NF==3 {print $1, $2, $3}' \
            | sort | uniq \
            | awk '{key=$1"->"$2; ports[key]=ports[key]","$3}
            END {for (k in ports) {n=split(ports[k],a,","); if (n > '"$MIN_SUSPICIOUS_PORTS"') print k" ports="n}}' \
        | sort -k2 -nr
else
    tcpdump -nn -r "$pcap" tcp 2>/dev/null \
        | awk '{print $3, $5}' | sed 's/://g' \
        | sort | uniq \
        | awk '{key=$1"->"$2; c[key]++}
        END {for (k in c) if (c[k] > '"$MIN_SUSPICIOUS_PORTS"') print k" connections="c[k]}' \
    | sort -k2 -nr
    fi
}


#####################################
# 6. REPORT BUILDER
#####################################

build_report () {
    local pcap="$1"
    local out_dir="$2"

    [[ -f "$pcap" ]] || { log_warn "Cannot build report: pcap missing."; return; }

    local ts
    ts="$(timestamp)"
    local report="${out_dir}/network_traffic_report_${ts}.txt"

    set +e
    set +u
    {
        echo "==============================================="
        echo " Network Traffic Analyzer (Local) - Report"
        echo " Version: ${VERSION}"
        echo " Date:    $(date)"
        echo " File:    ${pcap}"
        echo "==============================================="
        echo
        echo "1. Protocol Summary"
        echo "-------------------"
        analyze_protocols "$pcap"
        echo
        echo "2. IP Endpoints"
        echo "--------------"
        analyze_endpoints "$pcap"
        echo
        echo "3. TCP Connections"
        echo "-------------------"
        analyze_connections "$pcap"
        echo
        echo "4. Suspicious Activity"
        echo "----------------------"
        detect_suspicious_activity "$pcap"
        echo
        echo "5. Notes"
        echo "--------"
        echo "- This report was generated from real captured traffic."
        echo "- For best results, generate traffic from Ubuntu to Kali (ping, ssh, curl, nmap)."
        echo "- Execute this script in your private home network, not in public Wi-Fi."
        echo
} > "$report" 2>&1
set -e
set -u

log_info "Report generated: $report"
}

#############################################
# 7. ORCHESTRATOR (Single & Watch Mode)
#############################################

run_single_capture_and_report() {
    local iface="$1"
    local duration="$2"
    local out_dir="$3"

    echo -e "${BLUE}[STATUS] Initializing capture directory...${RESET}"
    init_capture_dir "$out_dir"

    echo -e "${BLUE}[STATUS] Detecting capture tool...${RESET}"
    detect_capture_tool

    local pcap

    echo -e "${BLUE}[STATUS] Starting packet capture...${RESET}"
    pcap="$(run_capture_once "$iface" "$duration" "$out_dir")"

    echo -e "${BLUE}[STATUS] Analyzing captured traffic...${RESET}"
    echo -e "${BLUE}[STATUS] Generating report...${RESET}"
    [[ -f "$pcap" ]] && build_report "$pcap" "$out_dir"

    echo -e "${BLUE}[STATUS] Process completed.${RESET}"
}


run_watch_mode() {
    local iface="$1"
    local duration="$2"
    local interval="$3"
    local out_dir="$4"

    init_capture_dir "$out_dir"
    detect_capture_tool

    echo -e "${BLUE}[STATUS] Watch Mode started...${RESET}"
    log_info "Watch Mode started."

    while true; do
        local pcap
        echo -e "${BLUE}[STATUS] Starting continuous capture iteration...${RESET}"
        pcap="$(run_capture_once "$iface" "$duration" "$out_dir")"
        echo -e "${BLUE}[STATUS] Analyzing captured traffic (continuous mode)...${RESET}"
        echo -e "${BLUE}[STATUS] Generating report (continuous mode)...${RESET}"

        [[ -f "$pcap" ]] && build_report "$pcap" "$out_dir"

        echo -e "${BLUE}[STATUS] Waiting ${interval}s before next iteration...${RESET}"
        log_info "Waiting ${interval}s before next iteration..."
        sleep "$interval"
    done
}

#######################################
# 8. CLI HANDLER
#######################################

print_usage() {
    cat <<EOF
    Network Traffic Analyzer (Local) - v${VERSION}

    Usage:
    $(basename "$0") [-i interface] [-d duration] [-o directory] [--watch] [--interval seconds]
    Options:
    -i IFACE        Network interface (default: ${DEFAULT_IFACE})
    -d SECONDS      Capture duration (default: ${DEFAULT_CAPTURE_DURATION})
    -o DIR          Output directory (default: ${DEFAULT_CAPTURE_DIR})
    --watch         Enable Watch Mode
    --interval N    Seconds between iterations (default: ${DEFAULT_WATCH_INTERVAL})
    -h, --help      Show this help message
EOF
}

main() {
    echo -e "${BLUE}[STATUS] Starting Network Traffic Analyzer...${RESET}"

local iface="${DEFAULT_IFACE}"
local duration="${DEFAULT_CAPTURE_DURATION}"
local out_dir="${DEFAULT_CAPTURE_DIR}"
local watch="false"
local interval="${DEFAULT_WATCH_INTERVAL}"


while [[ $# -gt 0 ]]; do
case "$1" in
    -i) iface="$2"; shift 2 ;;
    -d) duration="$2"; shift 2 ;;
    -o) out_dir="$2"; shift 2 ;;
    --watch) watch="true"; shift ;;
    --interval) interval="$2"; shift 2 ;;
    -h|--help) print_usage; exit 0 ;;
    *) log_error "Unknown option: $1"; exit 1 ;;
esac
done

if [[ "$watch" == "true" ]]; then
run_watch_mode "$iface" "$duration" "$interval" "$out_dir"
else
run_single_capture_and_report "$iface" "$duration" "$out_dir"
fi
}

main "$@"
