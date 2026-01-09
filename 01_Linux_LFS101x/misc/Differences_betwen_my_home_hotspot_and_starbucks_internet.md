# My three most used internet places
I use three different networks to connect my computer in order to study my Cybersecurity lessons; those are my home network, a Starbucks cafe network, and my mobile Hotspot.

This document is to compare their development.

## My home network
* Open `Powershell` on Windows (which is the main/host OS on my computer) 
* `netsh wlan show interfaces`

* SSID (Service Set Identifier) which is the name for my home Wi-Fi network is INFINITUMA99C_5
* Band is 5 GHz: Delivers less interference, lower latency and lower jitter than a 2.4 GHz.
* Chanel is channel 64: this channel is on DFS (Dynamic Frequency Selection) range, it is used less by neighbors, allows wider channel bandwidths ( 40 - 80 MHz).
* Receiving speed is 585 Mbps: a really good speed.
* Sending speed is 866.7 Mbps: a really good speed.
* Signal is at 96%

## Starbucks network
* Open `Powershell` on Windows (which is the main/host OS on my computer)
* `netsh wlan show interfaces`

* SSID (Service Set Identifier) which is the name for the Starbucks network is [ STARBUCKS ]
* Band is 5 GHz
* Channel: 64
* Receiving speed: 432 Mbps
* Sending speed: 681 Mbps
* Signal is 80%

## Hotspot network
* Open `Powershell` on Windows (which is the main/host OS on my computer)
* `netsh wlan show interfaces`

* SSID (Service Set Identifier) which is the name for the HotSpot network is Android-roberto
* Band is 2.4 GHz
* Channel: 6
* Receiving speed: 144.4 Mbps
* Sending speed: 144.4 Mbps
* Signal is 99%


### How does every network work for OpenVPN and Kali updates/upgrades.

**My home network**
* Kali updates and upgrades: **no problem at all.**
* OpenVPN: **no problem at all**

**Starbucks network**
* Kali updates and upgrades: some packages and services **won't update neigther upgrade.**
* OpenVpn: **unnable to open ovpn** because it is a *public network* and they: 

    * Block external DNS (Domain Name System): my computer cannot excecute the *.ovpn* file. 
    * Filter VPN (Virtual Private Network) traffic: OpenVPN cannot connect.
    * Block ports used by OpenVPN. 

**Hotspot**
* Kali updates and upgrades: **no problem at all** 
* OpenVPN: it works and stablishes `tun0` but it wouldn't be able to attack THM machines because:
    * It allows **VPN** but uses **CGNAT** (Carrier Gate NAT).
    * **CGNAT** filters packages, specially **Nmap** scans. I cannot see ports, I **cannot attack the machine.**


So, using the Starbucks network is ok for browsing through my lessons and attacking THM machines as long as I do it without trying OpenVPN. This network is not good for updates and upgrades because they will simply won't work.

Hotspot is good for everything but to trying to attack a THM machine.

The best place is my home network, where I would be able to update, upgrade, stablish OpenVPN and acces THM machine ports, use `ping` and `nmap`.
