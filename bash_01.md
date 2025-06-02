# Bash scripting Basics

## Variables

### Declaring variables

Simply type:

```bash
NAME="value" # No spaces between variable name, equal sign and value
```

- Variable names:
  - Can contain letters, numbers and underscores
  - Cannot start with a number
  - Are case-sensitive
  - Should be in uppercase by common practice

### Using variables

We have several types of variables besides stings in bash:

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

You need quotes and `$` together when:

1. **Echoing variable values**: `echo "$VARIABLE"` - quotes preserve value formatting.
2. **Assigning values with spaces**: `VARIABLE="hello world"` - quotes ensure single assignment.
3. **Passing variables as arguments**: `my_script "$VARIABLE"` - quotes preserve value formatting.
4. **Using variables in strings**: `echo "My value is $VARIABLE"` - `$` accesses value, quotes ensure correct string formatting.
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

Lets practice declaring and using some variables. Try these scenarios using strings, integers, arrays and associative arrays:

1. Declare and print a name and an age. Age must be integer.
2. Return the type of variables declared in step 1. name should be a string and age should be an integer.
3. Declare variable "FOOD" with your favourite food value and use curly braces to append " is my favourite food".
4. Declare variables FIRSTNAME and LASTNAME with your first and last name. Use positional parameters to print your full name.
5. Declare an array with your favourite 5 movies and print the third movie.
6. Remove the last movie from 5.
7. Add two new movies to the array.
9. Return the array length from 7, it should be 6.
10. Remove the whole array.
11. Simple Math: Delare NUM with value 6, add 4, store in a variable and print said variable.
12. Declare an associative array with 3 key-value pairs. Print all keys.
13. Remove the second key-value pair.
14. Print the length of the associative array, it should be 2.
15. Remove the whole associative array.

