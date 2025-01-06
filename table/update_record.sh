#!/usr/bin/bash
# 3) UPDATE cats SET name = jack, age = 19 WHERE id=1
update_source=$(dirname ${BASH_SOURCE[0]})

# Function to update a record
function update_record() {
  input=$@
  updated_lines=()
  header=()
  declare -A updates
  get_updates_values
  csv_file="$update_source/../Databases/$database/$table_name.csv"
#  validate_input
  if [ -n "$table_name" ] && [ -n "$id" ] && [ -n "$col_assignments" ]; then
    create_updates_hash
    process_data_file
    update_data_file
  fi
}

get_updates_values() {
  table_name=$(echo "$input" | grep -oiP '(?<=update ).*(?= set)' | xargs)
  id=$(echo "$input" | grep -oiP '(?<=where id=)[^ ]*' | xargs)
  col_assignments=$(echo "$input" | grep -oiP '(?<=set ).*(?= where)' | xargs)
}

validate_input() {
  if [ -z "$table_name" ] || [ -z "$id" ] || [ -z "$col_assignments" ]; then
    echo "Error: Invalid input or missing parameters."
    return 1
  fi

  if [ ! -f "$csv_file" ]; then
    echo "Error: CSV file '$csv_file' does not exist."
    return 1
  fi
}

create_updates_hash() {
  while IFS='=' read -r col_name col_value; do
    updates["$col_name"]="$col_value"
  done < <(echo "$col_assignments" | tr ',' '\n')
}

process_data_file() {
  # Read and process the CSV file
  header_read=false
  while IFS= read -r line; do
    if [ "$header_read" = false ]; then
        # Process the header line
        IFS=',' read -r -a header <<< "$line"
        header_read=true
        updated_lines+=("$line")
        continue
    fi

    # Process data lines
    IFS=',' read -r -a row <<< "$line"
    if [ "${row[0]}" == "$id" ]; then
      # Update the row based on the updates map
      for col_name in "${!updates[@]}"; do
        col_value="${updates[$col_name]}"
        for i in "${!header[@]}"; do
          #TODO: fix this issue of string length
          col_name=$(echo "$col_name" | sed 's/ //g')
          if [ "${header[$i]}" == "$col_name" ]; then
#            echo "Updating column '$col_name' at index $i with value '$col_value'"
            row[$i]="$col_value"
          fi
        done
      done
      # Join the updated row into a line
      line=$(IFS=','; echo "${row[*]}")
    fi
    updated_lines+=("$line")
  done < "$csv_file"
}

update_data_file() {
  # Write the updated lines back to the file
  printf "%s\n" "${updated_lines[@]}" > "$csv_file"
  echo "Record with id=$id updated successfully in CSV file '$csv_file'."
#  echo "updated_lines:" "${updated_lines[@]}"
}
