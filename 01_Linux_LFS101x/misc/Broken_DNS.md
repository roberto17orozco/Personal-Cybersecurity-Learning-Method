# Broken DNS
A problem presented into my system today. I was trying to update the system to install `gimp` afterwards, and an error resulted for the `sudo apt update` command.
These errors were:
1. Temporary failure resolving 'http.kali.org'
2. Temporary failure resolving 'packages.microsoft.com'

## What is this error about?
1. `ping google.com`
If you get:
> Temporary failure in name resolution

it means your DNS (Domain Name System) is broken.

But before going ahead, verify you have a real internet conction with:
`ping 8.8.8.8` if it works with lines like this:
> $ ping 8.8.8.8   
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=255 time=40.6 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=255 time=38.1 ms
64 bytes from 8.8.8.8: icmp_seq=6 ttl=255 time=39.3 ms

it means you do have real internet connection.

Now ...
1. `sudo nano /etc/resolv.conf`
2. Replace everything with:
    > nameserver 8.8.8.8  
    nameserver 1.1.1.1

(no empty lines inbetween). Save and exit `nano`.

3. Try `ping google.com` if it works, **problem solved** your DNS is working again.

4. If it doesn't, then `NetworkManager` isn't using file `/etc/resolv.conf`

---

5. Configurate DNS in **NetworkManager** not in `/etc/resolv.conf`
6. `nm-connection-editor`. Is this the *NetworkManager?*
7. Select your active connection. On a VM it will be the "Ethernet"(the only one available).
8. Go to IPv4 settings.
9. Change **Method** to `Automatic (DHCP) addresses only`.
10. On **DNS servers** write:
> 8.8.8.8, 1.1.1.1
11. Save.
12. Disconect and reconect the network.
13. `nmcli connection down: Wired connection 1"`
14. `nmcli connection up: Wired connection 1"`
15. Now try `ping google.com` again.
16. It worked propperly, now ..
17. `sudo apt install gimp`
18. Process completed with no errors. 👍


* For me, editing IPv4 configuration on NetworkManager was the solution. After following the steps indicated above, I got `ping google.com` working.
* Editing NetworkManager solves the DNS problem permanently.
* Intermitent failures on this matter will disapear with this *personalized* configuration.

But ...



## Why does this happen?
Been working on my Kali on a VM for a couple of months now and never had this problem about *temporary failures in name resolution.* This are the possible reasons:
1. Kali uses **NetworkManager** and this program re-generates file `/etc/resolv.conf` everytime you:
    1. Reconnect to Wi-Fi.
    2. Change your network.
    3. Reboot your VM.
    4. Suspend or reboot your actual physical computer.


---
One last note:
If you would like to know which is your active connection try: `nmcli device status`. You will see something like this:

* DEVICE:     eth0                  My real connection for the VM
* TYPE:       ethernet              
* STATE:      connected
* CONNECTION: Wired connection 1    Profile that should be edited.

---

Thanks for reading.
- Roberto Orozco




