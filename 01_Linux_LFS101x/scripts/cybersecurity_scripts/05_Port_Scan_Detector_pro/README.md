## PORT SCAN DETECTOR (PRO)

![port_scan_detector](24.1_port_scan_detector_pro.jpg)

### 1.- Project purpose

### 2.- Project enviroment (iptables rules)
1. Configure **iptables** rules on Kali Linx to:
    1. Block incomming traffic by default.
    2. Allow only the essential.
    3. Log (register) every blocked connection attempt.
    4. Generate the logs **Port Scan Detector** requires to analyze.

2. Configure **iptables** rules in the Kali terminal executing:
    1. Clean previous rules.
        * `sudo iptables -F`: to clean existing rule strings (`-F`: Flush).
        * `sudo iptables -X`: to remove personalized strings (`-X`: Delete chain).
            * This is to prevent old rules to interfare with this project.
    2. Stablish default policies.
        * `sudo iptables -P INPUT DROP`: blocks incomming traffic.
            * `-P`: Policy. Means "policy by default". It changes the default string action. The principal string actions are: INPUT, OUTPUT and FORWARD.
            * This rule means "Kali will block all incomming traffic, except what is explicity allowed".
        * `sudo iptables -P FORWARD DROP`: blocks traffic within the system.
        * `sudo iptables -P OUTPUT ACCEPT`: allows all outcomming traffic.
            * This is to block all connection attempts to Kali, in order to:
                1. `nmap`: generates traffic.
                2. `iptables`: blocks this traffic.
                3. `journald`: registers this traffic.
                4. This project script analyze this traffic.
            
    3. Allow essential traffic.
        * `sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT`: allows responses to connections initiated by the user, (e.g. browsing, updating, ping).
            * This is to:
                2. Maintain networking.
                3. Prevent Kali to be isolated.  

    4. Allow loopback.
        * `sudo iptables -A INPUT -i lo -j ACCEPT`: allow internal traffic.
            * This is because a lot of programs depend on loopback.
            * To block it is to break internal services.
    
    5. Register (log) everything that is blocked.
        * `sudo iptables -A INPUT -j LOG --log-prefix "IPTABLES DROP: "`: everytime a packet arrives to **INPUT** and is blocked, **iptables**:
            * Registers it in `journald`.
            * Prefix `"IPTABLES DROP: "` is added.
            * Includes data like SRC, DPT, PROTO, etc.
                * **Port Scan Detector** depends on these logs. Without this rule there will be nothing to analyze.
3. This rules are created in the Kali terminal rather that in a configuration file because:
    1. `iptables` is a dynamic firewall.
    2. `iptables` rules live in the kernel memory.
    3. These rules are managed by commands.
    4. Kali does not have a permanent configuration file (although you can make the rules permanent with `sudo apt install iptables -persitent` and `sudo netfilter-persistent save`)

#### iptables rules
![iptablesrules](24.2_iptables_rules.jpg)

### 2.1.- Project enviroment (generating traffic).
In order to generate a robust and diverse report, multiple actions where taken from my other VM to increment frewall logs. It was not possible for me to connect both VM to different routers, therefore I couldn't add an interesting **geolocation** function in the script. All the traffic was generated from Ubuntu, to Kali. These actions are:
1. Use a for loop to generate multiple **SSH** connection request.
![ssh_for_loop](24.3_ssh_for_loop.jpg)


2. Generate **HTTP** connection requests with `curl`.
![curl](24.4_curl.jpg)

3. Try to connect to unexistent ports using Netcat.
![netcat](24.5_netcat_unexistent_ports.jpg)

4. Perform a port scan with `nmap`.
![nmap](24.6_nmap_sequential.jpg)

5. Perform a randomized `nmap` port scan.
![nmap_random](24.7_nmap_randomhosts.jpg)

6. Perform a delay scan with `nmap`.
![nmap_delay](24.8_nmap_scan_delay.jpg)

7. Execute `hping3` to generate SYN flood ping.
![hping3](24.9_Hping3_flood.jpg)

8. Execute `hping3` to generate UDP flood ping.
![hping3udp](24.10_Hping3_udp_flood.jpg)

9. Run a scritp that generates diverse traffic to ensure the Kali firewall log has enough material to analyze.