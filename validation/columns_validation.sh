#!/bin/bash

column_exists () {
	table_name=$1
	col_list=$@
	

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


}
