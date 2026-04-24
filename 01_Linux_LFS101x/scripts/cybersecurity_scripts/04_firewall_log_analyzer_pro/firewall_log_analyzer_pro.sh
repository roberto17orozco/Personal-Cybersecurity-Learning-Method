#!/usr/bin/env bash

# ==================================================================
# FIREWALL LOG ANALYZER PRO
# An advanced Bash tool to analyze firewall events from journald
# Author: Roberto Orozco
# ==================================================================
#
# --------------------------------
# 1. COLORS
# --------------------------------
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RESET="\e[0m"

# -------------------------------
# 2. OUTPUT FILES
# -------------------------------
OUTPUT_TXT="firewall_report.txt"
OUTPUT_CSV="firewall_report.csv"
OUTPUT_JSON="firewall_report.json"

# ------------------------------
# 3. CHECK DEPENDENCIES
# ------------------------------
check_dependencies () {
    echo -e "${BLUE}[INFO] Checking dependencies...${RESET}" >&2
    if ! command -v journalctl &>/dev/null; then
        echo -e "${RED}[ERROR] journalctl not found. This script requires systemd-journald.${RESET}"
        exit 1
    fi

    if ! command -v geoiplookup &>/dev/null; then
        GEO_AVAILABLE=false
    else
        GEO_AVAILABLE=true
    fi
    echo -e "${GREEN}[+] Dependencies OK!${RESET}" >&2
}

# --------------------------------
# 4. EXTRACT FIREWALL LOGS
# --------------------------------
extract_logs () {

    echo -e "${BLUE}[INFO] Extracting firewall logs from journald...${RESET}" >&2

    LOGS=$(journalctl -k | grep -E "IPTABLES DROP|DROP|REJECT")

    if [[ -z "$LOGS" ]]; then
        echo -e "${YELLOW}[WARNING] No firewall logs found. Make sure logging is enabled.${RESET}" >&2
        exit 1
    fi
    echo -e "${GREEN}[+] Firewall logs extracted successfully!${RESET}" >&2

}


# --------------------------------
# 5. PARSE LOGS
# --------------------------------
parse_logs () {

    echo -e "${BLUE}[INFO] Parsing logs...${RESET}" >&2

    echo "$LOGS" | awk '
    {
        for(i=1;i<=NF;i++){
            if($i ~ /^SRC=/){src=substr($i,5)}
            if($i ~ /^DST=/){dst=substr($i,5)}
            if($i ~ /^DPT=/){dpt=substr($i,5)}
            if($i ~ /^PROTO=/){proto=substr($i,7)}
        }
        if(src != ""){print src "," dst "," dpt "," proto}
        src=dst=dpt=proto=""
    }' > parsed.tmp

    echo -e "${GREEN}[+] Logs parsed successfully!${RESET}" >&2
}

# ---------------------------------
# 6. COUNT ATTACKS PER IP
# ---------------------------------
analyze_ips () {

    echo -e "${BLUE}[INFO] Counting attacks per IP...${RESET}" >&2
    echo -e "${BLUE}[INFO] Analyzing IP activity...${RESET}" >&2

    sort parsed.tmp | awk -F',' '
    {
        count[$1]++
    }
    END {
        for (ip in count) {
            printf "%s,%d\n", ip, count[ip]
        }
    }' > ip_count.tmp
    echo -e "${GREEN}[+] Attack attempts counted successfully!${RESET}" >&2
}


# ---------------------------------
# 7. GENERATE TXT REPORT
# ---------------------------------
generate_txt () {

    echo -e "${BLUE}[INFO] Generating TXT report...${RESET}" >&2

    echo "===============================" > "$OUTPUT_TXT"
    echo " FIREWALL LOG ANALYZER REPORT " >> "$OUTPUT_TXT"
    echo "===============================" >> "$OUTPUT_TXT"
    echo "" >> "$OUTPUT_TXT"

    while IFS=',' read -r ip count; do
        echo "IP: $ip" >> "$OUTPUT_TXT"
        echo "Attempts: $count" >> "$OUTPUT_TXT"

        if [[ "$GEO_AVAILABLE" == true ]]; then
            GEO=$(geoiplookup "$ip" | head -n 1)
            echo "Location: $GEO" >> "$OUTPUT_TXT"
        fi

        echo "-----------------------------------" >> "$OUTPUT_TXT"
    done < ip_count.tmp
    echo -e "${GREEN}[+] TXT report generated successfully!${RESET}" >&2
}

# --------------------------------
# 8. GENERATE CSV REPORT
# --------------------------------
generate_csv () {

    echo -e "${BLUE}[INFO] Generating CSV report...${RESET}" >&2
    
    echo "IP,Attempts,Location" > "$OUTPUT_CSV"

    while IFS=',' read -r ip count; do
        if [[ "$GEO_AVAILABLE" == true ]]; then
            GEO=$(geoiplookup "$ip" | head -n 1 | cut -d ':' -f2 | sed 's/^ //')
        else
            GEO="N/A"
        fi

        echo "$ip,$count,$GEO" >> "$OUTPUT_CSV"
    done < ip_count.tmp
    echo -e "${GREEN}[+] CSV report generated successfully!${RESET}" >&2
}

# ---------------------------------
# 9. GENERATE JSON REPORT
# ---------------------------------
generate_json () {

    echo -e "${BLUE}[INFO] Generating JSON report ...${RESET}" >&2

    echo "[" > "$OUTPUT_JSON"

    FIRST=true
    while IFS=',' read -r ip count; do
        if [[ "$FIRST" == false ]]; then
            echo "," >> "$OUTPUT_JSON"
        fi
        FIRST=false

        if [[ "$GEO_AVAILABLE" == true ]]; then
            GEO=$(geoiplookup "$ip" | head -n 1 | cut -d ':' -f2 | sed 's/^ //')
        else
            GEO="N/A"
        fi
        echo "  {\"ip\": \"$ip\", \"attempts\": $count, \"location\": \"$GEO\"}" >> "$OUTPUT_JSON"
        done < ip_count.tmp

        echo "]" >> "$OUTPUT_JSON"
        echo -e "${GREEN}[+] JSON report generated successfully!${RESET}" >&2
}

# --------------------------------
# 10. CLEANUP
# --------------------------------
cleanup () {
    echo -e "${BLUE}[INFO] Removing temporary files...${RESET}" >&2
    rm -f parsed.tmp ip_count.tmp
    echo -e "${GREEN}[+] Temporary files cleaned up successfully!${RESET}" >&2
}

# --------------------------------
# 11. MAIN
# -------------------------------
main () {
    check_dependencies
    extract_logs
    parse_logs
    analyze_ips
    generate_txt
    generate_csv
    generate_json
    cleanup

    echo -e "${GREEN}[DONE] Reports generated successfully.${RESET}"
    echo -e "${BLUE}TXT:${RESET}            $OUTPUT_TXT"
    echo -e "${BLUE}CSV:${RESET}            $OUTPUT_CSV"
    echo -e "${BLUE}JSON:${RESET}           $OUTPUT_JSON"
}

main
