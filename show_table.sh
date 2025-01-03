#!/bin/bash

# Function to display a table
display_csv_table() {
    local table_name=$1

    # Check if the file exists
    if [ ! -f "$table_name.csv" ]; then
        echo "Error: File '$table_name' not found."
        return 1
    fi

    
    echo "Displaying contents of '$table_name':"
    echo "----------------------------------"

    # format the CSV into columns
    awk -F, 'BEGIN { OFS=" | " } { $1=$1; print }' "$table_name.csv" | column -t -s "|"

    echo "----------------------------------"
}

# 
read -p "Enter the name of the table you want : " table_name


display_csv_table "$table_name"
