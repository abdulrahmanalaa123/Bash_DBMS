#!/usr/bin/bash

source ./database/create_database.sh
source ./database/drop_database.sh
source ./table/insert_record.sh
source ./table/select_record.sh
source ./table/update_record.sh
source ./table/delete_record.sh

#!/usr/bin/bash

show_databases () {
  show_command=$(echo "$@" | grep 'show')
  databases=($(ls Databases))
  if [[ -n "$show_command" ]]
  then
    list_databases
  fi
}


list_databases () {
  PS3="Select the database name:"
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
    echo '> Show databases by typing: show'
    continue
  fi
  insert_record $input
  select_records $input
  update_record $input
  delete_record $input
done


echo 'Goodbye'