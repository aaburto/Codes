#!/bin/bash
# This program will generate a random Password that meets all the requirements in place by Apple.
# These requirements include at least:
# 8 characters long
# 1 capital and/or lower case letter
# 1 special character
# A number
# 2 characters cannot repeat

# Created by: Andres Aburto
# 
#

# lc is all the lowercase letters
# uc is all uppercase letters
# numbers is all single digit numbers
# sc is some special characters that can be taken as variables and not as bash commands.
lc=(a b c d e f g h i j k l m n o p q r s t u v w x y z)
uc=(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
numbers=(0 1 2 3 4 5 6 7 8 9)
sc=(! @ % ^)

# a,b,c,d will be used later to see if any of the arrays above wasn't used. 
# If they weren't, the value stay at 0 and we will have to run again.
a=0
b=0
c=0
d=0

# This function is the one that generates the random character
# First, randomchoose variable is assigned a random number from 1 to 4
# Then, based on the value, it will go into one of the if statements that are alocated to each array of characters.
# A secondrandom variable is used to randomly pick a character out of the array it is looking for
# Once you get the value in the array, this is stored in the newPass array, in the position based on $1
# Finally, it increments the values of a,b,c,d accordingly
function randomcharacter() {
randomchoose=$(( ( RANDOM % 4 )  + 1 ))
	if [ "$randomchoose" = "1" ];
	then
		secondrandom=$(( ( RANDOM % 25 ) ))
		ranPass[$1]="${lc[$secondrandom]}"
		let "a += 1"
		
	elif [ "$randomchoose" = "2" ];
	then
		secondrandom=$(( ( RANDOM % 25 ) ))
		ranPass[$1]="${uc[$secondrandom]}" 
		let "b += 1"
		
	elif [ "$randomchoose" = "3" ];
	then
		secondrandom=$(( ( RANDOM % 9 ) ))
		ranPass[$1]="${numbers[$secondrandom]}" 
		let "c += 1"
	elif [ "$randomchoose" = "4" ];
	then
		secondrandom=$(( ( RANDOM % 3 ) ))
		ranPass[$1]="${sc[$secondrandom]}" 
		let "d += 1"
	fi

}

# This function places the first character.
# Since this is the first character to put, we don't need to check if there are other characters like it.
# It will just run the randomcharacter function
function firstcharacter() {
	x=0
	randomcharacter "$x"	
}

# This function will generate the other 7 characters.
# It will run the randomcharacter function and stored it in newPass array slow based on the x value that the for loop is in.
# The while function will check with the previous character if they match. If they do match, keep running randomcharacter function until they don't.
# This will avoid any repeated characters
# Finally, all the if functions (this can probably be made another function to make it look nicer)
# The if statements check for a,b,c,d values and if any of them are 0, that means that newPass doesn't have one of the characters.
# Since it doesn't have it, run that part of the code again in the position and store it in the position hard coded by me.
# Again, this hard coded part can be done better by putting another Random generator to see in which position to put it on if you would like.
function restofcharacters(){
	for x in {1..7}
	do
		let "y = x-1"
		randomcharacter "$x"
		while [ "${ranPass[$x]}" = "${ranPass[$y]}" ]; 
		do
			randomcharacter "$x"
		done
	done
	
		if [ "$a" = "0" ];
		then 
			secondrandom=$(( ( RANDOM % 25 ) ))
			ranPass[0]="${lc[$secondrandom]}"
			
		elif [ "$b" = "0" ];
		then
			secondrandom=$(( ( RANDOM % 25 ) ))
			ranPass[1]="${uc[$secondrandom]}"
			
		elif [ "$c" = "0" ];
		then
			secondrandom=$(( ( RANDOM % 9 ) ))
			ranPass[2]="${numbers[$secondrandom]}"
			
		elif [ "$d" = "0" ];
		then
			secondrandom=$(( ( RANDOM % 3 ) ))
			ranPass[3]="${sc[$secondrandom]}"
		fi
}
firstcharacter
restofcharacters
newPass=$(printf %s ${ranPass[*]})
echo $newPass


