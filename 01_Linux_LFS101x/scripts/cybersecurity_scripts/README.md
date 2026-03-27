## Cybersecurity scripts
After acomplishing the Linux LFS101x course I decided to work on 7 cybersecurity scripts before jumping on my next step which is the **Google Cybersecurity Certificate** course.

In this directory you will find my first 7 cybersecurity scripts made with Copilot help.

On each script you will find comments that describe what was learned.

The scripts will cover the next subjects:

| # | Script Description |
|---|---------------------|
| **1. Critical File Change Monitor** | Monitors sensitive files such as `/etc/passwd`, `/etc/shadow`, and `/etc/sudoers` using SHA256 hashes to detect unauthorized modifications. Ideal for system hardening and early intrusion detection. |
| **2. Failed Login Attempt Analyzer** | Parses `/var/log/auth.log` to identify failed authentication attempts, brute‑force patterns, and suspicious activity. Useful for incident analysis and SOC workflows. |
| **3. Defensive Open Port Scanner** | Scans ports 1–1024 on the local machine using `/dev/tcp`. Helps identify exposed services and evaluate the attack surface. |
| **4. Suspicious Connection Detector** | Analyzes active connections using `ss` or `netstat` and flags unusual ports commonly associated with malware or unauthorized tunnels. |
| **5. Critical Binary Integrity Checker** | Calculates and compares hashes of binaries like `ls`, `bash`, and `sudo` to detect tampering or rootkits. Strengthens system integrity. |
| **6. Automatic Suspicious IP Blocker** | Identifies IP addresses with multiple failed login attempts and blocks them automatically using `iptables` or `nftables`. Works like a mini fail2ban. |
| **7. System Security Audit Report** | Generates a full security report including open ports, active users, weak permissions, running services, and recent log events. Excellent for audits and documentation. |

