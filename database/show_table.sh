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
      echo "Displaying contents of '$table_name':"
      echo "----------------------------------"
        # format the CSV into columns
      if [[ -n $line ]]; then
#       awk -F, -v line="$line" 'BEGIN { OFS=" | " } NR==line { $1=$1; print }' "$path" | column -t -s "|"
       awk -F, -v line="$line" 'BEGIN { OFS=" | " } NR==line { print $1, $2 }' "$path" | column -t -s "|"
      else
        awk -F, 'BEGIN { OFS=" | " } { $1=$1; print }' "$path" | column -t -s "|"
      fi
      echo "----------------------------------"
    fi
  fi
}

