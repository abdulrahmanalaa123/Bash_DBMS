#!/bin/bash

creation_source=$(dirname "$0")
. "$creation_source/../validation/type_validation.sh"

# metadata_creation needs to be ran inside the source of database 
# assuming it wont be ran unless you're connected where cd'd inside the database
metadata_creation () {
	# this should be turned into a module on its own but not right now	
	table_name=$1
	col_amount=$2

	if [[ $(validate_type int $col_amount) = "NaN" ]]
	then
		echo "please enter a valid integer "
		exit 1
	fi
	shift 2

	echo "size is ${#@}"

	echo "valid size is $(((2*$col_amount)+1))"

	if [ ${#@} -ne $(((2*$col_amount)+1)) ]
	then
		echo "please enter a valid amount of columns with their respective column types"
		exit 1	
	fi	
	
	#converting the seperationg to a list explicitly
	declare -a col_list=(${@:1:$col_amount})
	shift $(($col_amount))

	#converting the seperationg to a list explicitly
	declare -a val_list=(${@:1:$col_amount})
	shift $(($col_amount))
	
	metadata_string=$(printf "================\ntable: $table_name\n")

	col_string=""
	for elem in ${col_list[@]}
	do

		if [[ $col_string =~ ^(int|string|float)$ ]]
		then
			echo "please enter a valid column name"
			exit 1
		fi
		if [[ -n $col_string ]]
		then
			col_string+=","
		fi
		col_string+="$elem"

	done
	metadata_string+=$(printf "\ncolumn_names: $col_string\n")
	
	val_string=""
	for elem in ${val_list[@]}
	do

		if [[ $elem =~ ^(int|string|float)$ ]]
		then
			if [[ -n $val_string  ]] 
			then
				val_string+=","
			fi
			val_string+="$elem"
		else
			echo "please enter a valid type out of int | string | float"
			exit 1
		fi

	done
	metadata_string+=$(printf "\ncolumn_types: $val_string\n")


	if [[ $(validate_type int $1) != "NaN" ]]
	then
		if [[ $1 -gt  0 ]] && [[ $1 -le $col_amount ]]
		then
			index=$1
			metadata_string+=$(printf "\nprimary_key_index: $index\n")	
			metadata_string+=$(printf "\nprimary_key: ${col_list[index]}\n")	
		else
			echo "please enter a valid primary key index"
			exit 1
		fi
	else
		echo "please enter a valid primary key index starting from 0"
		exit 1
	fi
	echo "$metadata_string" >> "$creation_source/meta"
}


metadata_creation dogs 3 bla mar ibla int int int 1

# metadata sample input is database name
# table_name col_no col_list type_list  
# col_no needs to be specificied 

