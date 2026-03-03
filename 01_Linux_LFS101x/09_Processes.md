## IX.- PROCESSES
### 1.- What is a process?
1. A process is simply an instance of one or more related tasks (threads) executing on your computer.
2. It is not a progra or a command.
3. A single command may actually start several processes simultaneously.
4. Some processes are independent of each other, and others are related.

### 2.- Process types
1. Interactive processes:

Need to be started by a user, either at a command line or through a graphical interface. For example: bash, firefox, top, Slack, LibreOffice.

2. Batch processes:

Automatic processes which are scheduled from and then disconnected from the terminal. These tasks are queued and work on a FIFO (Firts-In, First-Out) basis. For example: updateb and idconfig.

3. Daemons:

Server processes that run continuosly. Many are launched under system startup and they wait for a user or system request indicating that their service is required. For example: httpd, sshd, libvirtd, cupsd.

4. Threads:

Lightweight processes. They run under the umbrella of a main process. They are scheduled on a run by the system on an individual basis. An individual thread can end without terminating the hole process; and a process can create new threads at any time. Many non-trivial programs are multi-threaded. For example dconf-service, gnome-terminal-server.
* A thread is the minimum execution unit within a process.

5. Kernel Threads:

Kernel tasks that users neither start or terminate and have little control over. For example: kthreadd, migration and ksoftirqd.

### 3.- Process schduling and states
1. A critical kernel function called the **scheduler** constantly runs on and off the CPU sharing time according to relative priority.
2. When a process is in a so-called **running state** means:
    1. It is either **currently** executing instructions on a CPU, or
    2. It is **waiting** to b granted a share of time so it can execute. All processes in this state reside on what is called a **run queue**.

3. **Sleep state**: is when a process is waiting for something to happen before they can **resume**. They are sitting in a wait queue.
4. **Zombie state**: is a process that has finished executing, but still remains listed in the process table because its parent process has not yet collected its exit status.

### 4.- Process and state IDs
1. The operating system keeps track of processes by assigning a unique process ID (PID).
2. PID is used to track process state, CPU usage, memory, etc.
3. New process IDs are usually assigned in ascending order. Thus, PID 1 denotes the **init** process (system initialization process).

### 5.- PID Types
1. Process ID **PID**: Unique Process ID number.
2. Parent Process ID **PPID**: Parent ptocess that started this process.
3. Thread ID **TID**: THread ID number: for multi-threaded process, each thread shares the same PID, but has a unique TID. 

