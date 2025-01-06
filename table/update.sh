#!/usr/bin/bash
#3) UPDATE cats SET name = jack, age = 19 WHERE id=1

# function update_record() {
#   getUpdateValues "$@"
# }

# getUpdateValues(){
#   input=$@
#   table_name=($(echo $input | grep -oiP '(?<=update).*(?=set)'))
#   id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))

#   col_names=($(echo $input | sed 's/ //g' | tr 'A-Z' 'a-z' |\
#   sed -E 's/^.*set(.*)where.*$/\1/' | \
#   awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[1];}}'))

#   col_values=($(echo $input | sed 's/ //g' | tr 'A-Z' 'a-z' | \
#   sed -E 's/^.*set(.*)where.*$/\1/' | \
#   awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[2];}}'))

# if [ -n "$table_name" ] &&
#    [ -n "$id" ] &&
#    [ ${#col_names[@]} -gt 0 ] &&
#    [ ${#col_values[@]} -gt 0 ]; then
#     echo "$table_name"
#     echo "$id"
#     echo "${col_names[@]}"
#     echo "${col_values[@]}"
#   fi

update_source=$(dirname $0)
#echo "Debug: Script started"

function update_record() {
  input="$1"
  #echo "Debug: input received: $input"

  # Extract table name, id, column names, and values
  table_name=$(echo "$input" | grep -oiP '(?<=update ).*(?= set)' | xargs)
  id=$(echo "$input" | grep -oiP '(?<=where id=)[^ ]*' | xargs)
  col_assignments=$(echo "$input" | grep -oiP '(?<=set ).*(?= where)' | xargs)

  if [ -z "$table_name" ] || [ -z "$id" ] || [ -z "$col_assignments" ]; then
 #   echo "Error: Invalid input or missing parameters."
    return 1
  fi

  # Define the path to the CSV file
  csv_file="$update_source/../Databases/$database/${table_name}.csv"
 # echo "Debug: Checking if CSV file exists at '$csv_file'"
  if [ ! -f "$csv_file" ]; then
    echo "Error: CSV file '$csv_file' does not exist."
    return 1
  fi

  # Read the column names and values
  declare -A updates
  while IFS='=' read -r col_name col_value; do
    updates["$col_name"]="$col_value"
  done < <(echo "$col_assignments" | tr ',' '\n')

 # echo "Debug: Updates parsed: ${!updates[@]} -> ${updates[@]}"

  # Read and process the CSV file
  updated_lines=()
  header_read=false
  header=()
  while IFS= read -r line; do
    if [ "$header_read" = false ]; then
      # Process the header line
      IFS=',' read -r -a header <<< "$line"
      header_read=true
      updated_lines+=("$line")
      continue
    fi

  #  echo "Debug: Processing line: $line"

    # Process data lines
    IFS=',' read -r -a row <<< "$line"
    if [ "${row[0]}" == "$id" ]; then
   #   echo "Debug: Found matching id=$id in line: $line"

      # Update the row based on the updates map
      for col_name in "${!updates[@]}"; do
        col_value="${updates[$col_name]}"
        for i in "${!header[@]}"; do
          if [ "${header[$i]}" == "$col_name" ]; then
    #        echo "Debug: Updating column '$col_name' at index $i with value '$col_value'"
            row[$i]="$col_value"
          fi
        done
      done

      # Join the updated row into a line
      line=$(IFS=','; echo "${row[*]}")
    fi

    updated_lines+=("$line")
  done < "$csv_file"

  # Write the updated lines back to the file
 # echo "Debug: Writing updated lines back to CSV file..."
  printf "%s\n" "${updated_lines[@]}" > "$csv_file"

  echo "Record with id=$id updated successfully in CSV file '$csv_file'."
}

# Run the function
update_record "$1"

