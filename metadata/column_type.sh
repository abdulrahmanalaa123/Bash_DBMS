#!/bin/bash
column_type_src=$(dirname $0)

. "$column_type_src/metadata_parsing.sh"

columns_extraction () {

	table_name=$1
	shift
	col_list=($@)

	
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

	type_list=()
	for col_index in ${!col_list[@]}
	do
		col=${col_list[col_index]}

		if [[ -n ${columns[$col]} ]]
		then
			# the array declaration is useless its there because of the primary key but it should probably be removed
			declare -a type_arr=(${columns["$col"]})
			val_type=${type_arr[0]}

			type_list+=($val_type)
		else
			echo "column ${col} doesnt exist "
			exit 1
		fi
	done
	echo "${type_list[@]}"
}

columns_extraction cats bla ibla mar
