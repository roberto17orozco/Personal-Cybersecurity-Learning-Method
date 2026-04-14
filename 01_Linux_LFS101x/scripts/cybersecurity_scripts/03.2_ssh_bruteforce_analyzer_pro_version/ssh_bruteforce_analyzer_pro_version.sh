#!/bin/bash

###########################################
# SSH BRUTE FORCE ANALYZER (PRO VERSION)
# Author: Roberto Orozco (2026)
###########################################

#1. ---------- COLORS ----------
RED="\e[31m"
YELLOW="\e[33m"
GREEN="\e[32m"
BLUE="\e[34m"
RESET="\e[0m"



#2.  ---------- DEFAULT VALUES ----------
LOGFILE=""
OUTPUT="final_report_pro.txt"
CSV_OUTPUT=""
JSON_OUTPUT=""
ENABLE_GEO=false



#3. ---------- HELP MENU ---------
show_help() {
    echo -e "${BLUE}SSH Brute Force Analyzer (PRO VERSION)${RESET}"
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo " --logfile <file>         Use a specific log file instead of journalctl"
    echo " --output <file>          Output report file (default: final_report_pro.txt)"
    echo " --csv <file>             Export results to CSV"
    echo " --json <file>            Export results to JSON"
    echo " --geo                    Enable IP geolocation lookup"
    echo " --help                   Show this help menu"
    exit 0
}



#4. ---------- PARSE ARGUMENTS ----------
while [[ $# -gt 0 ]]; do
    case $1 in
        --logfile)
            LOGFILE="$2"
            shift 2
            ;;
        --output)
            OUTPUT="$2"
            shift 2
            ;;
        --csv)
            CSV_OUTPUT="$2"
            shift 2
            ;;
        --json)
            JSON_OUTPUT="$2"
            shift 2
            ;;
        --geo)
            ENABLE_GEO=true
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            echo -e "${RED}Unknown option: $1${RESET}"
            exit 1
            ;;
    esac
done



#5. ---------- CHECK PERMISSIONS ----------
check_permissions() {
    if [[ $EUID -ne 0 ]]; then
        echo -e "${RED}ERROR: This script requires sudo/root privileges.${RESET}"
        exit 1
    fi
}



#6. ----------- CHECK DEPENDENCIES ---------
check_dependencies() {
    for cmd in awk grep sort uniq curl; do
        if ! command -v $cmd >/dev/null; then
            echo -e "${RED}ERROR: Missing dependency: $cmd${RESET}"
            exit 1
        fi
    done
}



#7. ---------- COLLECT LOGS ----------
collect_logs () {
    if [[ -n "$LOGFILE" ]]; then
        if [[ ! -f "$LOGFILE" ]]; then
            echo -e "${RED}ERROR: Log file not found: $LOGFILE${RESET}"
            exit 1
        fi
        cp "$LOGFILE" ssh_logs.txt
    else
        journalctl -u ssh > ssh_logs.txt
    fi
}



#8. -------- FILTER EVENTS ----------
filter_events() {
    grep -E "Failed password|Invalid user|maximum authentication attempts exceeded" ssh_logs.txt > failed_events.txt
}



#9. ---------- EXTRACT IPS ----------
extract_ips() {
    awk '{for(i=1;i<=NF;i++) if ($i=="from") print $(i+1)}' failed_events.txt > detected_ips.txt
}



#10. ---------- COUNT ATTEMPTS ----------
count_attempts() {
    sort detected_ips.txt | uniq -c > ip_attempts.txt
}



#11. ---------- GEOLOOKUP ----------
geolocate_ip() {
    local ip="$1"
    if [[ "$ENABLE_GEO" = true ]]; then
        curl -s "https://ipinfo.io/$ip/country" | tr -d '\n'
    else
        echo "-"
    fi
}



#12. ----- CALCULATE SEVERITY ----------
calculate_severity() {
    > severity_report.txt
    # Remove leading spaces from uniq -c output
    sed -i 's/^ *//' ip_attempts.txt

    while read -r count ip; do
        if (( count <= 3 )); then
            sev="LOW"
        elif (( count <= 10 )); then
            sev="MEDIUM"
        else
            sev="HIGH"
        fi
        
        country=$(geolocate_ip "$ip")

        echo "$ip $count $sev $country" >> severity_report.txt
    done < ip_attempts.txt
}



#13. ---------- GENERATE REPORT ----------
generate_report() {
    echo "=============================" > "$OUTPUT"
    echo " SSH BRUTE FORCE REPORT (PRO) " >> "$OUTPUT"
    echo "=============================" >> "$OUTPUT"
    echo "" >> "$OUTPUT"

    echo "IP Address | Attempts | Severity | Country" >> "$OUTPUT"
    echo "------------------------------------------" >> "$OUTPUT"
    cat severity_report.txt >> "$OUTPUT"

    echo -e "${GREEN}Report generated: $OUTPUT${RESET}"
}



#14. ---------- EXPORT CSV ----------
export_csv() {
    if [[ -n "$CSV_OUTPUT" ]]; then
        echo "IP,Attempts,Severity,Country" > "$CSV_OUTPUT"
        awk '{print $1","$2","$3","$4}' severity_report.txt >> "$CSV_OUTPUT"
        echo -e "${GREEN}CSV exported: $CSV_OUTPUT${RESET}"
    fi
}



#15. ---------- EXPORT JSON ----------
export_json() {
    if [[ -n "$JSON_OUTPUT" ]]; then
        echo "[" > "$JSON_OUTPUT"
        awk '{printf "{\"ip\":\"%s\",\"attempts\":%s,\"severity\":\"%s\",\"country\":\"%s\"},\n", $1,$2,$3,$4}' severity_report.txt >> "$JSON_OUTPUT"
        sed -i '$ s/,$//' "$JSON_OUTPUT"
        echo "]" >> "$JSON_OUTPUT"
        echo -e "${GREEN}JSON exported: $JSON_OUTPUT${RESET}"
    fi
}



#16. ---------- MAIN ----------
main() {
    check_permissions
    check_dependencies
    collect_logs
    filter_events
    extract_ips
    count_attempts
    calculate_severity
    generate_report
    export_csv
    export_json
}

main

