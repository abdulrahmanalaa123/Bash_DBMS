#!/usr/bin/bash
#3) UPDATE table_name
# SET column1 = value1, column2 = value2, ...
# WHERE condition;

function update_record() {
  getUpdateValues $@
}

getUpdateValues(){
  input=$@
  table_name=($(echo $input | grep -oiP '(?<=update).*(?=set)'))
  id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))

  col_names=($(echo $input | sed 's/ //g' | \
  sed -E 's/^.*set(.*)/\1/' | \
  awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[1];}}'))

  col_values=($(echo $input | sed 's/ //g' | \
  sed -E 's/^.*set(.*)/\1/' | \
  awk -F, '{for (i=1; i<=NF; i++) {split($i, a, "="); print a[2];}}'))


  echo "${col_names[@]}"
  echo "${col_values[@]}"
}
