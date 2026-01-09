# Windows internet tools

This file contains a variety of tools and actions that help to know specific information about the intenet connection being held on my **Host Machine.**



## The physical NETWORK ADAPTERS

* Open **PowerShell** on Windows
	* `Windows + R`
	* Type `powershell`
	* `Ctrl + Shift + Enter` (to open as administrator)


To know information about my network adapters take the following actions:

* `get-netadapter` to know what are the available interfaces.
* `get-netadapter | sort-object status -descending` to know what is the interface my computer (Host) is actually using.
	* The interface with **UP** status and **HIGH** LinkSpeed is the one used by the host.

* These commands show interfaces descriptions, status, MacAddress, and LinkSpeed. When I run it it shows 3 Inerfaces: Ethernet, Bluetooth and Wi-Fi.
* Wi-Fi interface description is: Intel(R) Wi-Fi 6 AX200 160 Mhz, Status: Up, and LinkSPeed: 144.4 Mbps.

* LinkSpeed will be the same for that interface on every network I connect to: 144.4 Mbps (for the Wi-Fi interface) because that is it's capability.
* But what Link Speed shows is not my real **Internet Speed** it is the the **network adapter - router** speed.


**It doesn't matter what network I'm connected to, the interfaces will always be the same because they are the interfaces for the network adapter built in my computer.**

---

## Real Internet Speed

* Open **Powrshell**.
* Update **Winget** database with `winget source update`.
* `winget install ookla.speedtest.cli` to install Ookla.
* `speedtest` to run the internet real speed test.
* It will show the following information:
	* Server:	INFINITUM - Hermosillo (id: 60619)
	* ISP:		Telmex DSL
	* Idle Latency:	4.91 ms	(jitter: 0.17ms, low: 4.75ms, high: 5.02ms)
	
	* Download:	76.88 Mbps (Data used: 108.0 MB)
			31.74 ms (jitter: 19.43ms, low: 11.87ms, high: 336.80ms)
	* Upload:	52,12 Mbps (Data used: 76.1 MB)
			713.57ms (jitter: 83.76ms, low: 19.40ms, high: 1361.31ms)


That information means:
* Server INFINITUM - Hermosillo (id: 60619): Comercial name for the server.
* ISP (Internet Service Provider) Telmex DSL: Telmex is the company that provides internet service. DSL is the type of conection (Digital Subscriber Line): uses copper telephonic pair, good latency on resting mode, good download speed, **strong upload limitations**, suffers bufferbloat (that is the reason for the 713.57ms on upload latency).
* Idle Latency 4.91: is a very low latency, this means I'm very close to the server.
	* jitter at 0.17ms is really low, this means great stability.
* Download at 76.88 Mbps is **my real internet speed**. Means I'm getting 77 Mbps from the network.
* Upload at 52.12 Mbps (this is a really good speed).
	* Upload latency at 713.57ms is a lot, and the jitter at 83.76ms too. This can be due to: bad buffer management by the router, lots of traffic on upload channel, server limitations. This happens in old routers, saturated networks, DSL conections.




