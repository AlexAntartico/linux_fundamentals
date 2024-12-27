#!/usr/bin/env bash

echo -e "\nDeclare and print a name and an age. Age must be integer."
NAME="Eduardo"
declare -i AGE=36
echo "$NAME"
echo "$AGE" 

echo -e "\n\nReturn the type of variables declared in step 1. name should be a string and age should be an integer."

declare -p NAME
declare -p AGE

echo -e "\n\nDeclare variable FOOD with your favourite food value and use curly braces to append \"is my favourite food\""
FOOD="Kimchi Ramen"
echo "${FOOD}" is my favourite food

echo -e "\n\nDeclare variables FIRSTNAME and LASTNAME with your first and last name. Use positional parameters to print your full name."
FIRSTNAME="Eduardo"
LASTNAME="Garcia"

echo "$FIRSTNAME $LASTNAME"

echo -e "\n\nDeclare an array with your favourite 5 movies and print the third movie."

declare -a MOVIES=("1 Gladiator" "2 Revenge of the Sith" "3 Kingdom of Heaven" "4 Attack of the clones" "5 The Two Towers")

echo "${MOVIES[@]}" 
echo "${MOVIES[2]}"

echo -e "\n\nRemove the last movie from 5."

unset MOVIES[4]
echo "${MOVIES[@]}"

echo -e "\n\nAdd two new movies to the array."

MOVIES+=("6 Rogue One" "7 Die Hard, the best Christmas Movie")
echo "${MOVIES[@]}"

echo -e "\n\nReturn the array length from 7, it should be 6."

echo "${#MOVIES[@]}"

echo -e "\n\nRemove the whole array."

unset MOVIES
echo "${MOVIES[@]}"

echo -e "\n\nSimple Math: Delare NUM with value 6, add 4, store in a variable and print said variable."

declare -i NUM=6
RESULT=$((NUM + 4))
echo "$RESULT"

echo -e "\n\nDeclare an associative array with 3 key-value pairs. Print all keys."

declare -A MYARRAY

MYARRAY["key 1"]="value test"
MYARRAY["key 2"]="value 1"
MYARRAY["key 3"]="value 2"

echo ${!MYARRAY[@]}

echo -e "\n\nRemove the second key-value pair."

unset MYARRAY["key 2"]
echo ${!MYARRAY[@]}

echo -e "\n\nPrint the length of the associative array, it should be 2."

echo ${#MYARRAY[@]}

echo -e "\n\nRemove the whole associative array."

unset MYARRAY
echo ${!MYARRAY[@]}


