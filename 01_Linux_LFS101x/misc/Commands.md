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
3. `ip route` is used to identify the systm's active outbound interface. This command shows the routing table. The interface used for external communication is the one that appears in the line containing **default via**, marked as **dev**. Example: dev **eth0**.
4. `ip a` lists all IP addresses assigned to all system interfaces.
    * **IMPORTANT**: to determinate the system's Local IP (my system IP):
        1. Run `ip route` and identify the **active outbound inteface**. It is the interface shown in the **default via** line (e.g., dev **eth0**).      
        2. Run `ip a` and locate the IP assigned to that inteerface. The IPv4 address (inet) of the active interface is the system's Local IP on the current network.

### Steps to identify lour Local IP
| Steps | Command | How it helps |
|---------------------------------|----------|--------------|
| Identify the active outbound interface | `ip route` | The interface used for external communication appears in the line containing `default via`, marked as `dev` (e.g., `dev eth0`). |
| List all IPs assigned to all interfaces | `ip a` | Once the active interface is known, look for its `inet` IPv4 address. That address is the system’s Local IP on the current network. |

---


5. `ipcalc <LocalIP><Mask>` is used to identify the Local Network (the network prefix) that your device belongs to.
    * **Local Network**: A local network (LAN or subnet) is the IP range your device is part of, defined by your IP address and subnet mask. All devices inside this range can talk to each other without passing through a gateway.
    * You can run `ip route` too and look for the line that matches your active interface (e.g., 172.16.16.0/20 dev eth0, ) that prefix is your Local Network.
    * A **subnet mask**, (or mask) is a value that defines the size of your local network. It tells your system:
        1. Which IP addresses are part of your network, and
        2. Which IP addresses are outside and must be sent to the gateway.
        * FOr example:
            - IP: 172.16.29.148
            - Mask: /20
                * The first **20 bits** identify the network,
                * the remainning **12 bits** identify hosts inside that network.
                * This produces the network:
                    - **172.16.16.0/20**
    * The **gateway** is the address of the device (usually the router) that my computer uses to leave the Local Network. You can find it in the `ip route` output as the IP shown after default via. 
    * **Public IP**: Your public IP is the address that your internet provider gives to your router so your whole home network can connect to the internet. It’s the IP that websites and external servers see when you visit them. Your router does not invent or decide the public IP — it simply receives the public IP assigned by the ISP.
        * `curl ifconfig.me` to check your public IP.

### Local vs Public Network Concepts
| Concept | Description |
|---------|-------------|
| **Local IP** | The IPv4 address assigned to your device inside the local network (e.g., `172.16.29.148/20`). It identifies your machine only within the LAN. |
| **Subnet Mask** | Defines how many bits belong to the network portion of the IP (e.g., `/20`). It determines the size of the local network. |
| **Local Network** | The network range your device belongs to, calculated from the Local IP + Subnet Mask (e.g., `172.16.16.0/20`). All devices in this range are considered “local.” |
| **Gateway** | The internal IP address of the router that your device uses to leave the local network (e.g., `172.16.16.1`). All external traffic is sent to this device. |
| **Public IP** | The IP address assigned by your ISP to your router (e.g., `189.173.111.83`). It is the address that websites and external servers see when you connect to the internet. |
