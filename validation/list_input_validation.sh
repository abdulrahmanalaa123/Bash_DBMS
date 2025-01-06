#!/bin/bash

list_input_source=$(dirname $0)

. "$list_input_source/type_validation.sh"
. "$list_input_source/../metadata/metadata_parsing.sh"

# input is considered table_name col_amount cols_list vals_list
list_validation () {

	table_name=$1
	col_amount=$2

	if [[ $(validate_type int $col_amount) = "NaN" ]]
	then
		echo "please enter a valid integer "
		exit 1
	fi
	shift 2


	if [ ${#@} -ne $(((2*$col_amount))) ]
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
	
	declare -a assoc_string=($(type_extraction $table_name))

	declare -A columns

	prev=""
	for index in ${!assoc_string[@]}
	do
		if [[ $(($index%2)) -eq 0 ]]
		then
			prev=${assoc_string[index]}
		else
			#replacing commas with spaces in primary keys
			type_value=${assoc_string[index]/,/ }
			#removing the quotations around the types
			type_value=${type_value//[\"]/}	
			columns[$prev]=$type_value
		fi
	done


	for col_index in ${!col_list[@]}
	do
		col=${col_list[col_index]}
		val=${val_list[col_index]} 

		if [[ -n ${columns["$col"]} ]]
		then
			# the array declaration is useless its there because of the primary key but it should probably be removed
			declare -a type_arr=(${columns["$col"]})
			val_type=${type_arr[0]}

			value=$(validate_type $val_type $col_amount)
			
			if [[ $value = "NaN" ]];
			then
				echo "please enter a valid ${val_type} for column ${col}"
			fi	
		else
			echo "column ${col} doesnt exist "
			exit 1
		fi
	done


	echo "valid"
}

list_validation cats 3 ibla mar bla 3 4 5


