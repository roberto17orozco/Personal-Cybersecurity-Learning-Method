# GIT basics
[GitHub](http://github.com) is a website where people in the Information Technology field upload their programs, scripts, achievements, and learning projects.

The place where you upload files and directories is called *repository.* Repositories work with branches to keep information organized.

This file contains the basic commands used to upload and manage my files into my repository: *Personal-Cybersecurity-Learning-Method.*    

## Repository purpose
This repository will have two functions:
1. It will have a record of files that contain notes about my learning process. It will serve as a place for reviewing notes to strengthen my learning, and a reference point whenever doubts come up.
2. It will serve as my portfolio. It will show my learning progress, completed tasks, lessons and courses.  

## Setting up a repository on Linux
1. Create a new repository on the GitHub URL.
2. On your Linux system open the directory you want to turn into a repository, e.g. *~/Documents/Cybersecurity.*
3. Name the first branch: `git config --global init.defaultBranch <name for the branch>`. I named mine: **Main**
4. To verify that: `git config --global init.defaultBranch`, terminal should return: **Main**
5. `git init` to turn the directory into a *repository.*
6. `git remote add origin <repository URL>` to link the local repository to GitHub URL repository.
7. `git push --set-upstream origin Main` to send the Main branch to the GitHub URL.

### Uploading files to the repository
Lets asume that you have created new files, changed the name for some of them, etc.
1. `git status` to verify what is happening in repository.
    * `On Branch Main` means you are working on that branch. Everything you do reflects on that branch.
    * `Your branch is ahead of 'origin/Main' by 1 commit.
  (use "git push" to publish your local commits)`. 
    "Your branch" is the local one, the one on your Linux system, and "origin/Main" is the URL's. 
    * `Changes not staged for commit` means that you have made changes on your Linux directory, but they are not ready to **commit.**
        * Most probably you will find something like this:
        
            - deleted:    ../First_VSCode_file.md
            - deleted:    ../Nano_and_Git_Add_Commit_and_Push_notes.md
            - deleted:    Kernel_panic.md
        * Those are the files you have deleted, duplicated or removed. In that case, use `git add -u` to add *deleted* and *modified* files on the next **commit.**. The -u option is for update.
        * `git commit -m "Confirm file deletions"`
        * `git push` now those files will be removed from *local git* and the *URL repository.*
        * Verify your `git status` the `Changes not staged for commit` won't be there anymore.
    * The next section of the `git status` is the `Untracked files:`. This are new files that haven't been added to be commited and then pushed.
    * You can work them one by one, but if you are sure they are all **new files** and the commit description will be the same for all you can add, commit and push them all at once.
2. `git add .` to add only new and modified files. You have to be at the directory where the files are located.
3. `git commit -m "Add newly created files to repository"` (-m option is for message).
4. `git push`
5. Verify your `git status`you will se now: **Your branch is up to date with 'origin/Main'.**

* Now all the files on your local repository are on [GitHub](http://github.com) too and they are on the correct directories.
* Usage of `git add -u` is very important because you separate changed and deleted files from `untracked` newly created files with a single detailed **commit** for both cases. This keeps your repository clean and organized.

### Updating changes on existing files
For specific files that already exist and have been *pushed* to the GitHub repository the workflow is:
1. Use `git add <file name>`
2. `git commit -m "commit description">`
3. `git push`

### When your repository is up to date
When your repository is up to date you will see the following lines:

>git status

>On branch Main

>Your branch is up to date with 'origin/Main'.

>nothing to commit, working tree clean

### Remove a directory from your repository but keep it on your file system

This may happen, specially if you are changing routes to re-organize your file system and repo as well.

1. `git rm -r --cached <the directory you want to remove>` you have to excecute this on the directory that contains the directory you want to remove.

### Add a directory to your repository
1. Simply excecute `git add <directory name>` on the directory that contains the directory you want to add. Remember, the new added directory must have a file, e.g. a *README.md.*
2. `git commit -m "description"`.
3. `git push`.


### To remove files or directories from STAGING
Sometimes you may change your mind after adding `git add .` files or directories. To remove those from the **staging** area:
1. `git restore --staged <file/directory name>`


### To see the history of your commits
1.- To see what commits you have done to specific files execute:
`git log -10 --name-only --oneline`
Where "-10" is the number of commits you desire to take a look at.

### .gitignore
To avoid **Git** to push some selected files and directories you will have to add their names (for files) or paths (for directories) to file **.gitignore**.
1. Locate **.gitignore** file, should be on your repository main directory on your system.
2. Open it and write the exact name for the file on a line.
3. Type the exact path for the directory you want to Git to ignore, if it is not a direct directory to the main one, you should type the complete route begining with the next directory after the main one. 
---

Thanks for reading.

-Roberto Orozco






