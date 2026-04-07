#!/usr/bin/env bash

# 1. Check permissions
if [[ $EUID -ne 0 ]] ; then
    echo "This script requires sudo privileges."
    exit 1
fi
#
echo "OK: running with root privileges."
#
#
#
#
# 2. Obtain logs
sudo journalctl -u ssh > ssh_logs.txt
#
#
#
#
# 3. Filter events
grep -E "Failed password|Invalid user|maximum authentication attempts exceeded" ssh_logs.txt > failed_events.txt

echo "Relevant SSH events saved to failed_events.txt"
#
#
#
#
# 4. Extract IPs
awk '{for(i=1;i<=NF;i++) if ($i=="from") print $(i+1)}' failed_events.txt > detected_ips.txt

echo "IPs extracted and saved to detected_ips.txt"
#
#
#
#
# 5. Count attempts
sort detected_ips.txt | uniq -c > ip_attempts.txt
#
echo "IP attempt counts saved to ip_attempts.txt"
#
#
#
#
# 6. Extract users
awk '{for(i=1;i<=NF;i++) if($i=="for") print $(i+1)}' failed_events.txt > detected_users.txt
#
echo "Users extracted and saved to detected_users.txt"
#
#
#
#
# 7. Calculate severity
awk '{if($1<=3)sev="LOW"; else if($1<=10)sev="MEDIUM"; else sev="HIGH"; print $2, $1, sev}' ip_attempts.txt > severity_report.txt
#
#
#
#
# 8. Generate report
echo "IP Adress | Attempts | Severity" > final_report.txt
echo "-------------------------------" >> final_report.txt
cat severity_report.txt >> final_report.txt
#
echo "Final report generated: final_report.txt"
#
# ---------------------------------------------> end of script (simple version).
