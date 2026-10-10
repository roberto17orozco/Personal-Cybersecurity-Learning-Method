# This script explores different ways to work with strings like converting an
# an integer data type value into a string data type value, calculate the length
# of a string, concatenate strings, extract characters in specific positions, and more.



# Task 1:
# Convert an integer into a string

employee_id = 4186
# Display the data type of 'employee_id'
print(type(employee_id))

# Reassign 'employee_id' to the same value but in the form of a string
employee_id = str(employee_id)
# str() convertes the value into a string data type.

# Display the data type of employee 'employee_id' now
print(type(employee_id))



# Task 2:
# Write a conditional statement that displays a message if the length of the
# employee ID is less than five digits.

if len(employee_id) < 5:
    print("This employee ID has less than five digits. It does not meet length requirements.")


# Task 3:
# Use concatenation to create a five-digit employee ID number.

employee_id = 4186
# Display the data type of 'employee_id'

# Reassign 'employee_id' to the same value but in the form of a string
employee_id = str(employee_id)
# str() convertes the value into a string data type.

# Display the 'employee_id' as it currently stands

print(employee_id)

# Conditional statement that updates the 'employee_id' if its length is less than
# 5 digits.

if len(employee_id) < 5:
    employee_id = "E" + employee_id

# Display the 'empoyee_id' after the update.

print(employee_id)



# Task 4:
# Extract specific characters in specific positions from a device ID.

device_id = "r262c36"

# Extract the fourth character in 'device_id' and display it.
print(device_id[3])

# The index value has to be passed within the square brackets.
# Positions count start at 0 for the first character.



# Task 5:
# Extract the first through the third characters in the device ID.

device_id = "r262c36"

print(device_id[0:3])
# The second index value (in this case '3') is exclusive.



# Task 6:
# Use string slicing to extract a section of a string.

url = "https://exampleURL222.com"

# Extract the protocol of 'url' along with the syntax following it.

print(url[0:8])
# Pass the variable containing the url value and add the indexes.



# Task 7:
# Identify the index where the domain extension '.com' is located in the given URL.
# Use the '.index()' method

url = "https://exampleURL222.com"

# Display the index where the domain extension '.com' is located in 'url'.
print(url.index(".com"))

# Be sure to place '.index' just after the variable. Then within the parenthesis
# write the string for the index you want to locate.
# As always, strings are quoted.
# The value indicates the index of the first character of the string.



# Task 8:
# Store the output of the '.index()' method in a variable called 'ind', which is
# short for index. This index represents the position where the domain extension
# '.com' starts in the 'url'.

ind = url.index(".com")
print(ind)



# Task 9:
# Extract the domain extension using the variable 'ind' as starting index and 
# 'ind+4' as ending index.

print (url[ind:ind+4])
# Rexcall the starting index value stored in 'ind' is 21. Add 4 more characters
# and you get '.com'.



# Task 10:
# Extract the website name using string slicing and the 'ind' variable.

print(url[8:ind])




# End of exercise.