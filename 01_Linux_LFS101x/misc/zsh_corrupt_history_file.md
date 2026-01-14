# ZSH: Corrupt history file
This problem occours sometimes when you suddenly reboot or shutdown the system. You may have to do that because it freezes.

When you initiate the system again and open a terminal you will read at top of it:
> zsh: corrupt history file /home/robert/.zsh_history

* Keep in mind that `zsh` comes from **Z-Shell**. 
* So `zsh` is the interpreter between your **terminal** and your system. Is what makes the system excecute what you command on the terminal.

To troubleshoot this problem proceed as follow:
1. `rm -f ~/.zsh_history` to remove the zsh history file.
2. `touch ~/.zsh_history` to create a new zsh history file.
3. `chmod 600 ~/.zsh_history` to protect the file.
4. `zsh -df` to clean history written in memory.
5. `exit` to excecute a clean exit.
6. Open a new terminal again. 

> zsh: corrupt history file /home/robert/.zsh_history

shouldn't appear anymore.

* .zsh_history is in directory /home/robert
* `ls -al` on that directory and make sure you only have 1 *.zsh_history* related file. Remove anything like: .zsh_history_bad or .zsh_history.backup.

Thanks for reading.
- Roberto Orozco
