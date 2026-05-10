# 6.- SUSPICIOUS PROCESS MONITOR - PRO

![script](suspicious_process_monitor_report_full.jpg)



## 1.- Script Architecture and Development
![illustration](script_6_illustration.jpg)





## 1.1.- Architecture Overview

This project follows a modular architecture where each detection capability is implemented as an independent Bash function. The system includes:

- a primary detection module  
- multiple analysis modules  
- a full‑scan orchestrator  
- a continuous watch subsystem  
- a CLI dispatcher for user interaction  



## 1.2.- Development Overview

Although several software‑design methodologies exist (Top‑Down, Bottom‑Up, Layered Organization), **this project was written using the Development‑Driven Construction Order method**.

Under this method, the script is constructed in the natural order in which its **functional components should be built**. Each step in the construction process is treated as a **development block**, representing a self‑contained unit of functionality that depends on the previous ones.

The script was developed following this sequence of **development blocks**:

1. **Core Detection Module (Suspicious Execution Paths)**: Central logic of the system. Scan processes and identifies those running from suspicious directories.
2. **Path Evaluation Function**: Evaluator used by the core module to classify suspicious paths.
3. **Configuration Block**: Defines thresholds, directories, and timing parameters.
4. **Utility Functions**: Logging helpers and formatted terminal output utilities.
5. **Secondary Detection Modules**: Additional detection capabilities that extend the system.
    1. CPU Anomaly Detection.
    2. Network-Active Process Detection.
    3. Short-Lived Proess Detection.
    4. Unexpected Root Process Detection.
6. **Full Scan Orchestrator**: Runs all detection modules and generates a complete report.
7. **Watch Mode Sybsystem**: Continously executes the full scan at a defined interval.
8. **CLI Dispatcher**: Routes command-line arguments to the appropiate module.
9. **Timestamp & Report Initialization**: Creates the timestamp and report filename.
10. **Color Definitions**: ANSI color codes for formatted terminal output.
11. **Header & Metadata**: Project title, author, purpose.
12. **End of Script Notification**: Final message printed after execution.



These development blocks are shown in the **illustration above**, placed on the left side of the code inside blue boxes. Their purpose is to provide a visual representation of the order in which the script was constructed.

This approach results in a clean, intuitive, and logically consistent construction sequence that reflects how an engineer naturally builds a system from the inside out.





## 2.- System enviromenment and configuration
Since this project analyzes system processes only and does not inspect network traffic, there is no need to configure networking components such as iptables, firewalls, or virtual network adapters. Likewise, there is no requirement to generate traffic on the local machine or from any external system.

## 3.- Script Breakdown


### 3.1.- Header & Metadata ( 1 - 7)
1. The script uses the `/usr/bin/env bash` shebang.
2. The header is created using comments to describe the project name, author, and purpose.

### 3.2.- Color Definitions ( 9 - 14 )
1. ANSI colors are defined to improve visual clarity when the script runs.
2. For example:
    1. RED="\e[31m"
    2. GREEN="\e[32m"
    3. ...


### 3.3.- Logging & Message Functions ( 16 - 19 )
1. `info()  { echo -e "${BLUE}[INFO]${RESET} $1" >&2; }`: is a Bash function that prints informative messages.
    1. The `info()` function is a utility function (also called a **helper function**). In Bash (and in programming in general) a utility function is a small, reusable function designed to perform one very specific task that **other modules depend on**. It does not handle core logic; instead, its purpose is to assist other functions by providing a standardized behavior they can call whenever needed.
    2. For example: the `check_cpu_anomaly ()` function calls `info()` to display a standarized, color-formatted status message before performing its analysis. 
        * When `check_cpu_anomaly()` executes the line `info "Checking for high CPU usage processes..."`, it passes that string as an argument to `info()`.
        * Inside `info()`, this argument becomes `$1`, which is then printed to the terminal with a blue `[INFO]` prefix and reset color formatting.
        * This allows every module in the script to produce consistent, professional-looking information messages withoug duplicating formatting logic. 
    3. Every time any function in the script calls `info` followed by a **quoted string**, that entire string becomes `$1` inside the `info()` function, and it is the `info()` function that executes on that line.
        * `$1` is replaced by the **string** passed to the `info` function on any line that calls `info "String"`.
    
    * **IMPORTANT**:
        1. `info ()` is an utility function.
        2. `check_cpu_anomaly()` is a module function.

2. The functions `ok()` and `warn()` are also **utility functions**. Their purpose is to display standardized status messages, which are triggered by the **module functions** that call them during execution.


### 3.4.- Timestamp & Report Initialization ( 20 - 21 )
1. **TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")**: sets the variable TIMESTAMP using a date formatted as year-month-day_hour-minute-second.
2. **REPORT="process_monitor_report_$TIMESTAMP.txt"**: creates a filename that includes the base name process_monitor_report plus the timestamp indicating the exact date and time when the file was generated.

### 3.5.- Configuration Block ( 23 - 29 )
1. **CPU_THRESHOLD=25**: This line defines a variable named CPU_THRESHOLD and assigns it the value 25. 
    * In the context of this script, this value represents the percentage of CPU usage that will be considered **suspicious or abnormal**. 
    * Any **process** whose CPU consumption exceeds this threshold will be flagged by the `check_cpu_anomaly()` module. 
    * In other words, the threshold acts as the minimum CPU percentage required for a process to be treated as a potential anomaly during the analysis.

2. **SUSPICIOUS_DIRS=("/tmp" "/var/tmp" "/dev/shm" "/home/$USER/Downloads"):** defines an **array** containing directories that are commonly used by attackers or malware to store or execute temporary files.
    * These paths are monitored by the script because they often host suspicious or unauthorized activity.
    * The variable **stores** all these directories so the **detection module** can scan them later.

* **IMPORTANT**: 
    * The `check_suspicious_paths()` module is responsible for generating the paths to be analyzed. It retrieves the absolute execution path of each running process using `readlink -f /proc/$pid/exe` and passes each path as `$1` to `is_suspicious_path()`, which evaluates whether the path begins with any of the directories listed in `SUSPICIOUS_DIRS`.
    * If the path matches, it is considered suspicious; if it does not, it is treated as normal. 
    * In other words, `SUSPICIOUS_DIRS` does not provide the paths, it defines the criteria used to classify the paths generated by other modules.




3. **WATCH_INTERVAL=5**: sets the default interval (in seconds) used by the **watch mode**. This value determines how long the script waits between each **monitoring cycle** when running in `--watch` mode.


### 3.6.- Help Menu ( 30 - 36 )
 
```
show_help() {
    echo "Usage: $0 [--cpu | --network | --paths | --full | --watch N]"
    exit 0
}
```
* This is a utility function that displays the script’s usage instructions.
* `$0`: represents the name of the script.
* After printing the usage message, the function calls `exit 0`, which indicates a normal and successful termination.



### 3.7.- Utility Functions ( 38 - 50 )
#### 3.7.1.- logs ()

1.  
```
log() {
    echo "$1" >> "$REPORT"
}
```
 * This function operates like `info()`, `ok()`, and `warn()` in that it accepts a message through the `$1` argument.
 * Unlike the other utility functions, which display formatted output to the terminal, `log()` writes the received message to the report file specified by *$REPORT**.
 * Whenever a module function calls `log` with a quoted string, that **string** becomes the `$1` argument inside `log()`. 
    * The `log()` function then uses `echo` to append that message to the file specified by the **REPORT** variable.

2. 
```
is_suspicious_path() {
    for dir in "${SUSPICIOUS_DIRS[@]}"; do
        [[ "$1" == $dir* ]] && return 0
    done
    return 1
}
```
* `is_suspicious_path()`: is an **utility function** thath checks whether the path provided as `$1` starts with any of the directories listed in the `SUSPICIOUS_DIRS` array. 
    * Its purpose is to return a logical value (`0` for true or `1` for false) so that **other functions** in the script can decide how to handle the path based on this result. 
    * This function does not generate paths on its own; instead, it evaluates the paths supplied by the `check_suspicious_paths()` module. That module is responsible for collecting the execution paths of running processes (using `readlink -f /proc/$pid/exe`) and passing each path as `$1` to `is_suspicious_path()` for classification.


* `for dir in "${SUSPICIOUS_DIRS[@]}"; do` 
    1. `for dir in ...`: starts the **for-loop**. It means "For each element, assign it to the variable `dir` and execute the loop body."
    2. `"${SUSPICIOUS_DIRS[@]}"`: this expands the array **SUSPICIOUS_DIRS** into its individual elements. 
        * `@`: is a Bash array expansion operator used to expand an array into all its individual elements, preserving each item as a separate, properly quoted value.

```
Expanded array without @:
for dir in "$SUSPICIOUS_DIRS"; do
Result:
"/tmp /var/tmp /dev/shm /home/roberto/Downloads"
The loop receives only 1 element.
$dir wouldn't be a directory, but a giant string.
Only 1 iteration with a giant string.
```

```
Expanded array with @:
for dir in "${SUSPICIOUS_DIRS[@]}"; do
Result:
"/tmp"
"/var/tmp"
"/dev/shm"
"/home/roberto/Downloads"
The loop receives 4 elements.
$dir would now be a directory.
4 iterations, 1 for each directory.
```

* 
    3. `do`: marks the beginning of the block of commands that will be executed for each element in the loop.
    4. `[[ "$1" == $dir* ]] && return 0`: checks whether the value passed as `$1` starts with the directory stored in `$dir`. If the condition is true, the function immediately returns 0 (meaning "match found").
        * `[[ ... ]]`: bash conditional test.
        * `$1`: the path being checked.
        * `== $dir*`: Pattern matching:
            * "Does `$1` begin with the directory stored in `$dir`?"
            * The `*` means “any characters that may follow this prefix.” In this context, it allows the pattern to match a directory path that begins with the value stored in `$dir`, followed by anything else.


```
Example:
If $dir = /tmp
Then the pattern is:
/tmp*
So it matches:
- /tmp/x.sh
- /tmp/malware.bin
- /tmp/abc/xyz
```
* 
    * 
        * `&& return 0`: logical **AND**; it means: If the condition is true, then execute `return 0`.
            * `return 0` = true / success.
            * `return 1` = false / no match.
        * So, this line means: "If the path starts with this directory, stop the loop and return success".

    * `done`: finishes the for loop.
    * `return 1`: indicates false / no match. It is placed after `done` because it should only run if the loop finishes without finding a match.

**NOTICE**:
1. This for loop is executed only 4 times because the **SUSPICIOUS_DIRS** array contains exactly 4 elements.
2. `return` is used inside functions to indicate whether a condition is true (0) or false (1).
   * It is used when the result of the conditional test determines a specific action.





#### 3.7.2.- is_suspicious_path()



### 3.8.- Module 1 - CPU Anomalies ( 52 - 65 )
#### 3.8.1.- Function check_cpu_anomaly ()
#### 3.8.2.- AWK Block #1


### 3.9.- Module 2 - Suspicious Execution Paths ( 67 - 84 )
#### 3.9.1.- Function check_suspicious_paths()



### 3.10.- Module 3 - Network-Active Processes ( 86 - 99)
#### 3.10.1.- Function check_network_activity ()
#### 3.10.2.- AWK Block #2 


### 3.11.- Module 4 - Short-Lived Processes ( 101 - 124)
#### 3.11.1.- Function check_short_lived ()



### 3.12.- Module 5 - Unexpected Root Processes ( 126 - 139)
#### 3.12.1.- Function check_root_processes ()
#### 3.12.2.- AWK Block #3


### 3.13.- Full Scan Orchestrator (141 - 160)
#### 3.13.1.- Function run_full_scan ()
#### 3.13.2.- Execution Flow



### 3.14.- Watch Mode Subsystem (162 -175)
#### 3.14.1.- Function run_watch_mode ()
#### 3.14.2.- Loop Behavior
#### 3.14.3.- Report Rotation


### 3.15.- CLI Dispatcher ( 177 - 187)
#### 3.15.1.- Argument Routing
#### 3.15.2.- Default Case


### 3.16.- End of Script ( 189 - 192)


