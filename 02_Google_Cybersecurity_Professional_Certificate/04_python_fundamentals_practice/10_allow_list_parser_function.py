# This script uses the same code as the previous file, but it inserts the code 
# into a function that has two parameters, allowing the user to specify which 
# IP addresses to remove.


# Assign 'import_file' to the name of the file.
import_file = "allow_list.txt"

# Assign 'remove_list' to a list of IP addresses that are no longer allowed to access
# restricted information.
remove_list = ["192.168.97.225", "192.168.158.170", "192.168.201.40", "192.168.58.57"]

# Display 'import_file'
print(import_file)

# Display 'remove_list'
print(remove_list)



# Define a function that allows the user to remove specific IP addresses.
def update_file(import_file, remove_list):
    # Convert the data type from a string into a list.
    with open(import_file, "r") as file:
        ip_addresses = file.read()
    ip_addresses = ip_addresses.split()

    # Build the 'for loop'
    for element in ip_addresses:
        if element in remove_list:
            ip_addresses.remove(element)
            # The '.remove()' method removes the 'element'.
    ip_addresses = " ".join(ip_addresses)
            # the '.join()' method converts the data type from a list into a string.
    with open(import_file, "w") as file:
        file.write(ip_addresses)

# Call 'update_file()' and pass in "allow_list.txt" and a list of IP addresses to 
# be removed.
update_file("allow_list.txt", ["192.168.25.60", "192.168.140.81", "192.168.203.198"])

# Build a 'with' statement to read in the updated file
with open("allow_list.txt", "r") as file:
    text = file.read()

print(text)




