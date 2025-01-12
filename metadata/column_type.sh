#!/bin/bash
column_type_src=$(dirname ${BASH_SOURCE[0]})

. "$column_type_src/metadata_parsing.sh"

#you can use type_list after using the columns_extraction
#although its useless after figuring out you can use col_types rightaway
#but its here for convenience
columns_extraction () {
	database=testing
	table_name=$1
	shift
	col_list=($@)

	type_extraction $table_name
	echo $col_types

	declare -a type_list
	#col_types
	for elem in ${col_list[@]}
	do
		if [[ -z ${col_types[$elem]} ]]
		then
			echo "column $elem doesnt exist"
		fi
		type_list+=("${col_types[$elem]}")
	done

	echo -e "$type_list"
}


#declare -a assoc_string=($(type_extraction $table_name))
#	for index in ${!assoc_string[@]}
#	do
#		if [[ $(($index%2)) -eq 0 ]]
#		then
#			prev=${assoc_string[index]}
#		else
#			#replacing commas with spaces in primary keys
#			type_value=${assoc_string[index]/,/ }
#			#removing the quotations around the types
#			type_value=${type_value//[\"]/}	
#			columns[$prev]=$type_value
#		fi
#	done


#prev=""
	#type_list=()
	#do
	#	col=${col_list[col_index]}

	#	if [[ -n ${columns[$col]} ]]
	#	then
	#		# the array declaration is useless its there because of the primary key but it should probably be removed
	#		declare -a type_arr=(${columns["$col"]})
	#		val_type=${type_arr[0]}

	#		type_list+=($val_type)
	#	else
	#		echo "column ${col} doesnt exist "
	#		exit 1
	#	fi
	#done

#echo "${type_list[@]}"
