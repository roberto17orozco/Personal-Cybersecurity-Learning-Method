# This script explores conditional statements in Python and its usage.

# Task 1:
# Assign a variable named 'system' to a specific operating system, represented 
# as a string. This variable indicates which operating system is running.
system = "OS 2"

# If OS 2 is running, then display a "no update needed" message.
if system == "OS 2":
    print("no update needed")



# Task 2:
# Otherwise, display a "update needed" message.
system = "OS 3"

if system == "OS 2":
    print("no update needed")
else:
    print("update needed")



# Task 3: 
# Use of the keyword 'elif' that works in case the variable 'system' contains a
# random string or integer.
system = "OS 2"

# If OS 2 is running, then display a "no update needed" message.
# Otherwise if OS 1 is running, display a "update needed" message.
# Otherwise if OS 3 is running, display a "update needed" message.
if system == "OS 2":
    print("no update needed")
elif system == "OS 1":
    print("update needed")
elif system == "OS 3":
    print("update needed")



# Task 5:
# Combine the two 'elif' statements using the keyword 'or'

system = "OS 1"

# If OS 3 is running, then display a "no update needed" message.
# Otherwise if either OS 1 or OS 2 is running, display a "update needed" message.
if system == "OS 3":
    print("no update needed")
elif system == "OS 1" or system == "OS 2":
    print("update needed")



# Task 6:
# Investigate login attempts to a specific device. Only approved users should 
# log on to this device.

# Assign 'approved_list' to a list of approved usernames.
approved_list = ["elarson", "bmoreno", "tshah", "sgilmore", "eraab"]
# Assign 'username' to the username of a specific user trying to log in.
username = "jhill"

# If the user trying to log in is among the approved users, then display a
# message that they are approved to access this device.

# Otherwise, display a message that they do not have access to this device.

if username in approved_list:
    print("This user has access to this device.")
else:
    print("This user does not have access to this device.")



# Task 7:
# Assign 'organization_hours' to a Boolean value that represents whether the
# user is trying to log in during organization hours.

organization_hours = True

# If the entered 'organization_hours' has a value of True, then display "login 
# attempt made during organization hours."
# Otherwise, display "Login attempt made outside of organization hours."

if organization_hours == True:
    print("Login attempt made during organization hours.")
else:
    print("Login attempt made outside of organization hours.")



# Task 8:
# Combine both conditions 'approved usernames' and 'organizational hours' to know
# more about login attempts. Use the 'and' operator.

# If the user is among the approved users and they are logging in during organization
# hours, then convey that the user is logged in.

# Otherwise, convey that either the username is not approved or the login attempt
# was made outside of organization hours.
username = "bmoreno"
if username in approved_list and organization_hours == True:
    print("Login attempt made by an approved user during organization hours.")
else:
    print("Username not approved or login attempt made outside of organization hours.")


# End of exercise.