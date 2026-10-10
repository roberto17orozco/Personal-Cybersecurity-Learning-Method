# This script explores regular expressions, its symbols, python modules and its
# functions like 'findall()'.



# Task 1:
# Run 'import re' to be able to work with regular expressions.

import re




# Task 2:
# Extract the device IDs that start with the characters "r15".

devices = "r262c36 67bv8fy 41j1u2e r151dm4 1270t3o 42dr56i r15xk9h 2j33krk 253be78 ac742a1 r15u9q5 zh86b2l ii286fq 9x482kt 6oa6m6u x3463ac i4l56nq g07h55q 081qc9t r159r1u"

# Assign 'target_pattern' to a regular expression pattern for finding device IDs that start with 'r15'
target_pattern = r"r15\w+"
# \w: is a character type-regular expression symbol that matches  any alphanumeric 
# character (A-Z, 0-9) or an underscore (_).
# +: is a quantify occurrences symbol that quantifies one or more occurrences.




# Task 3:
# Use the 'findall()' function from the 're' module to find the device ID that the
# 'target_pattern' matches with.

print(re.findall(target_pattern, devices))




# Task 4:
# Analize a network security log file and determine which IP addresses have been
# flagged for unusual activity.

# Assign 'log_file' to a string containing username, date, login time, and IP address
# for a series of login attempts.

log_file = "eraab 2022-05-10 6:03:41 192.168.152.148 \niuduike 2022-05-09 6:46:40 192.168.22.115 \nsmartell 2022-05-09 19:30:32 192.168.190.178 \narutley 2022-05-12 17:00:59 1923.1689.3.24 \nrjensen 2022-05-11 0:59:26 192.168.213.128 \naestrada 2022-05-09 19:28:12 1924.1680.27.57 \nasundara 2022-05-11 18:38:07 192.168.96.200 \ndkot 2022-05-12 10:52:00 1921.168.1283.75 \nabernard 2022-05-12 23:38:46 19245.168.2345.49 \ncjackson 2022-05-12 19:36:42 192.168.247.153 \njclark 2022-05-10 10:48:02 192.168.174.117 \nalevitsk 2022-05-08 12:09:10 192.16874.1390.176 \njrafael 2022-05-10 22:40:01 192.168.148.115 \nyappiah 2022-05-12 10:37:22 192.168.103.10654 \ndaquino 2022-05-08 7:02:35 192.168.168.144"

# Display contents of 'logfile'
print(log_file)

# Assign 'pattern' to a regular expression pattern that will match with IP addresses
# of the form xxx.xxx.xxx.xxx.


pattern = r"\d{3}\.\d{3}\.\d{3}\.\d{3}"

# Use the 're.findall()' function on 'pattern' and 'log_file' to extract the IP
# addresses of the form xxx.xxx.xxx.xxx and display the results.

print(re.findall(pattern, log_file))

# The first parameter 'pattern' is the object you are looking for, and the second
# parameter 'log_file' is the place where the function is going to search.



# Task 5:
# There are some valid IP addresses in the 'log_file' that you haven't extracted yet.
# This is because each segment of digits in a valid IP address can have anywhere
# between one and three digits.

# Update 'pattern' to a regular expression pattern that will match with IP addresses
# with any variation in the number of digits per segment.



pattern =r"\d+\.\d+\.\d+\.\d+"

# Use the 're.findall()' function on 'pattern'  and 'log_file' to extract the IP
# addresses of the update form specified above and display the results.

print(re.findall(pattern, log_file))




# Task 6:
# All IP addresses are now extracted but they also include invalid IP addresses
# with more than three digits per segment.

# Assign 'pattern' to a regular expression that matches with all valid IP addresses
# and only those (1 - 3 digits per segment)


pattern = r"\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

# Use 're.findall()' on 'pattern' and 'log_file' and assign 'valid_ip_addresses'
# to the output.

valid_ip_addresses = re.findall(pattern, log_file)

# Display the contents of 'valid_ip_addresses'.

print(valid_ip_addresses)




# Task 7:
# Given a list of IP addresses that have been previously flagged for unusual activity,
# write an iterative statement that lops through the 'valid_ip_addresses' list
# and checks if each IP address is flagged.

flagged_addresses = ["192.168.190.178", "192.168.96.200", "192.168.174.117", "192.168.168.144"]

for address in valid_ip_addresses:
    if address in flagged_addresses:
        print("The IP address", address, "has been flagged for further analysis.")

    # Otherwise, display "The IP address _____ does not require further analysis."

    else:
        print("The IP address", address, "does not require further analysis.")



End of exercise.
