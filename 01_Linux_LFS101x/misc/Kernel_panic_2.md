# Kernel panic 2 (continuation ...)

---

Alright, on *Kernel_panic_1.md file* I stated that the next action after getting the 
`Wireshark` tool related error on the downloading process was going to be going home and 
connect my computer to my private internet and run `sudo apt full-upgrade -y`.

Well, I didn't ... hehe 

I got home and skipped the full upgrade action to continue learning and working on Kali, 
I don't remember exactly what I did, a lot was going on that moment.

I will run the upgrade now and leave this file open meanwhile ...

`sudo apt full-upgrade -y`: Summary: Upgrading= 7, Download size= 28.2 MB
`sudo apt update`: **77 packages can be upgraded ...**
`sudo apt full-upgrade-y`: Summary: Upgrading= 77, Download size= 78.9 MB
`sudo apt update`: **All packages are up to date.**

Ok, now you can see what happened and what I did. 

Conclusion for the last part of the **Kernel Panic** troubleshooting process was to run a 
full upgrade on a private network to avoid the **Firewall** interruption I had on the
Starbucks I was doing all this stuff.

In summary, you have tu first *look* for updates and afterwards you have to *upgrade* the
system.

After getting **All packages are up to date** you can tell the process is over, the Kernel 
Panic problem solved, and all other packages and files fiexed.


---

Thanks for reading,
- Roberto Orozco
