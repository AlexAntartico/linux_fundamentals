# Control Structures

## input

User input is send into bash by using the `read` command. Read command obtains input from stdin and stores it in a variable.

```sh
#!/bin/bash

echo -e "Write the first number and press enter"
read $NUM1
echo -e "Write the second number and press enter"
read $NUM2

echo -e "The sum of $NUM1 and $NUM2 is:\n$((NUM1 + NUM2))"
```

## Capture Output

You can capture the output of a command by using `$( )`. ie: 

```bash
#!/bin/bash
CMDOUT=$(pwd)

echo -e "This is the output of pwd: $CMDOUT"
```

This will ouput:

`This is the output of pwd: /c/Users/User/Repositories/bash`

## Introduction to Conditional Statements

Bash scripting is a powerful tool for automating tasks in Unix-like systems. One of the key components of writing effective scripts is understanding how to use conditional statements to control the flow execution based on certain conditions. Let's explore the basics of `if`, `else`, and `elif` statements in Bash.

## The `if` Statement

The `if` statement allows you to execute code only if a certain condition is true.

```bash
if [[ condition ]]; then
    # code to execute if condition is true
fi
```

**You should always use double square brackets if you don't have strict portability requirements. They are safer, more powerful and easier to use**

If you need your script to be portable to other POSIX-compliant shells, use single brackets `[ ]`.

| Feature             | `[ ]`                               | `[[ ]]`                               |
|----------------------|---------------------------------------|----------------------------------------|
| Regular Expressions | Not supported                         | Supported with `=~`                    |
| Word Splitting       | Performs word splitting and globbing | Prevents word splitting and globbing |
| Logical Operators    | `-a`, `-o`, `!`                        | `&&`, `||`, `!`                       |
| String Comparison    | Less intuitive                        | More intuitive                         |
| Portability          | POSIX compliant                      | Bash-specific                           |

## The else if - `elif` conditional

`elif` is used when you need to check additional conditions if the first condition does not hold true.

```bash
if [[ condition1 ]]; then
    # code for conditional
elif [[ condition2 ]]; then
    # code for condition2
else
    # code if none of the above conditions are met
fi
```

The best practices is to use `elif` for clarity when checking multiple conditions in sequence.

## The `else` Statement

The `else` part is optional and executes if none of the previous conditions are met.

```bash
if [[ condition ]]; then
    # Code if condition is True
else
    # Code if condition is False
fi
```

`else` is used to handle all other cases not covered by `if` or `elif`.

## Numeric Comparison Operators

These operators are specifically designed for comparing integer values:

* Equal to: `-eq`. Checks if two integers are equal

    ```bash
    COUNT=6

    if [[ "$COUNT" -eq 6 ]]; then
        echo "Count is exactly 6"
    fi
    ```

* Not equal to: `-ne`. Checks if two integers are not equal.

    ```bash
    STATUS=9

    if [[ "$STATUS" -ne 0 ]]; then
        echo "Command failed with status: $STATUS"
    fi
    ```

* Greater than: `-gt`. Checks if the first integer is greater than the second.

    ```bash
    AGE=28

    if [[ "$AGE" -gt 18 ]]; then
        echo "Adult"
    else
        echo "Minor"
    fi
    ```

* Less than: `-lt`. Checks if the first integer is less than the second.

    ```bash
    TEMP=14

    if [[ "$TEMP" -lt 3 ]]; then
        echo "It's cold"
    fi
    ```

* Greater than or equal to: `-ge`. Checks if the first integer is greater than or equal to the second.

    ```bash
    SCORE=88

    if [[ "$SCORE" -ge 70 ]]; then
        echo "Passed"
    else
        echo "Failed"
    fi
    ```

* Less than or equal to: `-le`. Checks if the first integer is less than or equal to the second.

    ```bash
    CAPACITY=80

    if [[ "$CAPACITY" -le 50 ]]; then
        echo "Within Capacity"
    else
        echo "Out of Capacity: $CAPACITY"
    fi
    ```

### Considerations for Numeric comparisons

* Ensure variables are numeric; otherwise, unexpected behavior might occur.
* Use quotes around variables to handle empty or unset variables gracefully

## Arithmetic Expansions for Numeric Comparisons

Using eq, ne, lt, gt, le, ge will feel unnatural. In strict Bash, you can use arithmetic expansions. Basically, you are substituting double square brackets [[ ]] for double parenthesis (( )) and use the regular and well-known math operators.

### Considerations for Arithmetic Expansions for Numeric Comparisons

* Variables don't need quotes inside (())
* Unset or empty variables are automatically treated as 0
* Non-numeric values will cause an error
* You can use && in combination with echo to check the result of the operation
* To print an actual calculation, you need to use echo and append $ to the arithmetic expansion
*
Here's a demonstration:

```bash
# Empty variables become 0
unset A
(( A == 0 )) && echo "unset x equals 0"

# Non-numeric causes error
A="hello"
(( A == 0 ))  # This will fail with error

# No quotes required
B=10
(( B == 10 )) && echo "B equals 10"  # Works just fine without quotes

# Multiple operations work fine

C=3
(( B + C >= 20 ))  # This will fail and will output nothing

(( B + C <= 20 ))  # This will pass and will output nothing

# You can use && to check the result of the operation
(( B + C >= 20 )) && echo 'true' || echo 'false'  # This will output false

# to print an actual calculation, you need to use echo and append $ to the arithmetic expansion
echo $(( B + C ))  # This will output 13

```



