"""
This script parses a file to read and and update the contents by removing IP
addresses that no longer have access to the restricted content.

The script uses: 
1. A text file called "allow_list.txt" that contains a series of 
IP addresses that are allowed to access restricted information.
2. 'with' statements.
3. 'open' functions.
4. 'r' and 'w' modes.
5. 'read()' and 'write()' functions.
6. A 'for loop'
7. A conditional statement.
8. Parsing functions like '.split()' and '.join().
"""





# Task 1:
# Assign 'import_fle' to the name of the file, and open and read the file.
# Create a variable named 'ip_addresses' to store the contents of the text file
# and display its content.
import_file = "allow_list.txt"

# Assign 'remove_list' to a list of IP addresses that are no longer allowed to access
# restricted information.
remove_list = ["192.168.97.225", "192.168.158.170", "192.168.201.40", "192.168.58.57"]

# Display 'import_file'
print(import_file)

# Display 'remove_list'
print(remove_list)


with open(import_file, "r") as file:
    ip_addresses = file.read()
print(ip_addresses)




# Task 2:
# Reassign the 'ip_addresses' variable so its data type is updated from a string
# to a list.
ip_addresses = ip_addresses.split()
print (ip_addresses)




# Task 3:
# Remove the elements of 'remove_list' from 'ip_addresses'
for element in ip_addresses:
    if element in remove_list:
        ip_addresses.remove(element)
        # The '.remove()' method will remove the elements.


# Display 'ip_addresses'
print(ip_addresses)




# Task 4:
# Update the original file that was used to create the 'ip_addresses list. Use the
# '.join()' method. This is necessary because 'ip_addresses' must be in string format
# when used inside the 'with' statement to rewrite the file.

# Convert 'ip_addresses' back to a string so that it can be written into the text file.
ip_addresses = " ".join(ip_addresses)

# Rewrite the file, replace its contents with 'ip_addresses'.
with open(import_file, "w") as file:
    file.write(ip_addresses)




# Task 5:
# Read the updated file.
with open(import_file, "r") as file:
    text = file.read()
print(text)




# Task 6:
# Bring all the code you've written leading up to this point and put it all into
# one function.
# The function should take two parameters, the first parameter is the name of the
# text file that contains IP addresses ('import_file'). The second parameter is a
# list that contains IP addresses to be removed ('remove_list')

# Call the function. Apply the function to "allow_list.txt" and pass in a list of
# IP addresses as the second argument.

# Use the following list of IP addresses as the second argument:
# ["192.168.25.60", "192.168.140.81", "192.168.203.198"]

# After the function call, use a 'with' statement to read the contents of the
# alow list. Then display the contents of the allow list. 
# Run it to verify that the file has been updated by the function.

def update_file(import_file, remove_list):
    with open(import_file, "r") as file:
        ip_addresses = file.read()
    ip_addresses = ip_addresses.split()

    for element in ip_addresses:
        if element in remove_list:
            ip_addresses.remove(element)

    ip_addresses = " ".join(ip_addresses)

    with open(import_file, "w") as file:
        file.write(ip_addresses)

# Call 'update_file()' and pass in "allow_list.txt" and a list of IP addresses to 
# be removed.
update_file("allow_list.txt", ["192.168.25.60", "192.168.140.81", "192.168.203.198"])

# Build a 'with' statement to read in the updated file
with open("allow_list.txt", "r") as file:
    text = file.read()

print(text)
