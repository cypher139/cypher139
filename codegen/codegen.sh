#!/bin/bash

BUILDVER="0.7-bash"

# everyone:/codegen [$length] [$type1] [$type2] [$] = >>>
Help() {
	echo -e color7.'codegen.sh '.color3.' - '.colorf.'Prints a randomly generated code. Defaults to a code 7 characters in length using uppercase, lowercase, and numbers.'
	echo -e colora.'Command usage: <required> [optional]'
	echo -e color3.'codegen.sh [length] [Character type 1] [Character type 2]'
	echo -e color3.' - '.colorf.' You can specify how many characters the code should be, and specify the types of characters.'
	echo -e color3.' - '.colorf.' Character types: lowercase ("lower"), uppercase ("upper"), number ("num"), or all.'

}

#minecraft colors:
#bash equiv:

#bash simple date (date command?)
#bash random number
#bash detect no options call
#bash array joins, array implodes to string
#bash: make options for codetype, so called via -luna options. if no options call "-a" ; if $1 not numeric default to 7
# usage: ....sh -luna #
#mc: for 2nd type it does array2, pushes onto end of normal array
#mc: it does select random array slice from computed chars array for however many times $number is, then implodes into single string for display

codegen() {
#var sanity checks
echo test
#assign code var
}


while getopts ":h" option; do
    case $option in
        h) # display Help
         Help
		 exit;;
    esac
done

	#codegen($length, $type1, $type2)
	# if #1 not numeric, go to help
	if [[ "$1" =~ ^[0-9]+$ ]]; then
	Help
	exit
	#call
}
# <<<

echo -e color7.'['.color6.'CodeGen'.color7.'] '.color7.'Code generated at '.simple_dateE.', '.h.':'.m.':'.s.'.'.S.' '.a.':'
echo -e $GENCODE