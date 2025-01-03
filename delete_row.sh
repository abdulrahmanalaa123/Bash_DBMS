remove_row_by_id() {
    local table_name=$1
    local primary_key=$2

    # Use the current directory for the table file
    local table_file="./${table_name}.csv"

    # Check if the table file exists
    if [ ! -f "$table_file" ]; then
        echo "Table not found: $table_file"
        return 1
    fi

    # Search for the primary key and delete the row
    if grep -q "^${primary_key}," "$table_file"; then
        sed -i "/^${primary_key},/d" "$table_file"
        echo "Row with primary key $primary_key deleted successfully from $table_name"
    else
        echo "ROW NOT FOUND with primary key $primary_key in $table_name"
        return 1
    fi
}

# Function to prompt the user for table name and primary key
prompt_user() {
    # Ask for the table name
    read -p "Enter the table name: " table_name

    # Ask for the primary key
    read -p "Enter the primary key (id) of the row to delete: " primary_key

    # Call the remove_row_by_id function
    remove_row_by_id "$table_name" "$primary_key"
}

# Main script execution
   prompt_user

