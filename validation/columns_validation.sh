#!/bin/bash

columns_validation=$(dirname $0)
. "$columns_validation/../metadata/metadata_parsing.sh"

column_exists () {
	table_name=$1
	shift
	col_list=$@
	
	declare -a assoc_string=($(type_extraction $table_name))

	for col in ${col_list[@]}
	do
		if [[ "${assoc_string[@]}" =~ (^|[[:space:]])$col($|[[:space:]]) ]]
		then
			echo "$col exists"
		else
			echo "column ${col} doesnt exist in table ${table_name}"
			exit 1
		fi
	done
}

column_exists cats bla ibla mar hello 
