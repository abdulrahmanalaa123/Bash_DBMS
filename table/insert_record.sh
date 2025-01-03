#!/usr/bin/bash
#1) INSERT INTO table_name (column1, column2, column3, ...)
# VALUES (value1, value2, value3, ...);

function insert_record() {
  getInsertValues $@
  getTableFIle

  echo $table_name ${cols[@]} ${values[@]}

  if [ -n "$table_name" ]  &&[ -n "$cols" ] && [ -n "$values" ]; then
#    echo $table_name ${cols[@]} ${values[@]}
    appendToTableFile $table_path
  fi

}

function getInsertValues() {
  input=$@
  table_name=($(echo $input | grep -oiP '(?<=insert into).*(?=\()'))
#  table_name=($(echo $input |grep -io 'into [^ (]*' | grep -o '[^ ]*$'))
  cols=($(echo $input | sed 's/ //g' | grep -oiP '(?<=\().*?(?=\)values)'| tr "," "\n"))
  values=($(echo $input | sed 's/ //g' | grep -oiP '(?<=values\().*(?=\))'| tr "," "\n"))
  values_joined=($(echo $input | sed 's/ //g' | grep -oiP '(?<=values\().*(?=\))'))

}

getTableFIle() {
  file_name="$table_name.csv"
  table_path="Databases/animals/$file_name"
}

appendToTableFile() {
  table_path=$1
  echo $values_joined >> $table_path
  echo "Row inserted successfully"
}





