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



