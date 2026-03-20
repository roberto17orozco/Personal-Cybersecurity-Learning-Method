## XVI.- MORE ON BASH AND SHELL SCRIPTING

**Contents:**
1. Manipulating strings.
2. Evaluating Boolean expressions.
3. Debbuging scripts.

### 1.- String manipulation
1. A string variable contains a sequence of text characters. It can include letters, numbers, symbols and punctuation marks.
2. For example: `abcde`, `123`, `abcde 123`, `abcde-123`, `&abcde=%123`


| String Operator | Meaning |
|-----------------|----------|
| `[[ string1 > string2 ]]` | Compares the **lexicographical (sorting)** order of `string1` and `string2`. |
| `[[ string1 == string2 ]]` | Compares whether the **characters** in both strings are identical. |
| `myLen1=${#string1}` | Stores the **length** of `string1` in the variable `myLen1`. |


### 2.- Example of string manipulation
1. Compare two strings and display an appropiate message using the **if statement**. Create a script with the content below:

![stringcomp](Linux_LFS101X_screenshots/16.1_stringcomp.jpg)
***You can see the actual script [here](https://github.com/roberto17orozco/Personal-Cybersecurity-Learning-Method/blob/Main/01_Linux_LFS101x/scripts/16_string_comp.sh).***

#### ./16_string_comp.sh output:
![stringcomp2](Linux_LFS101X_screenshots/16.2_stringcomp2.jpg)
* Notice:
    1. You can use the **if statement** in 3 different ways:
        1. Double brackets, no quotes.
        2. Single brackets, quotes, and
        3. Single brackets, no quotes.

---

2. Pass a file name and see if that file exists or not. Create a script with the content below:

![checkfile](Linux_LFS101X_screenshots/16.3_checkfile.jpg)
***You can see the actual script [here](https://github.com/roberto17orozco/Personal-Cybersecurity-Learning-Method/blob/Main/01_Linux_LFS101x/scripts/17_chek_for_-f_file.sh).***

#### ./check_for_-f_file.sh output:
![checkfile2](Linux_LFS101X_screenshots/16.4_checkfile2.jpg).
* Notice:
    1. `-f` operator looks for regular files.
    2. **filename** is saved as a variable and then is used in the if statement, and then in the `echo` utility.

### 3.- Parts of a string
1. At times, you may not need to compare or use an entire string.
2. To extract the firts **"n"** characters of a string, we can specify:

    `${string:0:}`
    * Here **0** is the offset in the string (i.e. which character to begin from). Is where the straction needs to start.
    * `n` is the number of characters to be extracted.

3. To extract all characters in a string after a dot (.), use the following expression:

    `${string#*.}`

---
### Lab 16.1: String tests and operations
Write a script which reads two strings as arguments and then:
1. Test to see if the first string is of 0 lenght, and if the other is of non-zero lenght, telling the user of both results.
2. Determines the length of each string, and reports on which one is longer or if they are of equal lenght.
3. Compares the strings to see if they are the same, and reports on the result.

**Solution**
1. Create a file named **teststrings.sh**, with the content below:

![teststrings](Linux_LFS101X_screenshots/16.5_teststring.jpg)
***You can see the actual script [here](https://github.com/roberto17orozco/Personal-Cybersecurity-Learning-Method/blob/Main/01_Linux_LFS101x/scripts/18_test_strings.sh).***

#### ./test_strings.sh output:
![teststrings2](Linux_LFS101X_screenshots/16.6_teststring2.jpg)
* Check two string arguments were given:
    1. `[[ $# -lt 2 ]]` its an early conditional test that means "if less than 2 arguments given..
    2. `echo` "Usage: Give two strings as arguments" and
    3. `exit 1`.
        * Notice the **if statement** is not in use, the `[[..]]` and `&&` are used instead.
    4. `str1` is the name for first arguement `$1`; the same way `str2` is the name for the second argument `$2`
    
* Test command    
    1. `[ -z "$str1" ]` is a conditional test that means "is the string lenght zero?".
        * If it is true return code will be 0.
        * If it is false, return code will be 1.
        * `$?` contains the return code for the last command.

* Comparing the lenghts of two strings.
    1. In `len1=${#str1}`, `${#str1}` is the lenght for variable **len1**.
    2. In `len2=${#str2}`, `${#str2}` is the lenght for variable **len2**.
    3. An **if statement** is used to compare the lenghts of variables len1 and len2 with the numerical test `-gt`.

* Compare the two strings to see if they are the same.
    1. Using the **if statement** and the `==` operator you can compare if the strings are the same.

#### Lenght and values evaluated in two strings

![lenghtval](Linux_LFS101X_screenshots/16.7_teststring3.jpg)

* Notice:
    1. Arguments **White** and **White** are evaluated as identical strings.
    2. On the other hand strings **one** and **two** are evaluated as different strinst, although they have the same lenght.

### 4.- The case statement
1. The `case` statement is used in scenarios where the actual value of a variable can lead to different execution paths.
2. `case` statements are often used to handle **command-line** options.
3. Features of case statement:
    1. Easier to read and write.
    2. Good alternative to nested, multi-level if-then-else-fi statements.
    3. Enables you to compare a variable against several values at once.
    4. Easy to use.
    5. Reduces complexity of a program