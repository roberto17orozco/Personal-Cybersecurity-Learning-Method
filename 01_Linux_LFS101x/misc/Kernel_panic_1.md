# Kernel Panic

This is a booting problem I learned about yesterday and it presented after I
tried to update and upgrade my Kali system.

I was trying to run a tool called `htop` for the first time but before doing that, **updating** and **upgrading** 
the system seemed like a good idea for me, so I ran `sudo apt update && sudo apt full-upgrade -y`. 

The system started running the upgrades but after a while it frozen and the *Caps* key
 light on my computer started blinking.

I learned that this is known as **Kernel Panic** and happens when the system finds a
*critical error* for wich cannot be recovered by itself, entering on a state of
**stop funtioning** to protect the *hardware.*

This happened most likely due to *video drivers* conflicts between my *VM* and my *Host Machine.*

---

## First Act

After waiting some time for the system to *un-froze* I did some research to solve
the problem and learned about conflicts during an upgrade on *VMs*, specifically on *video and network drivers.* 

So I proceed to take the following actions:

* Stop running my VM (shut it down).
* Start running my VM and log in to my **Kali** acount.
* Fix pending configurations because the upgrade didn't finish its process, I did that running
 `sudo dpkg --configure -a`: this command line is to fix the broken/locked *package database*.
What this command does is to finish installation for those packages or files that the 
system wasn't able to install.
* Fix broken dependencies: `sudo apt install -f`.
* Clean corrupt temporary files" `sudo apt clean && sudo apt update`.
* Re-try installation: `sudo apt full-upgrade`.
* Reboot: `sudo reboot`.

---

## Second Act

After the last reboot the system didn't allow me to start a session, it showed a black screen 
with the big *Kali* dragon on a very light white shade. It also showed me the *caret* or 
*text cursor* blinking. Didn't know what to do so I did some research and realized that this happened
 due to a problem with my GUI (Graphical User Interface); Kernel engine started correctly but the GUI
 *didn't know how to start.*
       
So I proceed to take  the following actions:

* Enter the **Emergency Terminal (TTY):** `Ctrl + Alt + F2`.
* Log in to my *Kali* session.
* Remove the package lock: `sudo rm /var/lib/dpkg/lock-frontend` and then `sudo rm /var/lib/apt/lists/lock`.
What these commands do is to remove lock files created by *Git* and *Apt* when the *Kali Panic* event occurred.
* Repeat `sudo dpkg --configure -a`.
* At this point the `sudo dpkg --configure -a` finished but presented the following error: "errors were
 encountered while processing texlive-latex-base tex-common". For that reason the next step I took was:
* `sudo apt --install -f`: it ran and finished with no errors.
* `sudo dpkg --configure -a` again: finished with no errors, that means the `sudo apt --install -f` command solved the 
*texlive-latex-base tex-common* problem that `sudo dpkg --configure -a` couldn't.
* Without leaving the **TTY** I verified there was nothing left to download,, update and upgrade: ran
 `sudo apt update && sudo apt full-upgrade -y`.
* After 5 minutes the *process progress bar* got stucked at 90%.
* Learned about *"invisible windows asking to accept a license:* during this process: what I did is to press `tab`
 and then `enter`, problem solved: process finished with no errors.
* Ran `sudo apt update && sudo apt full-upgrade-y` again to verify everything was updated. 
* Prompt returned that everything was updated and that a series of packages were installed automatically and that
they are not needed any longer; asked me if I wanted to remove them now with `sudo apt autoremove` but used 
`sudo apt autoremove -y` instead.

*System was clean and updated now*

* Reboot system: `sudo reboot`.
* Log in to **Kali** and verify everything is ok; use `lsb_release -a` to verify what *Kali version* was installed: 
resulted on *Release: 2025.4*.
* Shut down the VM.

*The next day ...*

---

## Third Act

After all I did, the next day I started Kali to continue my learning path and the system didn't start, it showed me
a **black screen** again... I took the following actions:

* For a reason I don't remember right now I pressed `tab` then `enter` on the black screen.
* A new screen appeared and showed me a process being run, the last line read something about *job systemd* and a
timer with **/no limit** next to it.
	* I learned that this is related to an specific service *(Job)* and that wasn't able to initiate it or reboot it.
	* The **no limit* line means that it was going to continue trying till the process ends.
	* I had to break that *bucle* by shuting down my **VM**.
* Turned on the VM and started Kali again.
* This time I started it with the *Graphic Mode trick*.
* On the **GRUB** menu I verified that I was posisionated on the first option and pressed `e`, this opens the *start up editor*.
* Located the line that starts with *linux* and at the end of the line (after *quiet splash*) typed `nomodeset`.
* Press `Ctrl + X` to start up with this configuration.
	* The reason for the **Job Systemd / no limit** line most likely was because the *Graphic Interface (Light DM)* service was trying to start before the *new Kernel* loaded the *video modules*.
	* By using `nomodeset` I forced the system to use a *generic video mode* that doesn't crash.
* Once on the prompt I ran `sudo update-initramfs -u` then `sudo update-grub` in order to properly set the new Kernel.
	* `sudo update-initramfs -u` re-builds the start up or booting system that contains all the *drivers* needed by the Kernel to recognize the hardware including **video** and **disk**.
	* `sudo update-grub` updates the starting menu in order to make sure that uses the correct version of the system.
* Reboot: `sudo reboot`.

*Once again, the black screen with the white-light-Kali dragon...*
*When that light-white kali dragon appears it is called **Plymouth** *and it regards to a mask that hides the boot letters*

* Since I already updated the *system* and the *start up (boot) applications* the problem is purely on *video compatibility* between 
**KALI** and my **VM**.
	* I tried to start the **TTY** to run some commands regarding *lightdm* and  *xfce* but it didn't work so I ...
	* Turned off the VM.
	* With the Kali VM turned off I checked some **Virtual Box** general settings:
		* Enable / Disable 3D acceleration.
		* 128 MB on video memory.
		* Set VMSVGA as the graphic controller.

* Everyghing was like that, I didn't have to change anything so I turned my Kali VM on again.
* It started with no problem at all.
	* Seems like the issue was that the system needed only a **cold reboot** for the VM to finish some temporary processes on volatile memory.

* Ran `sudo apt update` to verify everything was updated.
* Prompt returned that there were 7 packages available to be updated.
* Ran `sudo apt full-upgrade -y` and got 3 error messages related to **Wireshark** a tool for network analysis the system was trying to 
download. What happened was that I was using a *public network* behind a network **Firewall** (a Cisco Meraki) that catalogued the server as suspect or dangerous.
* Therefore I'm about to run `sudo apt full-upgrade -y` now at home and will tell you what happened on a second file that will be named: **Kernel_panic_2.md** hehe ...

---

Thanks for reading.
- *Roberto Orozco*


 






