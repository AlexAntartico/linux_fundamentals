# Variables in Bash

## Declaring variables

Simply type:

```bash
NAME="value" # No spaces between variable name, equal sign and value
```
- Rules:
  - No spaces around the equal sign.
  - Varible names can contain letters, numbers and underscores
  - Cannot start with a number
  - Are case-sensitive: `NAME` and `name` are different variables

- Naming Conventions:
  - Use `UPPERCASE` for
    * Environment variables: `PATH`, `HOME`, `USER`, `SHELL`
    * Global configuration variables: `CONFIG_FILE`, `LOG_LEVEL`, `APP_NAME`
    * Constants: `readonly MAX_RETRIES=3`, `PI=3.14159`
    * Variables exported to child processes: `export DATABASE_URL="..."`
  - Use `lowercase` for local/temporary variables: temp_file, counter
    * Local variables in functions: `temp_file`, `counter`, `result`
    * Loop variables: `for file in *.txt`
    * Temporary/working variables: `user_input`, `current_date`
    * Script-internal variables: `backup_dir`, `file_count`
  - Use descriptive names: `user_count` instead of `uc`
  - Separate words with underscores: `file_name` not `filename`

### Using variables

We have several types of variables besides strings. Bash however, does not support floating-point numbers.

- Strings
- Integers
- Arrays
- Associative arrays
- Environment variables
- Positional parameters

To use a variable, simply type its name.
Prefix variable name with "$" - example: `echo "$NAME"` will output `value`.

Or use curly braces for more complex expressions - example: `echo "${NAME}" thing` will output `valuething`.

Notice than when you call a variable, you generally use double quotes as single quotes will ignore escape characters.

To return the type of a variable, use the `declare` command:

```bash
declare -p NAME
```

example:

```bash
MYVAR="Hello World"
MYARRAY=("A" "B" "C")
MYINT=42

declare -p MYVAR
declare -p MYARRAY
declare -p MYINT
```

will output:

```bash
declare -- MYVAR="Hello World"
declare -a MYARRAY=([0]="A" [1]="B" [2]="C")
declare -i MYINT=42
```
# Double Quotes and Parameter Expansion

**Double Quotes** `"` Are generally preferred because they allow for variable substitution (the shell replaces $VARIABLE with its value) and command substitution ($(command) is replaced by its output) within the string. Double quotes also preserve whitespace and special characters.

**Double Quotes with curly braces `{}`** unlock a set of features calles **parameter expansion**. This should be the default in scripting a paramount feature of automation and resilient scripting often used in DevOps. Parameter expansion allows you to manipulate the value of a variable in various ways. We will cover three of the most useful ones:

1. **Providing a default value**: If the variable is unset or null, you can provide a default value using `${VAR:-default}`. For example:

   ```bash
   echo "${MYVAR:-default_value}"
   ```

   If `MYVAR` is unset or empty, it will output `default_value`.

1. **Echoing variable values**: `echo "$VARIABLE"` - ensures the exact value is printed, preserving spaces and special characters.
2. **Assigning values with spaces**: `VARIABLE="hello world"` - treats the entire phrase as a single value.
3. **Passing variables as arguments**: `my_script "$VARIABLE"` - ensures the argument is passed as a single unit.
4. **Using variables in strings**: `echo "My value is $VARIABLE"` - `$` allows the variable's value to be inserted directly into the string.
5. **Command substitution**: `VARIABLE="$(my_command)"` - quotes capture command output with formatting.

Quotes + `$` ensure values are used correctly in scripts.

**Double quotes** allow for other substitutions to happen in the string, ie:

```sh
FIRSTVAR="a hopefully, very long and productive journey."
SECONDVAR="This is just the beginning of $FIRST"
echo $SECONDVAR
```
will output:
`This is just the beginning of a hopefully, very long and productive journey.`

With single quotes, no substitution is possible.

### Store the output of a shell command

You can store the output of a shell command with `$( )`. You can also pipe several commands inside $( ).

```sh
CURRENTDIR=$(pwd)
```

Instead of sending the result of pwd to stdout, this will store pwd in $CURRENTDIR

### `${MYVAR}` vs `$MYVAR`

**In Scripts**, you should use `${MYVAR}`.

**In command line and interactive use**, you can use `$MYVAR` or `${MYVAR}` interchangeably.

**Why???** would you ask yourself?

The shell, needs to know where the variable name ends. Shell will assume your varialbe name ends at the first character that is not valid for, you guessed; a variable name. Aka not an alphanumeric character or underscore.

Imagine that  you need to append `_test.log` to the contents of a variable:

```bash
FILENAME="app_execution"

# --- The wrong way ---
echo "Creating log file: $FILENAME_test.log"

# --- The right way ---
echo "Creating log file: ${FILENAME}_test.log"
```

Spot the diffence? Curly braces will actually tell the shell where the variable name starts and ends, it will not try to append `_test.log` to the variable name. The output would look like this:

```bash
Creating log file: .log
Creating log file: app_execution_test.log
```

For standard variable expansion, ${MYVAR} is always preferred. You might not need it, but it will never hurt to use it.

### Parameter expansion { }

Besides protecting variables, curly braces `{ }` will 


### Variable types

By default all variables are strings. To use **integers**, use the `declare` command:

```bash
declare -i INT=5
```

`echo "$INT"` will output `5`.

For **arrays**, use:

```bash
declare -a ARRAY=(1 2 3)
```
`echo "$ARRAY"` will output `1`.
`echo "${ARRAY[1]}"` will output `2`.

- Arrays are declared with `declare -a` and accessed with `"${ARRAY[index]}"`. You can access all indexes with `"${ARRAY[@]}"`.
- Arrays are defined as a list of values separated by spaces.
- Arrays are zero-indexed.
- You can add values to an array with `ARRAY+=(4 5 6)`.
- You can remove values from an array with `unset ARRAY[index]`.
- You can remove the whole array with `unset ARRAY`.
- You can get the length of an array with `"${#ARRAY[@]}"`.
- You can get the length of a specific element with `${#ARRAY[index]}`.

For **associative arrays**, use:

```bash
declare -A ASSOC
ASSOC["key 1"]="value 1"
ASSOC["key 2"]="value 2"
```

`echo ${ASSOC["key 1"]}` will output `value 1`.
`echo ${!ASSOC[@]}` will output all keys.

- **Associative Arrays** are arrays that use strings as indexes instead of numbers.
- They are declared with `declare -A` and accessed with `${ARRAY["index"]}`.
- Similarly to regular arrays, you can access all indexes with `${!ARRAY[@]}`.
- You can add values to an associative array with `ARRAY["key"]="value"`.
- You can remove values from an associative array with `unset ARRAY["key"]`.
- You can remove the whole associative array with `unset ARRAY`.
- You can get the length of an associative array with `${#ARRAY[@]}`.
- You can get the length of a specific element with `${#ARRAY["key"]}`.
- You can get all keys with `${!ARRAY[@]}`.

### Environment variables

Environment variables are variables that are available to any child process of the shell. To create an environment variable, use the `export` command:

```bash
export NAME="value"
```

Every time a new shell is opened, the environment variables are loaded. Every export variable is prepended to your `$PATH` variable.

To view all environment variables, use the `env` command. To view a specific variable, use `echo $NAME`.

- `$IFS` is the internal field separator.
- `$OLDPWD` is the previous working directory.
- `$PWD` is the current working directory.
- `$RANDOM` is a random number between 0 and 32767.
- `$SECONDS` is the number of seconds the script has been running.
- `$UID` is the user ID of the current user.
- `$USER` is the username of the current user.
- `$HOSTNAME` is the hostname of the machine.
- `$HOSTTYPE` is the type of machine.
- `$OSTYPE` is the type of operating system.
- `$MACHTYPE` is the type of machine.
- `$SHELL` is the shell you are using.
- `$HOME` is the home directory of the current user.
- `$PATH` is the list of directories the shell searches for commands.
- `$EDITOR` is the default editor.
- `$TERM` is the terminal type.
- `$HISTSIZE` is the number of commands to remember in the history.
- `$LOGNAME` is the login name of the current user.
- `$MAIL` is the location of the user's mailbox.
- `$PS1` is the primary prompt string.
- `$PS2` is the secondary prompt string.
- `$PS3` is the select prompt string.
- `$PS4` is the xtrace prompt string.
- `$IFS` is the internal field separator.
- `$COLUMNS` is the number of columns in the terminal.

### Positional parameters

Positional parameters are variables that are assigned when a script is called. They are separated by a space and inside bash, these are accessed with `$1`, `$2`, `$3`, etc. $0 is a special parameter that saves the name of the script. Positional parameters are read-only.

- `$0` is the name of the script.
- `$1` is the first argument.
- `$2` is the second argument.
- `$3` is the third argument.
- `$#` is the number of arguments.
- `$@` is all arguments.
- `$*` is all arguments as a single string.
- `$?` is the exit status of the last command.
- `$$` is the process ID of the current shell.
- `$!` is the process ID of the last command run in the background.
- `$_` is the last argument of the last command.

```sh
#!/usr/bin/bash
#
# Usage:
# echo_parameters.sh <param1> <param2> <param3> <param4>

echo $#  # number of params
echo $0  # name of script
echo $1  # param1
echo $2  # param2
echo $3  # param3
```

`bash echo_parameters.sh yippie kay yay`

will output:

```sh
4
echo_parameters.sh
yippie
kay
yay
```


## Practice with variables

Let's practice declaring and using variables in Bash. Try these 20 exercises covering strings, integers, arrays, associative arrays, environment variables, and positional parameters:

1. **Declare and print a string variable**: Set `NAME` to your name and print it.
2. **Declare and print an integer variable**: Set `AGE` as an integer (using `declare -i`) and print it.
3. **Check variable types**: Use `declare -p` to display the types of `NAME` and `AGE`.
4. **String concatenation**: Declare `FOOD` with your favorite food and print "`<food> is my favourite food`" using curly braces.
5. **Variable substitution in strings**: Create `CITY` and print "I live in $CITY" using double quotes.
6. **Store command output**: Store the current directory in `CURRENTDIR` using `$(pwd)` and print it.
7. **Declare and print an array**: Create `MOVIES` with your 5 favorite movies and print the third movie.
8. **Remove the last array element**: Remove the last movie from `MOVIES` and print the array.
9. **Add elements to an array**: Add two new movies to `MOVIES` and print the updated array.
10. **Print array length**: Print the number of elements in `MOVIES`.
11. **Remove the whole array**: Delete `MOVIES` and verify it's unset.
12. **Simple math with integers**: Declare `NUM=6`, add 4, store in `SUM`, and print `SUM`.
13. **Declare an associative array**: Create `COLORS` with 3 key-value pairs (e.g., "red"="apple", "yellow"="banana", "green"="kiwi").
14. **Print all associative array keys**: Print all keys in `COLORS`.
15. **Remove a key-value pair**: Remove the second key-value pair from `COLORS` and print the array.
16. **Print associative array length**: Print the number of key-value pairs in `COLORS`.
17. **Remove the whole associative array**: Delete `COLORS` and verify it's unset.
18. **Export an environment variable**: Export `EDITOR` as "vim" and print it using `echo $EDITOR`.
19. **Use positional parameters**: Write a script that prints the script name and the first two arguments.
20. **Print special variables**: Print the values of `$USER`, `$PWD`, and `$RANDOM`.

Write Bash code for each scenario and run them to see the results.

