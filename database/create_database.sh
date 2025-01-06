#!/usr/bin/bash

create_database () {
  input=$@
  db_name=($(echo $input | sed 's/ //g' | grep -oiP '(?<=createdatabase).*'))
  if [[ -n "$db_name" ]]
  then
    mkdir Databases/$db_name
    echo 'Database has been created!'
  fi
}
