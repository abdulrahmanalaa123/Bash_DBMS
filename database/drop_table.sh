#!/bin/bash

table_drop_source=$(dirname ${BASH_SOURCE[0]})


drop_table () {	
	query=$1
	command_extraction	
	if [[ $main_command = "drop" ]]
	then
		table_checking
		path="$table_drop_source/../Databases/$database/$table_name.csv"
		if [[ ! -e $path ]]
		then
			echo "table $table_name doesnt exist"
			exit 1
		else
			sed -inr "/table: $table_name/,/^(=)+$/d" ${path//$table_name.csv/$database.meta}
			rm $path
		fi
	fi
	
}

# can be extracted to helpers and has query as an input 
# instead of using it directly
command_extraction () {
	main_command=$(echo $query | grep -Eo "^(\w)+[[:space:]]")
	main_command=${main_command// /}
	#turning the main_command lower_case to standardize syntax
	main_command=${main_command,,}		
	echo $main_command
}

table_checking () {
	#extract table name from the query
	#[[:space:]]+(\w)+[[:space:]]?$'	
	echo $table_name
	table_name=$(echo ${query// /} | grep -ioP '(?<=droptable).*')
	#remove the extra delimiting which is the bracker
}

