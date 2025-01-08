#!/usr/bin/bash

show_table() {
  input=$@
  table_name=($(echo $input | grep -oiP '(?<=show table ).*'))
  if [[ -n $table_name ]]; then
    path="Databases/$database/$table_name.csv"
    if [ ! -f $path ]; then
      echo "Error: File '$table_name' not found."
      return 1
    else
     display_full_table
    fi
  fi
}

# shellcheck disable=SC2120
display_full_table() {
  echo "Displaying contents of '$table_name':"
  echo "----------------------------------"
    # format the CSV into columns
  awk -F, 'BEGIN { OFS=" | " } { $1=$1; print }' "$path" | column -t -s "|"
  echo "----------------------------------"
}

display_a_row () {
  [[ -n "$1" && -n "$2" ]] &&
  table_name=$1 &&
  id=$2; shift; shift &&
  cols_index=("$@") &&
  path="Databases/$database/$table_name.csv"

  echo "Displaying contents of '$table_name':"
  echo "----------------------------------"
    # format the CSV into columns
    awk -F, -v id="$id" 'BEGIN {
    OFS=" | " }
    {if($1==id) print}' "$path" | column -t -s "|"
  echo "----------------------------------"

}

