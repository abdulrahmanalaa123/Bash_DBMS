#!/usr/bin/bash
#3) UPDATE cats SET name = jack, age = 19 WHERE id=1

function update_record() {
  getUpdateValues "$@"
}

getUpdateValues(){
  input=$@
  table_name=($(echo $input | grep -oiP '(?<=update).*(?=set)'))
  id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))

  col_names=($(echo $input | sed 's/ //g' | tr 'A-Z' 'a-z' |\
  sed -E 's/^.*set(.*)where.*$/\1/' | \
  awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[1];}}'))

  col_values=($(echo $input | sed 's/ //g' | tr 'A-Z' 'a-z' | \
  sed -E 's/^.*set(.*)where.*$/\1/' | \
  awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[2];}}'))

if [ -n "$table_name" ] &&
   [ -n "$id" ] &&
   [ ${#col_names[@]} -gt 0 ] &&
   [ ${#col_values[@]} -gt 0 ]; then
    echo "$table_name"
    echo "$id"
    echo "${col_names[@]}"
    echo "${col_values[@]}"
  fi

}
