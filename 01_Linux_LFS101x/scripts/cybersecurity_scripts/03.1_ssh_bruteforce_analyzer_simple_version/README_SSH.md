## SSH SECURITY IMPORTANCE

1. Attackers take advantage of the fact that SSH is usually open on **port 22** and use bots to try thousands of username and password combinations until they gain access.
2. Remember that **SSH (Secure Shell)** is a secure network protocol and service that allows **remote** connections between computers.
    * It works on a client-server model, where the server runs the `sshd` daemon and the client connects using the  `ssh` command.
3. It is the the standard in enterprises for remote administration of servers and network devices because is ensures confidentiality, integrity, and secure authentication across untrusted networks (SSH provides a strongly **encrypted chanel** for executing commands and transferring files).

### Where SSH can be found?
1. SSH is the most widely used remote access protocol across Linux, macOS, Windows, and network devices, far surpassing older insecure options like Telnet and competing with graphical protocols like RDP and VNC. It is the default for servers and cloud infrastructure, and analyzing its logs is critical because brute-force attacks against SSH are among the most common on the internet.

2. Market Share compared to other services

    * SSH: Dominant in server environments, especially Linux and cloud platforms.

    * RDP (Remote Desktop Protocol): Dominant in Windows environments for graphical remote access.

    * VNC (Virtual Network Computing): Used for cross-platform graphical access, but less secure by default.

    * Telnet: Largely obsolete due to lack of encryption.

3. Devices that commonly use SSH

    * Servers: Linux, Unix, Windows Server.

    * Personal Computers: Developers and admins use SSH clients to connect remotely.

    * Network Devices: Cisco routers, Juniper switches, firewalls.

    * IoT/Embedded Systems: Raspberry Pi, NAS devices, smart appliances.

    * Cloud Infrastructure: AWS EC2, Azure VMs, Google Cloud Compute instances.

4. Situations where SSH is used:

    * Remote administration of servers and devices.

    * Secure file transfer (SFTP, SCP).

    * Tunneling traffic securely (e.g., forwarding ports).

    * Automation/DevOps: scripts and CI/CD pipelines.

    * Cloud access: connecting to virtual machines.

5. Protocol Comparision Table

| Aspect | SSH | RDP | VNC | Telnet |
| --- | --- | --- | --- | --- |
| **OS Support** | Linux, macOS, Windows, network devices | Windows (native), limited Linux/macOS | Cross-platform | Legacy Unix/Linux |
| **Interface** | Command-line | Graphical desktop | Graphical desktop | Command-line |
| **Security** | Strong encryption | Encrypted, but historically vulnerable | Weak by default, can be tunneled | No encryption |
| **Usage Share** | Most common in servers/cloud | Most common in Windows desktops | Niche, cross-platform | Obsolete |
| **Devices** | Servers, routers, IoT, NAS | Windows PCs/servers | Mixed desktops | Legacy systems |
| **Situations** | Admin tasks, automation, file transfer | Full desktop remote work | GUI remote support | Legacy CLI access |
| **Examples** | AWS EC2, Cisco routers, Raspberry Pi | Windows Server, corporate desktops | Remote support tools | Old Unix terminals |
