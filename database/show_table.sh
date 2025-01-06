#!/usr/bin/bash
show_table_source=$(dirname ${BASH_SOURCE[0]})

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
  table_name=$1
  #TODO: CLEAN this shit in the near future
  id=$2;
  id=${id//-/}
  shift 2
  cols_index=("$@")
  path="$show_table_source/../Databases/$database/$table_name.csv"

  echo "----------------------------------"
    # format the CSV into columns

    cols_index_str=$(IFS=,; echo "${cols_index[*]}")
    # Use awk to check the column values
    awk -F, -v id="$id" -v cols_index_str="$cols_index_str" '
      BEGIN {
        split(cols_index_str, cols_array, ",");
        OFS = " | ";
      }
      {
        output = "";
        if ((!id|| $1 == id) || NR == 1) {
          for (i in cols_array) {
            output = output (output ? "|" : "") $cols_array[i];
          }
        print output;
        }
      }' "$path" | column -t -s "|"
  echo "----------------------------------"

}
