#!/usr/bin/env bash
#
# System Hardening Checker - PRO Version
# Core-First DDCO Architecture

set -o errexit
set -o pipefail
set -o nounset

############################################
# 1. GLOBAL CONFIG & CORE STATE
############################################

VERSION="1.0.0"
REPORT_DIR="$HOME/Documents/Cybersecurity/01_Linux_LFS101x/scripts/cybersecurity_scripts/09_System_Hardening_Checker_PRO"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
REPORT_FILE="${REPORT_DIR}/hardening_report_${TIMESTAMP}.txt"

###############################################
# 2. UTILITY LAYER (Cross-cutting utilities)
###############################################

# ANSI Colors
BLUE="\e[34m"
GREEN="\e[32m"
YELLOW="\e[33m"
RED="\e[31m"
RESET="\e[0m"

# Logging utilities
log_info()      { echo "[+] $*"; }
log_warn()      { echo "[!] $*"; }
log_error()     { echo "[-] $*" >&2; }

# Status messages (blue)
status () { echo -e "${BLUE}[STATUS] $*${RESET}"; }

ensure_report_dir() {
    [[ -d "$REPORT_DIR" ]] || mkdir -p "$REPORT_DIR"
}

################################################
# 3. CORE MODULE - SYSTEM HARDENING ENGINE
################################################
# This is the dominant conceptual module.
# It defines the purpose of the script: evaluate system hardening posture.
#
run_hardening_checks() {
    status "Running core hardening checks..."

    set +e
    {
        echo "========================================"
        echo " System Hardening Report"
        echo " Version: $VERSION"
        echo " Date: $(date)"
        echo "========================================"
        echo
        echo "1. File Permissions"
        echo "----------------------"
        check_critical_permissions
        echo
        echo "2. Running Services"
        echo "----------------------"
        check_running_services
        echo
        echo "3. World-Writable Files"
        echo "-------------------------"
        check_world_writable
        echo
        echo "4. SUID/SGID Binaries"
        echo "-----------------------"
        check_suid_sgid
        echo
        echo "5. Firewall Status"
        echo "-----------------------"
        check_firewall
        echo
        echo "6. SSH Configuration"
        echo "-----------------------"
        check_ssh_config
        echo
    } > "$REPORT_FILE"
    set -e

    log_info "Report generated: $REPORT_FILE"
}

#############################################
# 4. SUPPORTING EVALUATORS
#############################################

check_critical_permissions() {
    # Critical system files and their expected permissions
    declare -A expected_perms=(
        ["/etc/passwd"]=644
        ["/etc/group"]=644
        ["/etc/shadow"]=640
        ["/etc/gshadow"]=640
        ["/etc/sudoers"]=440
    )



    for f in "${!expected_perms[@]}"; do
        if [[ -e "$f" ]]; then
            perms=$(stat -c "%a" "$f")
            expected="${expected_perms[$f]}"

            echo "$f permissions: $perms"

            # Special rule: passwd and group are allowed to be 644
            if [[ "$f" == "/etc/passwd" || "$f" == "/etc/group" ]]; then
                if [[ "$perms" -ne 644 ]]; then
                    log_warn "$f has non-standard permissions ($perms), expected 644"
                else
                    log_info "$f permissions are secure ($perms)"
                fi
                continue
            fi

            # For shadow, gshadow, sudoers
            if [[ "$perms" -ne "$expected" ]]; then
                log_warn "$f has weak permissions ($perms), expected $expected"
            else
                log_info "$f permissions are secure ($perms)"
            fi
        else
            log_error "$f not found"
        fi
    done
}


check_running_services() {
    local suspicious=("telnet" "vsftpd" "rsh" "rexec")

    for svc in "${suspicious[@]}"; do
        if systemctl is-active --quiet "$svc"; then
            log_warn "Suspicious service running: $svc"
        else
            log_info "Service not running: $svc"
        fi
    done
}


check_world_writable() {
    local count
    count=$(find / -xdev -type f -perm -0002 2>/dev/null | wc -l)
    echo "World-writable files: $count"

    if [[ "$count" -gt 50 ]]; then
        log_warn "High number of world-writable files"
    else
        log_info "World-writable files count acceptable"
    fi
}

check_suid_sgid() {
    local count
    count=$(find / -xdev \( -perm -4000 -o -perm -2000 \) 2>/dev/null | wc -l)

    echo "SUID/SGID binaries: $count"

    if [[ "$count" -gt 100 ]]; then
        log_warn "High number of SUID/SGID binaries"
    else
        log_info "SUID/SGID count acceptable"
    fi
}

check_firewall() {
    if command -v ufw >/dev/null 2>&1; then
        ufw status | sed 's/^/    /'
    else
        log_warn "UFW not installed"
    fi
}

check_ssh_config() {
    if [[ -f /etc/ssh/sshd_config ]]; then
        if grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config; then
            log_warn "Root login over SSH is enabled"
        else
            log_info "Root login over SSH is disabled"
        fi
    else
        log_error "SSH configuration file not found"
    fi
}

#######################################
# 5. ORCHESTRATOR MODULE
#######################################

run_system_hardening() {
    status "Initializing report directory..."
    ensure_report_dir

    status "Starting hardening evaluation..."
    run_hardening_checks

    status "Process completed."
}

########################################
# 6. CLI HANDLER
########################################

print_usage() {
    echo "System Hardening Checker - v$VERSION"
    echo
    echo "Usage:"
    echo "  $(basename "$0")"
    echo
}


main() {
    status "Starting System Hardening Checker..."

    if [[ $# -gt 0 ]]; then
        print_usage
        exit 1
    fi

    run_system_hardening
}

main "$@"
