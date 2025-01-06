#!/usr/bin/bash

source ./database/create_database.sh
source ./database/drop_database.sh
source ./database/show_tables.sh
source ./database/show_table.sh
source ./table/insert_record.sh
source ./table/create_table.sh
source ./table/drop_table.sh
source ./table/select_record.sh
source ./table/update_record.sh
source ./table/delete_record.sh
source ./id/generate_id.sh

show_databases () {
  show_command=$(echo "$@" | grep -w "^show$")
  databases=($(ls Databases))
  if [[ -n "$show_command" ]]
  then
    list_databases
  fi
}

list_databases () {
  PS3="Select the number of database name:"
  select db in "${databases[@]}";
  do
    if [[ -n "$db" ]]; then
      case $db in
        *)
          echo "connected to: $db"
          database=$db
          break
          ;;
      esac
    else
      echo "Please select a valid option."
    fi
  done
}

while [[ $input != 'quit' ]];
do
  read -p "> " input
  create_database $input
  show_databases $input
  drop_database $input
  if [[ -z $database ]];
  then
    echo '> List and connect to database by typing: show'
    continue
  fi
  show_tables $input
  show_table $input
  create_table $input
  drop_table $input
  insert_record $input
  select_records $input
  update_record $input
  delete_record $input
done


echo 'Goodbye'
