#!/bin/bash

# File Integrity Monitor - Case 1
# Author: Roberto Orozco
# Description: Monitors critical system files using SHA256 hashing
#
MONITORED_FILES="monitored_files.txt"
BASELINE="baseline_hashes.txt"
LOGFILE="integrity_log.txt"

# Check required files
if [[ ! -f "$MONITORED_FILES" || ! -f "$BASELINE" ]]; then
    echo "[ERROR] Required files missing: $MONITORED_FILES or $BASELINE"
    exit 1
fi

echo "===== File Integrity Check - $(date) =====" | tee -a "$LOGFILE"

# Recalculate current hashes
sha256sum $(cat "$MONITORED_FILES") > current_hashes.txt

# Compare with baseline
DIFF_OUTPUT=$(diff "$BASELINE" current_hashes.txt)

if [[ -z "$DIFF_OUTPUT" ]]; then
    echo "[OK] No changes detected." | tee -a "$LOGFILE"
else
    echo "[ALERT] Changes detected in monitored files:" | tee -a "$LOGFILE"
    echo "$DIFF_OUTPUT" | tee -a "$LOGFILE"
fi

# Cleanup
rm current_hashes.txt
