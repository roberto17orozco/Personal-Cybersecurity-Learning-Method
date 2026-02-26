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
6. `rmdir <directory name>` to remove **empty** directories.
6. `rm -rf <directory name>` to remove directories with content.
7. `find ~ -name "file_name" 2>/dev/null` To search any element in `/home` directory. Excecute it at `/home`.
8. `find ~ -name "K*" 2>/dev/null` To search any element in `/home` directory where you know the name of the file starts with "K" but know no more.
9. `find ~ -name "*1*" 2>/dev/null` To search any element in `/home` where you know tne name of the file cointains a "1" but know not more.
10. `find / -name "file_name" 2>/dev/null` To search any element in `/` (the root, the whole system). Search takes longer. It looks in `/` instead of looking in `/home`.
11. `find / -type f -name "K*" 2>/dev/null` To search any **file** in the whole system `/` that starts its name with a "K". Notice the **-type f** option is enabled, thus the search will limit to only looking for **files**.
12. `find ~ -type f -name "K*" 2>/dev/null` To search for any **file** in the `/home` directory that starts its name with a "K".
13. Use `2>/dev/null` only if you are searching in the whole system. This string avoids error printing.
14. `sudo find / -name "First_VSCode_file.md" 2>/dev/null` to find and search in the whole Linux system.
15. `mv * /new/directory/tothefiles` this is used to move **all** the files from one file to another. You have to be located on the directory where the files are located.
16. `mv *.png /new/directory/tothefiles` is the same as the last one, the diference here is that you are only moving **.png** files.

## Networking
1. `nm-connection-editor` to open conection editor window. It  works to change some configuration options for **IPv4** like *Method* or *DNS servers*. 
2. `nmcli device status` used to know what is my active connection.
