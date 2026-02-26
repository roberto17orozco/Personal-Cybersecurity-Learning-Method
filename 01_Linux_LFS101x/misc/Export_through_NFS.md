# Export a directory using NFS
What I'm trying to do is to export my /home/robert/Documents/Cyberscurity/ directory on my Kali VM to my /home/roberto/Documents directory on my Ubuntu VM.
Both VMs are on the same physical (host machine)

## Configure your Type-2 Hypervisor and your Virtual Machines

### Linux User ID
Verify both (Kali and Ubuntu) user IDs (UID) are the same.

1. On Kali type `id robert` (it returned: uid=1000(robert)).
2. On Ubuntu type `id roberto` (it returned: uid=1000(roberto)).
	* We are good to go on...
	
### Configure your Type-2 Hypervisor
Now make sure yor **Type-2 Hypervisor** is configured to permit networking between your 2 VMs. That means both machines should be on the same virtual network (NAT, Host-Only, or Bridged).

1. `ip a` on both VMs
2. If you get an ip on the range of **10.0.2.x** on both your VMs they are using NAT (if your Type-2 Hyperbior is **VirtualBox**).
3. But although both are using NAT, **VirtualBox** does not permit both VMs connect to each other. Both are isolated and they can only acces interneth through the host.
4. Thus, you should change your VMs to a network where they can connect directly.
5. Suggested option is to use **Host-Only Adapter.**


### Set and configure Host-Only Adapter
1. Verify your Kali and Ubuntu configuration settings allows you to choose **Host-Only Adapter** under **Adapter 2** under **Network Settings.**
2. If you do not find **Network Settings** (which is what happened to me), proceed as follow:
	* Shutdown all our VMs.
	* Close Virtual Box as well.
	* On Windows (host machine) open **cmd** as administrator and run `VBoxManage hostonlyif create` to create **Host-Only Adapter**. It may not work because Windows isn't able to find the proper tool at the moment. In that case ...
	* Verify where **Virtual Box** is installed, it may be in > C:\Program Files\Oracle\VirtualBox\
	* Look for the file **VBoxManage.exe**, if you find it then go to **cmd** again and run `"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" hostonlyif create`.
	* Now double-check that the **Host-Only** interface was created properly with `"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" list hostonlyifs`.
	* Give an IP to the Host-Only interface with `"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" hostonlyif ipconfig vboxnet0 --ip 192.168.56.1 --netmask 255.255.255.0`. That creates the classic Virtual BOx Host-Only network; Host: 192.168.56.1, VMs: 192.168.56.x
	
### Activate Host-Only on your VMs
Virtual Box is now set up with Host-Only, now you have to activate it on the VMs.
1. Make sure your VMs are not running.
2. Select the **Kali** machine, then click on Configuration.
3. Go to Network section.
4. Adapter 1 leave NAT (so the machine continue to be able to connect to internet).
5. Adapter 2: check the box tu enable it.
6. Connected to: **Host-Only Adapter**.
7. Name: **VirtualBox Host-Only Adapter** or **VirtualBox Host-Only Adapter #2**.
8. Repeat the above on your **Ubuntu** VM. Notice that both **Names** for the adapter have to be equal in order for both VMs to connect.

### Ping VMs to each other
Verify Kali and Ubuntu VMs can connect to each other by running `ping <Ubuntu IP address on Kali>` and `ping <Kali IP address on Ubuntu>`.
On both Kali and Ubuntu you should use the Host-Only IP.
* On Kali the interface should be something like **eth1**.
* On Ubuntu the interface should be something like **enp0s8**.
Both IP addresses should be next to **inet**.
If ping runs correctly you are good to move on to ...

## Export the Kali directory to the Ubuntu directory
Now that all network configurations are updated and clean, you can proceed with the directory (and subdirectories) transfer.

### Export in Kali
1. In Kali (which is the **server**) run `sudo mkdir -p /export/cyber` to create a new directory.
2. `sudo mount --bind "/home/robert/Documents/Cybersecurity" /export/cyber` to create the **bind mount** (this creates a mirror to the real directory).
3. Verify it with `ls /export/cyber`, it should show the same as in > /home/robert/Documents/Cybersecurity.
4. `sudo nano /etc/exports` to edit and configure > /etc/exports
5. Add the line `/export/cyber 192.168.56.0/24(rw,sync,no_subtree_check)`, save and exit.
	* The IP address used on this line is generic, it means "export /export/cyber/ contentents to any client on the 192.168.56.0 IP range".
6. `sudo exportfs -ra` and `sudo systemctl restart nfs-kernel-server` to apply changes.

### Mount in Ubuntu
1. In Ubuntu (which is the client) run `sudo mkdir -p /mnt/cyber` to create a directory to mount.
2. `sudo mount 192.168.56.101:/export/cyber /mnt/cyber`, to mount the server directory, to the created directory on step 1.
	* The IP address used on this line has to be the exact IP for the server (on this case 192.168.56.101).
3. Verify this with `ls -l /mnt/cyber`.
	* At this point you get remote access to the **server** directory with no need to copy anything to the client's system, but if you want to copy the items follow next step.
4. `sudo rsync -avh -progress /mnt/cyber/ /home/roberto/Documents/` to copy without loosing permits.




	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
