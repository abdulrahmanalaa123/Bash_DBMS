
# assuming source execution for looking at current working dir

type_extraction () {
	table_name=$1

	table_data=$(sed -nr "/table: $table_name/,/^(=)+$/p" ../metadata/meta)

	
	declare -A ary

	while IFS=": " read -r key value;
	do
		if [[ -n $value ]]
		then
			ary["$key"]="$value"	
		fi
	done < <(echo -e "$table_data");

	# using comma as a seperator and printing out the output of such a list inside an array and looping over them
	# both to assign each col its respective type

	IFS="," read -r -a col_names < <(echo -e "${ary["column_names"]}")
	IFS="," read -r -a types < <(echo -e "${ary["column_types"]}")

	primary=${ary["primary_key"]}
	declare -A col_types

	#using the indirect exapnsion to get the indeces as a space speerated list
	for index in ${!col_names[@]}
	do
		name=${col_names[index]}
		val=${types[$index]}

		if [[ "$name" = $primary ]]
		then
			val="$val,primary"
		fi

		col_types["$name"]="$val"
	done

	echo -e "${col_types[@]@K}"
	
	
}

