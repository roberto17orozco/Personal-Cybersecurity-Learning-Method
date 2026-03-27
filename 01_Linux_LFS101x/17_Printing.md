## XVII.- PRINTING
### 1.- CUPS overview
1. Common Unix Printing System (CUPS) is the underlying software Linux systems use to print from applications, web browsers, office suite such as LibreOffice, or PDF document viewer such as `evince`.

### 2.- How does CUPS work?
1. CUPS carries out the printing process with the help of its various components:
    * Configuration files
    * Scheduler
    * Job files
    * Log files
    * Filter
    * Printer drivers and
    * Backend

### 3.- Scheduler
1. Manages print jobs.
2. Handles administrative commands.
3. Allows users to query the printer status, and
4. Manages the flow of data through all CUPS components.

### 4.- Configuration files
1. The print **scheduler** reads server settings from several configuration files.
2. The two most important are `cupsd.conf` and `printers.conf`.
3. These and all other CUPS configuration files are stored in **/etc/cups/**
    1. `cupsd.conf`:
        * Is where most system-wide settings are located.
        * It does not contain any printer-specific details.
        * Most of the setting available are related to network security:
            1. Which systems can access CUPS network capabilities.
            2. How printers are advertised on the local network.
            3. What management features are offered.
    2. `printers.conf`:
        * Is where you will find the printer-specific settings.
        * For every printer connected to the system, a corresponding section describes the printer's status and capabilities.
        * This file is generated or modified only after adding a printer to the system.

4. You can view the full list of configuration files by typing: `$ ls -lF /etc/cups`.

### 5.- Job files
1. CUPS stores print requests as files under the **/var/spool/cups** directory.
2. Data files are prefixed with letter `d`.
3. Control files with letter `c`.

### 6.- Log files
1. Log files are placed in **/var/logs/cups** and are used by the **scheduler** to record activities that have taken place.
2. These files include access, error, and page records.
3. To view what log files exist, type `$ sudo ls -l /var/log/cups`

### 7.- FIlters, Printer Drives, and Backends.
1. CUPS uses filters to convert job file formats to printable formats.
2. Printer drivers contain descriptions for currently connected and configured printers and they are usually stored under **/etc/cups/ppd**

### 8.- Managing CUPS
1. Assuming CUPS has been installed you'll need to start and manage the CUPS daemon so that CUPS is ready for configuring a printer.
2. All management features can be done with the `systemctl` utility:
    * `$ systemctl status cups`
    * `$ sudo systemctl [enable/disable] cups`
    * `$ sudo systemctl [start/stop/restart] cups`

### 9.- Configuring a printer from the GUI
Go to:
1. Settings
2. Devices
3. Printer
4. Add (you can start an automatic search or type the IP address for the printer).
5. Apply.

Now the printer is ready to work.

### 10.- Adding printers from the CUPS web interface
1. CUPS comes with its own web server (localhost:631) which makes a configuration interface available via a set of **CGI** scripts, it allows you to:
    * Add and remove local/remote printers.
    * Configure them
    * Control print jobs

### 11.- Printing from the Graphical Interface
1. Many **graphical applications** allows users to access printing features using the `Ctrl+P` shortcut.
2. To print a file, you first need to specify the printer (or a file name and location if you are printing to a file instead).
3. Select printing options.
4. Submit document for printing.
5. Document is then submitted to CUPS.
6. You can use your browser to access the CUBS web interface at http:/localhost:631/ to monitor the status of the printing job.

### 12.- Printing from the command-line interface
1. CUPS provides two command-line interfaces: `lp` (system V) or `lpr` (BSD) to print.
2. With them you can print: text, PostScript, PDF, and image files.
3. These commands are useful in cases where printing operations must be automated (from shell scripts for instance).
4. `lp` is just a command-line front-end to the `lpr` utility that passes input to `lpr`.
5. Thus we will discuss only `lp` in detail.

### 13.- Using lp


| Command                         | Description                                   |
|---------------------------------|-----------------------------------------------|
| `lp <filename>`                 | to print the file to default printer.         |
| `lp -d printer <filename>`      | to print to a specific printer.               |      |
| `lp -n number <filename>`       | to print multiple copies.                     |
| `loptions -d printer`           | to set the default printer.                   |
| `lpq -a`                        | to show the queue status.                     |
| `lpadmin`                       | to configure printer queues.                  |

* `program | lp echo string | lp` to print the outcome of a program.

### 14.- Managing print jobs
1. In Linux, command-line print job management commands allow you to monitor the job state as well as managing the listing of all printers and checking their status, and cancelling or moving print jobs to another printer.
2. Some of these commands are listed in the table:



| Command                               | Description                                                                 |
|---------------------------------------|-----------------------------------------------------------------------------|
| `lpstat -p -d`                        | to get a list of available printers, along with their status.               |
| `lpstat -a`                           | to check the status of all connected printers, including job numbers.       |
| `cancel job-id` or `lprm job-id`      | to cancel a print job. For example `cancel 12`                              |
| `lpmove job-id newprinter`            | to move a print job to a new printer. For example `lpmove 8 epson-new`      |

### 15.- Working with PostScript and PDF
1. PostScript is a standard page description language.
2. It effectively manages scalling of fonts and vector graphics to provide quality printouts.
3. It is purely a text format that contains the data fed to a PostScript interpreter.
4. PostScript has been, for the most part, superseded by the PDF fortmat (Portable Document Format) which produces far smaller files.

### 16.- Working with enscript
1. `enscript` is a tool that is used to convert a text file to PostScript and other formats.
2. It also supports Rich Text Formats (RTF) and HyperText MarkUp Language (HTML).
3. You can convert a text file to two columns `(-2)` formatted `PostScript` using the command:

    `$ enscript -2 -r -p psfile.ps textfile.txt`
    * `-r` rotates the output to print (landscape mode).

4. The commands that can be used with `enscript` are listed in the table below (for a file called **textfile.txt**).

| Command                                      | Description                                                                 |
|----------------------------------------------|-----------------------------------------------------------------------------|
| `enscript -p psfile.ps textfile.txt`         | convert a text file to PostScript (saved to psfile.ps).                     |
| `enscript -n -p psfile.ps textfile.txt`      | convert a text file to **n** columns where **n = 1–9** (saved in psfile.ps). |
| `enscript textfile.txt`                      | print a text file directly to the default printer.                          |

### 17.- Converting between PostScript to PDF
1. In the table below yo can see the commands and its description for three different packages:
    1. **ghostscript** manages `ps2pdf` and `pdf2ps`
    2. **poppler** manages `pstopdf` and `pdftops`
    3. **Image Magik** manages `convert`



| Command                          | Converts     |
|----------------------------------|--------------|
| `ps2pdf file.ps`                 | ps to pdf    |
| `pdf2ps file.pdf`                | pdf to ps    |
| `pstopdf input.ps output.pdf`    | ps to pdf    |
| `pdftops input.pdf output.ps`    | pdf to ps    |
| `convert input.ps output.pdf`    | ps to pdf    |
| `convert input.pdf output.ps`    | pdf to ps    |


### 18.- Viewing PDF content
1. The most common Linux PDF readers are:
    * `evince` is the most widely used program, and
    * `okular` is based on the older kpdf available distros with KDE enviroment.

2. Adobe Acrobat Reader is no longer available for Linux.

### 19.- Manipulating PDF
1. There are some available programs that allow users accomplish PDF manipulation operations such as:
    1. Mergin/splitting/rotating PDF documents.
    2. Repairing corrupted PDF pages.
    3. Pulling single pages from a file.
    4. Encrypting and decrypting files.
    5. Adding, updating, and exporting PDF metadata.
    6. Exporting bookmarks to a text file.
    7. Filling out PDF forms.

2. These programs are:
    1. `qpdf` which is full-featured
    2. `pdftk`  which is reimplemented in Java
    3. `ghostscript` (`gs`) which is a little more complex to use.

### 20.- Using qpdf
1. You can accomplish a wide variety of tasks using `qpdf` including:



| Command                                              | Description                                                                                     |
|------------------------------------------------------|-------------------------------------------------------------------------------------------------|
| `qpdf --empty --pages 1.pdf 2.pdf -- 12.pdf`         | merge the two documents 1.pdf and 2.pdf. The output will be saved to 12.pdf                     |
| `qpdf --empty --pages 1.pdf 1-2 -- new.pdf`          | write only pages 1 and 2 of 1.pdf. The output will be saved to new.pdf                          |
| `qpdf --rotate=+90:1 1.pdf 1r.pdf`                   | rotate page 1 of 1.pdf 90 degrees clockwise and save to 1r.pdf                                  |
| `qpdf --rotate=+90:1 -z 1.pdf 1r-all.pdf`            | rotate all pages of 1.pdf 90 degrees clockwise and save to 1r-all.pdf                           |
| `qpdf --encrypt mypw mypw 128 -- public.pdf private.pdf` | encrypt public.pdf with 128‑bit encryption using password `mypw`, output saved as private.pdf |
| `qpdf --decrypt --password=mypw private.pdf file-decrypted.pdf` | decrypt private.pdf with password `mypw`, output saved as file-decrypted.pdf          |

### 21.- Using pdftk
1. You can accomplish a wide variety of tasks using `pdftk`:


| Command                                      | Description                                                                 |
|----------------------------------------------|-----------------------------------------------------------------------------|
| `pdftk 1.pdf 2.pdf cat output 12.pdf`        | merge the two documents 1.pdf and 2.pdf. The output will be saved to 12.pdf |
| `pdftk A=1.pdf cat A1-2 output new.pdf`      | write only pages 1 and 2 of 1.pdf. The output will be saved to new.pdf      |
| `pdftk A=1.pdf cat A1-endright output new.pdf` | rotate all pages of 1.pdf 90 degrees clockwise and save result in new.pdf |

### 22.- Encrypting PDF files with pdftk
1. You can apply a password to a PDF file using the `user_pw` option:

    `$ pdftk public.pdf output private.pdf user_pw PROMPT`

2. When you run this command, you will receive a prompt to set the required password, which can have a maximum of 32 characters.
3. A new file, **private.pdf** will be created with the identical content as **public.pdf**.

### 23.- Using additional tools
1. You can use other tools to work with PDF files, such as:
    1. `pdfinfo` extracts info about PDF files.
    2. `flpsed` adds data to a PostScript document.
    3. `pdfmod` provides a graphical interface for modifying PDF files.
    

### Lab 17.1: Creating PostScript and PDF from Text Files
1. Check to see if the `enscript` package has been installed on your system, and if not, install it.
2. Using `enscript`, convert the text file **dmesg.txt** (which you can generate with `dmesg > dmesg.txt`) to PostScript format and name the result **/tmp/dmesg.ps. As an alternative, you can use any large text file on your system. Make sure you can read the PosctScript file (for example with `evince`) and compare to the original file.
    * **NOTE**: on some systems, evince may have problems with the PostScript file, but the PDF file you produce from it will be fine for viewing.
3. Convert the PostScript document to PDF format, using `ps2pdf`. Make sure you can read the resulting PDF file. Does it look identical to the PostScript version?
4. Is there a way you can go straight to the PDF file without producing a PostScript file on the disk along the way?
5. Using `pdfinfo`, determine what is the PDF version used to encode the file, number of pages, the page size, and other metadata about the file. If you do not have `pdfinfo` you probably need to install the `poppler-utils` package.

**Solution**





---
### Lab 17.2: Combining PDF's
1. You can convert two text files (you can create them or use ones that already exist since this is non-destructive) into PDF's, or you can use two pre-existing ones. Combine them into one PDF, and view the result. Do this using three different methods:
    1. qpdf
    2. qdftk
    3. gs

2. If `pdftk` is not installed, you can try to install. However, if you are on a system for which it is no longer available, you will have to use `qpdf` or `gs`.