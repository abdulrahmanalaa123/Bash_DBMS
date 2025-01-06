#!/usr/bin/bash
#2) SELECT name, age FROM cats;

function select_records() {
  getSelectValues $1
    if [ -n "$table_name" ]  &&[ -n "$cols" ] && [ -n "$id" ]; then
#    echo $table_name;echo $id; echo "${cols[@]}"
    getTableFIle
    getMetaFIle
    field_numbers
    select_record
  fi
}

getSelectValues(){
  cols=($(echo $input |  grep -oiP '(?<=select).*(?=from)' | tr ',' ' '))
  id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))
  if [[ -n "$id" ]]; then
      table_name=($(echo $input | tr 'A-Z' 'a-z' | sed 's/ //g' | grep -oiP '(?<=from).*(?=where)'))
  else
      table_name=($(echo $input | tr 'A-Z' 'a-z' | sed 's/ //g' | grep -oiP '(?<=from).*'))
  fi
}

getTableFIle() {
  file_name="$table_name.csv"
  table_path="Databases/$database/$file_name"
}

getMetaFIle() {
  file_name="$table_name.meta"
  meta_path="Databases/$database/$file_name"
}

select_record(){
  echo "selected records"
}

field_numbers() {
    table_cols=($(sed -n '3p' "$meta_path" | cut -d, -f1,2 | tr ',' ' '))

    declare -A cols_order

    for (( i = 0; i < ${#table_cols[@]}; i++ )); do
        for (( j = 0; j < ${#cols[@]}; j++ )); do
            if [[ "${cols[$j]}" == "${table_cols[$i]}" ]]; then
                cols_order["${table_cols[$i]}"]=$i
            fi
        done
    done

    # Print the associative array
    for key in "${!cols_order[@]}"; do
        echo "$key => ${cols_order[$key]}"
    done
}

order_columns(){
  echo asd
}


