# Force KALI startup
There could be times that due to different reasons your system doesn't start properly getting stuck at a black screen before asking for username and password. I tried to use a **TTY** `Ctrl + Alt + F2,F3,F4,F5,F6` but it didn't work.

So the actions I took afterwards were:
1. Shutdown the VM.
2. Start the VM again.
3. On **GRUB** (the little blue window) manually select **Kali GNU/Linux**.

Kali starts correctly this way but, what is the problem? It seems that GRUB is connecting to a broken Kernel or to an incorrect entry.
This use to happen:
1. After an incomplete update-upgrade.
2. An old Kernel that is set up as the default Kernel.
3. A new Kernel that doesnt load.
4. Configuration problems on GRUB.
5. A driver that broke a specific Kernel.

## Troubleshooting

1. Start Kali manually `Kali GNU/Linux`.
2. Verify the kernel you are using `uname -r`
3. Go to `ls /boot` to verify what kernels are installed on your computer. It will show you some files (initrd, vmlinuz), one of them doesn't start.
4. Force **GRUB** to start the correct Kernel always: sudo nano /etc/default/grub.
5. Replace `GRUB_DEFAULT=0` for `"Kali GNU/Linux"`.
6. `sudo update-grub` to update GRUB.
7. `sudo reboot`.

Now GRUB starts the correct Kernel automatically with no problems this far.

