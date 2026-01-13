# Commands
This file contains a variety of useful commands. They will be added as I progress on my study.

## System
1. `sudo apt update` to update the system.

2. `sudo apt full-upgrade -y` to upgrade the system.
3. `sudo apt update && sudo apt full-upgrade -y` to update and upgrade at one time.
4. `xfce4-settings-manager` to open general/system configuration window.
    * `xfce4-keyboard-settings` to go directly to keyboard settings.
    * `xfce4-display-settings` to go directly to screen settings.
    * `xfce4-appearance-settings` to go directly to appearance settings.
5. `ps aux | grep <process name>` to identify process ID number.
6. `kill <process number>` to kill that process. It is useful for process that cannot be cancelled with `Ctrl + C` or `q` at the terminal where the process is being ran.
7. `sudo apt install <application name>` to install new applications or programs.






## Directory / files
1. `cd ..` to go to an upper directory.
1. `mkdir <directory name>` to create a new directory.
2. `touch <file name>` to create a new file.
3. `cat <file name>` to read a file content on terminal.
4. `rm <file name>` to remove a file.
6. `rmdir <directory name>` to remove a directory.
7. `find ~ -name "file_name" 2>/dev/null` To search a file in `/home` directory. Excecute it at `/home`.
8. `sudo find / -name "First_VSCode_file.md" 2>/dev/null` to find and search in the whole Linux system.

## Networking
1. `nm-connection-editor` to open conection editor window. It  works to change some configuration options for **IPv4** like *Method* or *DNS servers*. 
2. `nmcli device status` used to know what is my active connection.
