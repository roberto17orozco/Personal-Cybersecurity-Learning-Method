## XV.- THE BASH SHELL and BASIC SCRIPTING

### Contents
1. **Scripts**: tell the system a series of actions that it needs to take to reuse them in the future and automate a lot of the things you do.
2. Featurs and capabilities of various shells.
3. Shell syntax
4. Enviroment variables and how to pass arguments from the outside.
5. Arithmetic expressions.

### 1.- Shell scripting
1. In order to **automate a set of commands**, you will need to learn how to write **shell scripts**.
2. Most commonly in Linux, these scripts are developed to be run under the **bash** command shell interpreter.
3. Several of the benefits of deploying scripts:
    1. Automate tasks and reduce risk of errors.
    2. Combine long and repetitive sequences of commands into a single command.
    3. Share procedures among several users.
    4. Quick prototyping, no need to compile.
    5. Create new commands using combination of utilities.
    6. Provide a controlled interface to users.

### 2.- Command Shell Choices
1. Commonly used interpreters include:
    * /bin/perl
    * /bin/bash
    * /bin/csh
    * /bin/python, and 
    * /bin/sh

2. You can save shell scripts in a file, you can use it to create a new script variation and share it.
3. LInux provides a wide choice of shells; exactly what is available on the system is listed in **/etc/shells**.

#### Available shells on my system
![shells](Linux_LFS101X_screenshots/15.1_shells.jpg)

### 3.- History of Command Shells
1. The history of command shells begins in the early days of time‑sharing systems in the 1960s and 1970s, when computers first allowed multiple users to interact with a machine through text-based interfaces. Early shells like the Multics shell and the Thompson shell (sh), created for Unix in 1971, introduced the idea of interpreting user commands, running programs, and supporting simple scripting. As Unix evolved, so did its shells: the Bourne shell (sh) became the standard for scripting, while later shells such as the C shell (csh) and Korn shell (ksh) added features like command history, aliases, and improved programming constructs.

2. By the 1980s and 1990s, shells became central to system administration and automation. The Bourne Again Shell (bash), released in 1989, combined the strengths of earlier shells and became the default on most Linux systems. Meanwhile, other operating systems developed their own shells, such as CMD and later PowerShell on Windows, which introduced object‑based pipelines instead of text-based ones. Today, command shells remain essential tools for developers, administrators, and cybersecurity professionals, offering powerful scripting capabilities, automation, and direct control over operating systems.

### 4.- Shell scripts
1. A shell is simply a **command line interpreter** which provides the user interface for terminal windows.
2. A **command shell** can also be used to **run scripts**, even in non-interactive sessions without a terminal window, as if the **commands** were being directly typed in.
    * For example:
        * Typing `find . -name "*.c" -ls` at the CLI, accomplishes the same thing as executing a **script file** containing the lines:
            1. #!/bin/bash
            2. find . -name "*.c" -ls

    * The first line of the script which starts with **#!** contains the full path of the command interpreter, in this case **/bin/bash** that is to be used on the file.
    * The special two-character sequence **#!** is often called **shebang**, and avoids the usual rule that the pound sign (#), delineates the following text as a comment.
        * Usually the pound sign alone means the line is a comment within the file.

### 5.- A simple bash script
1. Write:
    1. `cat > hello3.sh`
    2. #!/bin/bash
    3. echo "Hello Linux Foundation Student"
2. Enter
3. `Ctrl+D` to save the file
4. Run:
    * `./hello3.ssh` this way of running the command requires the file has execute permissions; or
    * `$ bash hello.sh` this way **does not** requires execute permissions for the file.

![script1](Linux_LFS101X_screenshots/15.2_script1.jpg)

### 6.- Interactive example using Bash Scripts
1. The user will be prompted (asked-instructed) to enter a value, which is then displayed on the screen.
2. The value is stores in a termporary variable **name**.
3. We can reference the value of a shell variable by using a **$** in front of the variable name, such as **$name**.
4. Create the file **getname.sh** in your favourite text editor with the following content:

![getname](Linux_LFS101X_screenshots/15.3_getname.jpg)
***You can see the actual script [here](https://github.com/roberto17orozco/Personal-Cybersecurity-Learning-Method/blob/Main/01_Linux_LFS101x/scripts/03_getname.sh).***
