# OVPN basics

---
 
This file contains the basics for using **OpenVPN**. The purpose to know how OpenVPN works  is to complete [TryHackMe](https://tryhackme.com/p/roberto17orozzco) tasks.

* An OVPN is an open VPN protocol that serves as a secure and reliable internet channel 
that connects my computer to the THM server.

* VPN stands for **Virtual Private Network**, it is the name for the full service, meanwhile 
*Open* VPN means that the Virtual Private Network uses the **OpenVPN protocol** to work.

* One of it's main features is that it uses SSL/TLS for encryption. All data traveling 
through this VPN "tunel" is encrypted.

	* IP and location is invisible for any external entity or individual.

* OVPN uses *.ovpn* extension for it's files. These are configuration files and are 
needed to stablish the conection.

---

## TryHackMe client - server

Already downloaded the *.ovpn* file to my computer. It is stored in my repository in 
my Kali file system.

At this point it is important to recognize that:

	* The OpenVPN **server** is: [TryHackMe](https://tryhackme.com).
	* Open VPN **client** is: my Kali Operating System.


---

## Stablish OVPN connection between Kali and TryHackME.

### Trying on a public network

Right now I'm in a Hotel on the beach and I'm trying connection on it's public WiFi service, lets see how it went:

* `sudo openvpn <my_ovpn_file>`
* Process ran and got the following error message: "Could not determine IPv4/IPv6 protocol] 
received, process restarting".
* That happened because I was using a *public WiFi Network.* Public WiFi Networks use to:
	* Block UDP 1194 wich is the standard port for OpenVPN.
	* Block all VPN traffic to avoid encrypted tunels.
	* Force IPv6 or disable it.

* I tried to fix this by: 
	* Replacing `proto udp` for `proto tcp` on my *.ovpn* file.
	* Got the following error message: "Cannot resolve host address:` <my .ovpn file>` (Temporary failure in name resolution)".
	* That happened due to my .ovpn file is an **IP** address using **DNS** (Domain Name System) and public networks block DNS.

* Afterwards I tried to use *public DNS*.
	* I edited *resolv.conf* file replacing everything for "servername 1.1.1.1 servername 8.8.8.8" wich correspond to Google and Cloudflare.
	* Tried to stablish connection again with no success.

This two methods failed because the public network I'm connected to blocks VPN and DNS.


- *Notes:*
	* *DNS* stands for *Domain Name System* which is the way computers and networks translate **domain names** (e.g. google.com) to **IP addresses** (e.g. 142.250.72.14).
	* Replaced (reset) `proto tcp` for `proto udp`. This is because [TryHackMe](tryhackme.com) servers work naturally with UDP 1194.
	* *UDP* stands for *User Datagram Protocol*. It is a fast and light transfer protocol used mostly for streaming and for VPN's.
	* I was about to reconfigure my `/etc/resolv.conf` file, but I found out that though there are many ways to do it, the file re-configures itself automatically after a reboot, so I opted to reboot my Kali.
 
---

## Stablish OVPN connection between Kali and TryHackME.

### Trying on a private network

After realizing that I wouldn't be able to stablish the **OpenVPN** connection using the Hotel's WiFi I tried a **private network** using my mobile **HotSpot** service, this is what happened:

* On *.ovpn* directory: `sudo openvpn file-name`
* `ip a` to show all working internet interfaces on my system.
* One of those interfaces was:
	* tun0: <POINTOPOINT,NOARP,UP,LOWER_UP> 

	* UP: interface is active.
	* LOWER_UP: real connectivity.
	* POINTOPOINT: it is a VPN tunel.
	* tun0: interface created by OpenVPN.
	
* That means the VPN is working.

---

* There could be times that by mistake you stablish *more than1  tunels (tun0, tun1, tun2, etc.)* in that case:
	* First verify the stablished connections with `ip a`
	* If you find more than one you must *kill those processes* and re-open a new one.
	* `sudo killall ovpn` to kill the processes.
	* `sudo openovpn file-name`
	* Verify there is only 1 tunel (e.g. `tun01`)

* *Having more than 1 .ovpn running may cause connection problems with the server, on this case the [TryHackMe](tryhackme.com) server.*

---

## Connection stablished.

Now I can notice that I have a clean and stable connection, and that an **IP** has been assigned to my computer by the server. That IP displays as follow: *inet 192.168.###.###/17*. `/17` indicates the internal network for the tunel.
That IP is not my *local IP* nor my *public IP*, it is the private IP *within the VPN.*

Proceed with the following actions:

* `ping -c 4 192.168.128.1` (that IP is the tunel gateway) to confirm connection.
* If you get display showing an ammount of bytes being received from the *tunel gateway* and a time between 148 and 212 ms, the connection is clean and stable.

---

### Working on my first TryHackMe machine

Now, I'll enter a room for the **Pre-Security** learning path and find the first machine I can work with.

* Go to [TryHackMe](tryhackme.com) and find a task that **includes a deployable machine.**
* Click the **Start Machine** button.
* `ping -c 4 <THMmachineIP>`
	* Some THM machines doesn't respond to `ping -c 4` and what you get in return is: 
	
	PING 10.10.52.232 (10.10.52.232) 56(84) bytes of data.

--- 10.10.52.232 ping statistics ---
4 packets transmitted, 0 received, 100% packet loss, time 3058ms

	* If `ping -c 4` doesn't work try `

**Very important:** this far I was using my cell phone Hotspot. As you can see on file *Differences_betwen_my_home_hotspot_and_starbucks_internet.md* a Hotspot network won't work for attacking a THM machine using OpenVPN (.ovpn)

### Attacking my first TryHackMe machine (Using a Private Network)
* `sudo openvpn <my_ovpn_file>`
* `ip a` to verify `tun0` is created
* Go to [TryHackMe](tryhackme.com) and find a task that **includes a deployable machine.**
* Click the **Start Machine** button.
* Once the machine is completely loaded verify the machine location is the same as your *.ovpn* file (e.g. machine is in US East then your .ovpn should include *us-east-1* on it's name).
* Search for it's IP address, it should be on the *info* icon on the bottom bar menu of the machine; it is indicated as *Private IP: 10.64.XXX.XX (Use this for your reverse shells).*
* `nmap -Pn <Private Machine IP>` it will show **4 ports.** Every port has a number/tcp; e.g. 22/tcp, 80/tcp, 3000/tcp and 7777/tcp. 
* `nmap -Pn -sV -sC <Private Machine IP>`
* On Kali VM open `Firefox` web browser and enter to http://<Private machine IP>:22, http://<Private machine IP>:80, http://<Private machine IP>:3000, http://<Private machine IP>:7777, they should display the same information as the **Attackbox** does.
* Follow task instructions, for instance, the task I'm working on right now indicates the usage of **gobuster** a scaning tool.
* Instructions indicate to enter `gobuster -u http://fakebank.thm -w wordlist.txt dir` in the attackbox terminal, but ...

Since I'm working on the Kali enviroment **not in the THM URL** what I should do is go to a terminal and  enter 
`gobuster dir -u http://fakebank.thm -w /usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt -t 20`

Here are 4 different things that can be distinguished from the THM instructions and what I found using *AI.*
1. Instead of using *-u http://10.64.XXX.XX* (THM machine IP address) use the DNS (Domain Name System) in this case http://fakebank.thm. I was using the IP address because I was following AI instructions.
	* After going deeper on this process AI indicated that since the task shows a DNS, `gobuster` should be excecuted using it.
2. Instead of using *-w wordlist.txt* use:
	* `/usr/share/wordlists/dirb/common.txt`
	* `/usr/share/wordlists/dirb/big.txt`
	* `/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt`
3. THM doesn't indicate `-t 20` it is optional. It commands the numer of simultaneous **threats** being processed.
4. * The location for the word *dir* can be at the beggining or at the end.










  


	


 
