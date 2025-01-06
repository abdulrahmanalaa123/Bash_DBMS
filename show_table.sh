#!/bin/bash

# Function to display a table
display_csv_table() {
   table_name=($(echo $input | sed 's/ //g' | grep -oiP '(?<=showtable).*'))

    if [[ -n $table_name ]]; then
      path="Databases/$database/$table_name.csv"
      if [ ! -f $path ]; then
        echo "Error: File '$table_name' not found."
        return 1
      else
        echo "Displaying contents of '$table_name':"
        echo "----------------------------------"

        # format the CSV into columns
        awk -F, 'BEGIN { OFS=" | " } { $1=$1; print }' "$path" | column -t -s "|"

        echo "----------------------------------"
      fi
    fi



}

display_csv_table "$table_name"
