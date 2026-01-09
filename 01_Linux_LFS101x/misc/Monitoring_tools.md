# Monitoring tools

The purpose for this document is to show a variety of tools to monitor and analyze **system** and **internet connection** development on **Kali**

---

## System

....

* 
* 


---

## Internet connection

Sometimes to take actions during some tasks and to stablish the best work-flow it is necessary to know how fast is the connection available at a particular moment on a particular place. For that, here are a set of tools that can be use:

### bmon (Bandwidth Monitor)

Is a **terminal tool** that shows: input/output traffic, real time speed, active interfaces (eth0, wlan0, tun0, etc.), ASCII graphics, and detailed statics.

* `sudo apt install bmon`
*  `bmon`


Once the interface is open you can take a look at 6 different main sections for all the Interfaces using a connection.

* RX: input traffic, what the interface recives. 
	* bps: bytes per second being received.
	* pps: packages per second being received.
	* %: what percentage to the total of the interface is being used.

* TX: output traffic, what the interface sends.
	* bps: bytes per second being sent.
	* pps: packages per second being sent.
	* %: what percentage to the total of the interface is being used.



