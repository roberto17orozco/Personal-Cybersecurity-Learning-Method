#!/usr/bin/env bash

# Failed Login Attempt Analyzer (journald version)
# Author: Roberto Orozco
# Description: Analyzes systemd-journald logs for failed authentication attempts.


PATTERNS_FILE="suspicious_patterns.txt"
REPORT_FILE="failed_login_report.txt"

# 1. Check patterns file
if [[ ! -f "$PATTERNS_FILE" ]]; then
    echo "[ERROR] Patterns file '$PATTERNS_FILE' not found."
    exit 1
fi

# 2. Header
echo "===== Failed Login Attempt Analyzer - $(date) =====" | tee "$REPORT_FILE"
echo "" | tee -a "$REPORT_FILE"

# 3. Build grep pattern from patterns file
GREP_PATTERN=$(paste -sd '|' "$PATTERNS_FILE")

echo "[INFO] Searching for suspicious authentication events..." | tee -a "$REPORT_FILE"
echo "" >> "$REPORT_FILE"
echo "=== Matching log entries ===" >> "$REPORT_FILE"

# 4. Query journald and filter
sudo journalctl --no-pager | grep -Ei "$GREP_PATTERN" | tee -a "$REPORT_FILE"

# 5. Summary
echo "" | tee -a "$REPORT_FILE"
echo "=== Summary ===" | tee -a "$REPORT_FILE"

MATCH_COUNT=$(sudo journalctl --no-pager | grep -Ei "$GREP_PATTERN" | wc -l)

echo "[INFO] Total suspicious entries found: $MATCH_COUNT" | tee -a "$REPORT_FILE"

echo "" | tee -a "$REPORT_FILE"
echo "[DONE] Analysis completed. Report saved to $REPORT_FILE" | tee -a "$REPORT_FILE"
