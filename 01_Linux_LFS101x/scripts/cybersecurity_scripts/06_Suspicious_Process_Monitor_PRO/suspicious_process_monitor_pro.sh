#!/usr/bin/env bash

# ============================================================
#  Suspicious Process Monitor PRO – Project 6
#  Author: Roberto Orozco
#  Purpose: Advanced detection of suspicious system activity
# ============================================================

# Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

info()  { echo -e "${BLUE}[INFO]${RESET} $1" >&2; }
ok()    { echo -e "${GREEN}[+]${RESET} $1" >&2; }
warn()  { echo -e "${YELLOW}[WARN]${RESET} $1" >&2; }

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT="process_monitor_report_$TIMESTAMP.txt"

# ============================================================
#  CONFIG
# ============================================================
CPU_THRESHOLD=25
SUSPICIOUS_DIRS=("/tmp" "/var/tmp" "/dev/shm" "/home/$USER/Downloads")
WATCH_INTERVAL=5

# ============================================================
#  HELP
# ============================================================
show_help() {
    echo "Usage: $0 [--cpu | --network | --paths | --full | --watch N]"
    exit 0
}

# ============================================================
#  UTILS
# ============================================================
log() {
    echo "$1" >> "$REPORT"
}

is_suspicious_path() {
    for dir in "${SUSPICIOUS_DIRS[@]}"; do
        [[ "$1" == $dir* ]] && return 0
    done
    return 1
}

# ============================================================
#  MODULE 1 – CPU ANOMALIES
# ============================================================
check_cpu_anomaly() {
    info "Checking for high CPU usage processes..."
    log "=== High CPU Usage Processes (> ${CPU_THRESHOLD}%) ==="
    ps aux --sort=-%cpu | awk -v th="$CPU_THRESHOLD" '
        $3 > th {
            printf "PID: %s | CPU: %s%% | USER: %s | CMD: %s\n", $2, $3, $1, $11
        }
    ' >> "$REPORT"
    ok "CPU anomaly check completed."
    log ""
}

# ============================================================
#  MODULE 2 – SUSPICIOUS EXECUTION PATHS
# ============================================================
check_suspicious_paths() {
    info "Scanning for processes running from suspicious directories..."
    log "=== Processes Running from Suspicious Directories ==="
    for pid in $(ls /proc | grep -E '^[0-9]+$'); do
        exe=$(readlink -f /proc/$pid/exe 2>/dev/null)
        [[ -z "$exe" ]] && continue

        if is_suspicious_path "$exe"; then
            cmd=$(tr -d '\0' < /proc/$pid/cmdline)
            log "PID: $pid | EXE: $exe | CMD: $cmd"
        fi
    done
    ok "Suspicious path scan completed."
    log ""
}

# ============================================================
#  MODULE 3 – NETWORK-ACTIVE PROCESSES
# ============================================================
check_network_activity() {
    info "Checking for processes with open network ports..."
    log "=== Processes with Open Network Ports ==="
    ss -tulnp 2>/dev/null | awk '
        NR>1 {
            printf "Protocol: %s | Local: %s | PID/Program: %s\n", $1, $5, $7
        }
    ' >> "$REPORT"
    ok "Network activity scan completed."
    log ""
}

# ============================================================
#  MODULE 4 – SHORT-LIVED PROCESSES
# ============================================================
check_short_lived() {
    info "Detecting short-lived processes..."
    log "=== Short-Lived Processes (appear/disappear quickly) ==="
    declare -A seen

    for i in {1..2}; do
        for pid in $(ps -e -o pid=); do
            seen[$pid]=$((seen[$pid]+1))
        done
        sleep 1
    done

    for pid in "${!seen[@]}"; do
        if [[ ${seen[$pid]} -eq 1 ]]; then
            cmd=$(ps -p $pid -o cmd= 2>/dev/null)
            log "PID: $pid | CMD: $cmd"
        fi
    done
    ok "Short-lived process detection completed."
    log ""
}

# ============================================================
#  MODULE 5 – ROOT PROCESSES (Unexpected)
# ============================================================
check_root_processes() {
    info "Checking for unexpected root processes..."
    log "=== Unexpected Root Processes ==="
    ps -U root -u root u | awk '
        $11 !~ /(systemd|NetworkManager|dbus-daemon|cron|rsyslogd|sshd)/ {
            printf "PID: %s | USER: %s | CMD: %s\n", $2, $1, $11
        }
    ' >> "$REPORT"
    ok "Root process scan completed."
    log ""
}

# ============================================================
#  FULL SCAN
# ============================================================
run_full_scan() {
    info "Generating full report: $REPORT"
    log "====================================================="
    log " Suspicious Process Monitor PRO – Full Scan"
    log " Generated: $(date)"
    log "====================================================="
    log ""

    check_cpu_anomaly
    check_suspicious_paths
    check_network_activity
    check_short_lived
    check_root_processes

    ok "Full scan completed."
    echo -e "${GREEN}[+]${RESET} Report saved to: $REPORT" >&2
}

# ============================================================
#  WATCH MODE
# ============================================================
run_watch_mode() {
    interval=$1
    info "Running continuous monitoring every $interval seconds..."
    echo "Press CTRL+C to stop." >&2

    while true; do
        REPORT="watch_report_$(date +"%H-%M-%S").txt"
        run_full_scan >/dev/null
        sleep "$interval"
    done
}

# ============================================================
#  CLI HANDLER
# ============================================================
case "$1" in
    --cpu) check_cpu_anomaly ;;
    --paths) check_suspicious_paths ;;
    --network) check_network_activity ;;
    --full) run_full_scan ;;
    --watch) run_watch_mode "$2" ;;
    *) show_help ;;
esac

# ============================================================
#  END OF SCRIPT
# ============================================================
echo -e "${BLUE}[INFO]${RESET} Suspicious Process Monitor PRO finished execution." >&2

