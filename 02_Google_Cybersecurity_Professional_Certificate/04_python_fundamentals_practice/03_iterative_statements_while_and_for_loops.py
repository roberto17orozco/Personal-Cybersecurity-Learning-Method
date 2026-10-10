# This script uses iterative statements ('for' and 'while' loops) to automate
# repetitive processes.

# Task 1:
# Write an iterative statement that displays 'Connection could not be
# established' three times. Use the 'for'keyword, the 'range()' function and a 
# loop variable of 'i'.

for i in range(3):
    print("Connection could not be established.")



# Task 2:
# Create a variable called 'connection_attempts' that stores the number of times
# the user has tried to connect to the network.

connection_attempts = 3

for i in range(connection_attempts):
    print("Connection could not be established")



# Task 3:
# Achieve the same task but this time using a 'while' loop. A 'while' loop
# terminates once it reaches a certain condition. 
# In situations where you do not know how many times the specified action should
# be repeated, 'while' loops are most appropiate.

connection_attempts = 0
# Display "Connection could not be established." every iteration, until 
# connection_attempts reaches a specified number.

while connection_attempts < 3:
    print("Connection could not be established")

    # The specified condition is the number 3.
    # Update 'connection_attempts' (increment it by 1 at the end of each iteration)
    connection_attempts = connection_attempts + 1



# Task 4:
# Use a 'for' loop and a 'conditional statement' to check whether some
# IP addresses are allowed to log in.

allow_list = ["192.168.243.140", "192.168.205.12", "192.168.151.162", "192.168.178.71", 
              "192.168.86.232", "192.168.3.24", "192.168.170.243", "192.168.119.173"]

# Assign 'ip_addresses' to a list of IP addresses from which users have tried to log in.

ip_addresses = ["192.168.142.245", "192.168.109.50", "192.168.86.232", "192.168.131.147",
                "192.168.205.12", "192.168.200.48"]

for i in ip_addresses:
    if i in allow_list:
        print("IP address is allowed")
    else:
        print("IP address is not allowed")



# Task 5: 
# Using the keyword 'break' terminate the iterative statement when it founds an 
# IP that is not in the 'allow_list'.

allow_list = ["192.168.243.140", "192.168.205.12", "192.168.151.162", "192.168.178.71", 
              "192.168.86.232", "192.168.3.24", "192.168.170.243", "192.168.119.173"]

# Assign 'ip_addresses' to a list of IP addresses from which users have tried to log in.

ip_addresses = ["192.168.142.245", "192.168.109.50", "192.168.86.232", "192.168.131.147",
                "192.168.205.12", "192.168.200.48"]

# If the IP address is among the allowed addresses, display "IP address is allowed"
# Otherwise, display "IP address is not allowed. Further investigation of login
# activity required."

for i in ip_addresses:
    if i in allow_list:
        print("IP address is allowed")
    else:
        print("IP address is not allowed. Further investigation of login activity required")
        break



# Task 6:
# Automate the creation of new employee IDs using the 'while' loop with its condition
# and a variable that starts at 5000 and increments by 5 on each iteration.

i = 5000
while i <= 5150:
    print(i)
    i = i + 5



# End of exercise.


