#!/usr/bin/bash

create_table_source=$(dirname ${BASH_SOURCE[0]})
. "$create_table_source/../metadata/metadata_creation.sh"

# create table (colmn1 type, column2 tyep2 ....) 
create_table() {
	query=$1
	command_extraction 
	#compare the main_command with create
	if [[  $main_command = "create" ]]
	then
	
		table_checking
		path="$create_table_source/../Databases/$database/$table_name.csv"

		if [[ -e $path ]]
		then
			echo "table $table_name already exists"
			exit 1
		fi

		#extract columns comma delimited
		columns=$(echo $1 | grep -Eo '\((.*)\)')
		#remove brackets to enable turning the column types into arrays
		columns=${columns//[\(\)]/}
		#convert the columns into an array 
		IFS="," read -r -a colum_arr <<< "$columns"

		declare -a col_list
		declare -a val_list
		
		declare -i primary_index=-1

		for index in ${!colum_arr[@]}
		do
			elem_types=(${colum_arr[index]})
			col_name=${elem_types[0]}
			echo "index is: $index"
			check_colName
			types=${elem_types[@]:1}			
			check_type
		done
		col_string="${col_list[@]}"
		metadata_creation $table_name ${#col_list[@]} ${col_list[@]} ${val_list[@]} $primary_index
		echo "${col_string//[ ]/,}" >> "$path"
	fi
}

command_extraction () {
	#create table
	#create
	main_command=$(echo $query | grep -Eo "^(\w)+[[:space:]]")
	main_command=${main_command// /}
	#turning the main_command lower_case to standardize syntax
	main_command=${main_command,,}		
	echo $main_command
}

table_checking () {
	#extract table name from the query
	table_name=$(echo $query | grep -Eo '[[:space:]]+(\w)+[[:space:]]+[\(]{1}')
	#remove the extra delimiting which is the bracker
	table_name=${table_name//[ \(]/}
	table_name=${table_name,,}
}

check_colName () {
	echo "checking $col_name"
	if [[ ! $col_name =~ ^(int|float|string|primary)$ ]]
	then
		echo $col_name
		col_list+=("$col_name")			
	else
		echo "cannot name $col_name with int,string,float,primary"
		exit 1
	fi
}

check_type () {
	primary=$(echo "$types"|grep -Eo "primary")
	if [[  -n $primary ]]
	then
		primary_index=$index
	fi
	# checking to see if he entered several types and they're contradicting
	# to raise an error
	IFS=" " read -r -a type_list <<< "$(echo $types| grep -Eo "(int|float|string)")"
	if [[ -n $type_list ]]
	then
		val_list+=("${type_list[0]}")
	else
		echo "invalid type_list of $types"	
		exit 1
	fi

}
