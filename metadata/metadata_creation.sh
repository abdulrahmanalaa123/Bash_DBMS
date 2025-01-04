#!/bin/bash

metadata_creation () {
	table_name=$1
	declare -i col_amount=$2

	if [ col_amount -le 0 ]
	then
		echo "please enter the correct amount of "
	fi
	echo $col_amount
	shift 2

	col_list=${@:1:$col_amount}
	shift $(($col_amount))

	val_list=${@:1:$col_amount}
	
	metadata_string="=================\n$table_name\n"

	col_string=""
	for elem in ${col_list[@]}
	do
		if [[ -n $col_string ]]
		then
			col_string+=","
		fi
		col_string+="$elem"

	done
	metadata_string+="$col_string\n"
	
	echo "col string is $col_string"
	val_string=""
	for elem in ${val_list[@]}
	do

		if [[ -n $val_string  ]]
		then
			val_string+=","
		fi
		val_string+="$elem"

	done
	metadata_string+="$val_string\n"

	echo "val string is $val_string"
	echo $metadata_string
}


metadata_creation elem b bla mar ibla qbla bla bkbla

# metadata sample input is database name
# table_name col_no col_list type_list  
# col_no needs to be specificied 

