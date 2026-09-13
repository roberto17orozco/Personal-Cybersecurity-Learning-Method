"""
This script explores how to import and parse text files. Preparing security log
files for analysis is essential for cybersecurity tasks. 

Parsing files means taking a raw file and breakin it into meaningful, structured
pieces that software can understand an use. It converts human-readable data into 
clean machine-readable data.

This is importan because parsing applies rules to:
- Recognize patterns
- Identify fields (names, dates, IPs, prices, etc.)
- Separate values.
- Convert them into usable structures (objects, rows, JSON, dictionaries, etc.)
"""



# Task 1:
# Import a security log text file and store it as a string to prepare it for analysis.

import_file = "data-login.txt"

# First line of the 'with' statement. 
    # with: is to open files.
# Use 'open()' to import security log file and store it as a string
    # open(): is a function that opens a file in python
# The first parameter 'import_file' is the name of the text file on your computer.
# The second parameter 'r' tells python what wee want to do with the file, in this 
# case the parameter is 'r' which means read.

with open(import_file, "r") as file:

    # Use '.read()' to read the imported file and store the result in a variable
    # named 'text'.

    text = file.read()

# Display the contents of 'text'
print(text)




# Task 2:
# The output in the previous step is one big string. 
# Use the '.split()' method to split the string into a list of strings, one string
# per line.

print(text.split())




# Task 3:
# Append a missing entry in the log file. 

missing_entry = "jrafael,192.168.243.140,4:56:27,2022-05-09"

with open(import_file, "a") as file:
    file.write(missing_entry)

with open(import_file, "r") as file:
    text = file.read()

print(text)




# Task 4:
# Create a text file. 

# Assign 'import_file' to the name of the text file that you want to create.
import_file = "data-allow_list.txt"

# Assign 'ip_addresses' to a list of IP addresses that are allowed to access the
# restricted information.
ip_addresses = "192.168.218.160 192.168.97.225 192.168.145.158 192.168.108.13 192.168.60.153 192.168.96.200 192.168.247.153 192.168.3.252 192.168.116.187 192.168.15.110 192.168.39.246"

# Display 'import_file'
print(import_file)

# Display 'ip_addresses'
print(ip_addresses)

# Create a 'with' statement to write to the text file.
with open(import_file, "w") as file:
    # Write 'ip_addresses' to the text file.
    file.write(ip_addresses)

# Create a 'with' statement to read in the text file
with open(import_file, "r") as file:
    # Read the file and store the result in a variable named 'text'
    text = file.read()

# Display the contents of 'text'
print(text)



End of exercise.
