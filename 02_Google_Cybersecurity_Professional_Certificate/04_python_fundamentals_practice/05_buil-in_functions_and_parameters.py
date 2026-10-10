# This script uses built-in functions 'sorted' and 'max' it also uses 'return',
# which is used to stop a function and send a value back to the code that called it.



# Task 1:
# Use the built-in function 'sorted' to order a list that contains of the numbers
# of failed login attempts per month.

# Assign 'failed_login_list' to the list of the number of failed login attempts 
# per month.
failed_login_list = [119, 101, 99, 91, 92, 105, 108, 85, 88, 90, 264, 223]
# Integers are not quoted.

# Sort 'failed_login_list' in ascending numerical order and display the result.
print(sorted(failed_login_list))



# Task 2:
# Use the built-in function 'max' to display the highest number of failed login
# attempts.
failed_login_list = [119, 101, 99, 91, 92, 105, 108, 85, 88, 90, 264, 223]
print(max(failed_login_list))



# Task 3:
# Define a function that takes two parameters so everytime this function is
# called it displays a message about the number of login attempts the user has
# made.

def analyze_logins(username, current_day_logins):
    # Display a message about how many login attempts the user has made
    print("Current day login total for", username, "is", current_day_logins)

analyze_logins("roberto", 19)

# Parameters are 'username' and 'current_day_logins'.
# User has to input the values for those parameters when calling the function,
# in this case "roberto" takes the place for the first parameter 'username', and
# '19' takes the place of the second parameter 'current_day_logins'.



# Task 4:
# Add a third parameter that provides the average number of login attempts made 
# by the user on that day.
# Also, include a calculation to get the ratio of the logins made on the current
# day to the logins made on an average day. 


# Define a function named 'analyze_logins()' that takes in three parameters,  
# 'username', 'current_day_logins', and 'average_day_logins'
def analyze_logins(username, current_day_logins, average_day_logins):
    print("Current day login total for", username, "is", current_day_logins)

    print("Average logins per day for", username, "is", average_day_logins)

    # Calculate the ratio of the logins made on the current day to the logins made
    # on an average day, storing in a variable named 'login_ratio'.
    login_ratio = current_day_logins / average_day_logins

    # Display a message about the ratio
    print(username, "logged in", login_ratio, "times as much as they do on an averae day")

# Call 'analyze_logins()'
analyze_logins("roberto", 17, 2)



# Task 5:
# Use the 'return' keyword to output the 'login_ratio' from the function, so that
# it can be used later.

def analyze_logins(username, current_day_logins, average_day_logins):
    print("Current day login total for", username, "is", current_day_logins)

    print("Average logins per day for", username, "is", average_day_logins)

    # Calculate the ratio of the logins made on the current day to the logins made
    # on an average day, storing in a variable named 'login_ratio'.
    login_ratio = current_day_logins / average_day_logins

    # Return the ratio
    return login_ratio

# Call 'analyze_logins()' and store the output in a variable named 'login_analysis'
login_analysis = analyze_logins("roberto", 10, 2)

# Display a message about the 'login_analysis'
print("roberto", "logged in", login_analysis, "times as much as they do on an average day.")



# Task 6:
# Add a conditional statement that displays an alert about the login activity if
# it's more than normal.

if login_analysis >= 3:
    print("Alert! This account has more login activity than normal.")




    # End of exercise.