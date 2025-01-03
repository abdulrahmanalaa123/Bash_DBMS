#!/usr/bin/bash

source ./database/create_database.sh
source ./database/show_databases.sh
source ./table/insert_record.sh
source ./table/select_record.sh
source ./table/update_record.sh
source ./table/delete_record.sh


while [[ $input != 'quit' ]];
do
  read -p "> " input
  insert_record $input
  select_records $input
  update_record $input
  delete_record $input
done


echo 'Goodbye'



#show_databases