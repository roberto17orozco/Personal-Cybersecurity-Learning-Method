# This script assigns values to variables and determines their data types.

# Task 1: 
# Assign the 'device_id' variable to the device ID that only specified 
# users can access
device_id = "72e08x0"
# Display 'device_id'
print(device_id)



# Task 2: 
# Assign 'device_id_type' to the data type of 'device_id'
device_id_type = type(device_id)
# Display 'device_id_type'
print(device_id_type)



# Task 3: 
# Assign 'username_list' to the list of usernames who are allowed to 
# access the device.
username_list = ["madebowa", "jnguyen", "tbecker", "nhersh", "rewards"]
# Display 'username_list'
print(username_list)



# Task 4: 
# Find the data type of the 'username_list'
username_list_type = type(username_list)
# Display 'username_list_type'
print(username_list_type)



# Task 5: 
# Assign 'max_logins' to the value 3, store its data type in another 
# variable and display the data type.
max_logins = 3
# Assign 'max_logins_type' to the data type of 'max_logins'
max_logins_type = type(max_logins)
# Display 'max_logins_type'
print(max_logins_type)



# Task 6: 
# Determine the Boolean value that represents whether the current number
# of login attempts a user has made is less than or equal to the maximum number
# of login attempts allowed.
max_logins = 3
# Assign 'login_attempts' to the value 2
login_attempts = 2
# Determine wheter the current number of login attempts a user has made is less 
# than or equal to the maximum number of login attemps allowed, and display the
# resulting Boolean value.
print(login_attempts <= max_logins)



# Task 7:
# Use a different value for 'login_attempts'
max_logins = 3
login_attempts = 19
print (login_attempts <= max_logins)



# Task 8:
# Assign a Boolean value of 'True' or 'False' to a variable.
login_status = False
# Assign 'login_status_type' to the data type of 'login_status'.
login_status_type = type(login_status)
# Display 'login_status_type'
print(login_status_type)

# End of exercise.



