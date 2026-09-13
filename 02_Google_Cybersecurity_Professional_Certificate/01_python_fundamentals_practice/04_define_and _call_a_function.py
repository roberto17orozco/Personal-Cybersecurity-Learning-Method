# This script uses 'functions', which are a way to reuse the same block of code
# more than once. You can call a function whenever the computer needs to execute
# the function steps.

# Task 1:
# Define a function named 'alert()' and then call it.
def alert():
    print("Potential security issue. Investigate further.")

alert()



# Task 2:
# Include a 'for' loop within a function.

def alert():
    for i in range(5):
        print("Potential security issue. Investigate further.")

alert()



# Task 3:
# Convert a list into a string using a 'for' loop within a function.
def list_to_string():
    # Store the list of approved usernames in a variable named 'username_list'
    username_list = ["elarson", "bmoreno", "tshah", "sgilmore", "eraab", "gesparza",
                     "alevitsk", "wjaffrey"]

    # Write a for loop that iterates through the elements of 'username_list' and
    # displays each element.
    for i in username_list:
        print(i)

# Call the 'list_to_string()' function

list_to_string()



# Task 4:
# Combine multiple strings together to form one large string using the addition
# '(+)' operator. This is called 'string concatenation'
# String concatenation merges individual pieces of data into a single string value.

def list_to_string():
    # Store the list of approved usernames in a variable named 'username_list'
    username_list = ["elarson", "bmoreno", "tshah", "sgilmore", "eraab", "gesparza" 
                     "alevitsk", "wjaffrey"]

    # Assign 'sum_variable' to an empty string
    sum_variable = ""

    # Write a for loop that iterates through the elements of 'username_list' and 
    # displays each element.
    for i in username_list:
        sum_variable = sum_variable + i
        # 'i' on this statement is each element in 'username_list' that is not 
        # a quotation mark, a comma, or a blank space.

    # Display the value of 'sum_variable'
    print(sum_variable)

# Call the 'list_to_string()' function.

list_to_string()



# Task 5:
# Add a comma and a space to the output of the previous task.

def list_to_string():
    # Store the list of approved usernames in a variable named 'username_list'
    username_list = ["elarson", "bmoreno", "tshah", "sgilmore", "eraab", "gesparza" 
                     "alevitsk", "wjaffrey"]

    # Assign 'sum_variable' to an empty string
    sum_variable = ""

    # Write a for loop that iterates through the elements of 'username_list' and 
    # displays each element.
    for i in username_list:
        sum_variable = sum_variable + i + ", "
        # 'i' on this statement is each element in 'username_list' that is not 
        # a quotation mark, a comma, or a blank space.

        # The comma and the space should be quoted.

    # Display the value of 'sum_variable'
    print(sum_variable)

# Call the 'list_to_string()' function.

list_to_string()





