#!/usr/bin/env bash
#
# Log Correlation Engine (Mini-SIEM) - PRO Version
# Core-First DDCO Architecture (Journalctl Edition)
#
set -o errexit
set -o pipefail
set -o nounset


#########################################
# 1. GLOBAL CONFIG & CORE STATE
#########################################

VERSION="1.1.0"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
REPORT_DIR="/home/robert/Documents/Cybersecurity/01_Linux_LFS101x/scripts/cybersecurity_scripts/10_Log_Correlation_Engine-Mini-SIEM_PRO"
REPORT_FILE="${REPORT_DIR}/correlation_report_${TIMESTAMP}.txt"

################################################
# 2. UTILITY LAYER (Cross-cutting utilities)
################################################

# Ansi Colors
BLUE="\e[34m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Logging utilities with prefixes

log_info()  { echo -e "${GREEN}[+]${RESET} $*"; }
log_warn()  { echo -e "${YELLOW}[!]${RESET} $*"; }
log_error() { echo -e "${RED}[-]${RESET} $*" >&2; }
log_status()    { echo -e "${BLUE}[STATUS]${RESET} $*"; }


ensure_report_dir() {
    [[ -d "$REPORT_DIR" ]] || mkdir -p "$REPORT_DIR"
}

################################################
# 3. CORE MODULE - CORRELATION ENGINE
################################################

run_correlation_engine() {
    log_status "Running correlation engine..."

    set +e
    {
        echo "============================================="
        echo " Log Correlation Engine (Mini-SIEM)"
        echo " Version: $VERSION"
        echo " Date: $(date)"
        echo "============================================="
        echo
        echo "1. Failed SSH Attempts"
        echo "------------------------------"
        correlate_failed_ssh
        echo
        echo "2. Suspicious Root Activity"
        echo "------------------------------"
        correlate_root_activity
        echo
        echo "3. Kernel Security Events"
        echo "------------------------------"
        correlate_kernel_security
        echo
        echo "4. Multi-Source Alert Correlation"
        echo "------------------------------"
        correlate_multi_source
        echo
    } > "$REPORT_FILE"
    set -e

    log_info "Correlation report generated: $REPORT_FILE"
}

###############################################
# 4. SUPORTING EVALUATORS (Journalctl-based)
###############################################

correlate_failed_ssh() {
    journalctl -u ssh --no-pager --since "24 hours ago" \
        | grep "Failed password" \
        | awk '{print $1, $2, $3, $11}' \
        || log_warn "No failed SSH attempts found"
}

correlate_root_activity() {
    journalctl -u ssh --no-pager --since "24 hours ago" \
        | grep "session opened for user root" \
        | awk '{print $1, $2, $3, $11}' \
        || log_warn "No root SSH sessions found"
}

correlate_kernel_security() {
    journalctl -k --no-pager --since "24 hours ago" \
        | grep -Ei "audit|apparmor|denied|security" \
        || log_warn "No kernel security events found"
}

correlate_multi_source() {
    log_info "Correlating SSH failures with sudo events (24h window)..."

    # ------------------------------
    # 1. Get SSH failures (only once)
    # ------------------------------
    mapfile -t ssh_failures < <(
        journalctl -u ssh --no-pager --since "24 hours ago" \
            | grep "Failed password" \
            | awk '{print $1" "$2" "$3, $11}'
        )

    # ------------------------------
    # 2. Get sudo events (only once)
    # ------------------------------
    mapfile -t sudo_events < <(
        journalctl -t sudo --no-pager --since "24 hours ago"
    )

    # If no events, exit
    [[ ${#ssh_failures[@]} -eq 0 ]] && {
        log_warn "No SSH failures detected"
        return
    }   

    [[ ${#sudo_events[@]} -eq 0 ]] && {
        log_warn "No sudo events detected"
        return
    }

    # ------------------------------
    # 3. Actual correlation
    # ------------------------------
    local correlated=0

    for entry in "${ssh_failures[@]}"; do
        ts=$(awk '{print $1" "$2" "$3}' <<< "$entry")
        ip=$(awk '{print $4}' <<< "$entry")

        epoch=$(date -d "$ts" +"%s" 2>/dev/null || echo 0)

        for line in "${sudo_events[@]}"; do
            log_ts=$(awk '{print $1" "$2" "$3}' <<< "$line")
            log_epoch=$(date -d "$log_ts" +"%s" 2>/dev/null || echo 0)

            # Correlation window: 60 seconds
            if (( log_epoch >= epoch && log_epoch <= epoch+60 )); then
                echo "[CORRELATED] SSH failure from $ip followed by sudo event: $line"
                correlated=1
            fi
        done
    done

    # -----------------------------
    # 4. Final result
    # -----------------------------
    (( correlated == 0 )) && log_warn "No multi-source correlations detected"
}


########################################
# 5. ORCHESTRATOR MODULE
########################################

run_engine() {
    log_status "Initializing report directory..."
    ensure_report_dir
    
    log_status "Starting correlation engine..."
    run_correlation_engine

    log_status "Process completed."
}


##########################################
# 6. CLI HANDLER
##########################################

print_usage() {
    echo "Log Correlation Engine (Mini-SIEM) -v$VERSION"
    echo
    echo "Usage:"
    echo "  $(basename "$0")"
    echo
}


main() {
    log_status "Starting Log Correlation Engine..."

    if [[ $# -gt 0 ]]; then
        print_usage
        exit 1
    fi
    run_engine
}

main "$@"    
