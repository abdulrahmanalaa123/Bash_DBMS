#!/usr/bin/bash
#2) SELECT name, age FROM cats;

#declare -A cols_order
declare -a cols_index
source "./database/show_table.sh"

function select_records() {
  getSelectValues $1
    if [ -n "$table_name" ]  &&[ -n "$cols" ] && [ -n "$id" ]; then
#    echo $table_name;echo $id; echo "${cols[@]}"
    getTableFIle
    getMetaFIle
    field_numbers
    select_record $table_name $id $cols_index
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
  display_a_row $table_name $id "${cols_index[@]}"
}

field_numbers() {
    n_of_cols=$(sed -n '2p' "$meta_path")
    table_cols=($(sed -n '3p' "$meta_path" | cut -d, -f1-$n_of_cols | tr ',' ' '))

    for (( i = 0; i < ${#table_cols[@]}; i++ )); do
        for (( j = 0; j < ${#cols[@]}; j++ )); do
            if [[ "${cols[$j]}" == "${table_cols[$i]}" ]]; then
#                cols_order["${table_cols[$i]}"]=$((i + 1))
                cols_index["${i}"]=$((i + 1))
            fi
        done
    done
}

order_columns(){
  echo asd
}

#TODO: table content starts with columns name??
#TODO: Select only the required columns

