# 6.- SUSPICIOUS PROCESS MONITOR - PRO

![script](suspicious_process_monitor_report_full.jpg)



## 1.- Script Architecture

This project is structured as a modular Bash‑based monitoring tool. Its architecture is composed of several clearly separated components:

1. **AWK Command Blocks**: Three lightweight filters used for CPU analysis, network‑active processes, and unexpected root activity. Each block operates as a standalone command, not as an embedded AWK program.

2. **Analysis Modules**: Independent Bash functions that perform specific checks. They do not share state and write their own output.

3. **Full Scan Orchestrator (run_full_scan)**: Coordinates all analysis modules in sequence and builds the complete system report.

4. **Watch Mode Subsystem (run_watch_mode)**: Implements continuous monitoring through an infinite loop that repeatedly triggers the full scan pipeline at fixed intervals.

5. **CLI Dispatcher**: The script’s global entry point, routing command‑line arguments to the appropriate module or subsystem.

This architecture emphasizes modularity, clarity, and separation of responsibilities, matching the structure shown in the illustration.

![architecture](script_6_illustration.png)

## 2.- System enviromenment and configuration
Since this project does not analyzes network traffic but systems process only, there is no need to manage any networking configurations like iptables, firewalls or network adapters for my Virtual Machine.  Also there is no need to generate traffic in my local machine or from another machine remotely.
