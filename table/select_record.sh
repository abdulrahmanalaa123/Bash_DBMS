#!/usr/bin/bash
#2) SELECT name, age FROM cats;
#database=animals
select_source=$(dirname "${BASH_SOURCE[0]}")
#declare -A cols_order
declare -a cols_index
source "$select_source/../database/show_table.sh"
function select_records() {
  getSelectValues $@
  if [ -n "$table_name" ]  &&[ -n "$cols" ]; then
    getTableFIle
    getMetaFIle
    field_numbers
    display_a_row $table_name -$id "${cols_index[@]}"
    cols_index=()
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

field_numbers() {
#    n_of_cols=$(sed -n '2p' "$meta_path")
    header=$(head -1 $table_path)
    header=(${header//[,]/ })
    for i in "${!header[@]}"
    do
        for j in "${!cols[@]}" ; do
            if [[ "${header[$i]}" == "${cols[$j]}" ]]; then
              cols_index+=("$((i+1))")
            fi
        done
    done

#    table_cols=($(sed -n '3p' "$meta_path" | cut -d, -f1-$n_of_cols | tr ',' ' '))
#
#    for (( i = 0; i < ${#table_cols[@]}; i++ )); do
#        for (( j = 0; j < ${#cols[@]}; j++ )); do
#            if [[ "${cols[$j]}" == "${table_cols[$i]}" ]]; then
##                cols_order["${table_cols[$i]}"]=$((i + 1))
#                cols_index["${i}"]=$((i))
#            fi
#        done
#    done
}


#TODO: table content starts with columns name??
#TODO: Select only the required columns
#select_records $@
