#!/usr/bin/bash

drop_database () {
  input=$@
  db_name=($(echo $input | sed 's/ //g' | grep -oiP '(?<=dropdatabase).*'))
  if [[ -n $db_name ]]; then
    if [[ -d "Databases/$db_name" ]]; then
      rm -r Databases/$db_name
      echo "Database has been removed."
    else
      echo "Database does not exist."
    fi
  fi
}