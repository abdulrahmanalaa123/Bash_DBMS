#!/usr/bin/bash

databases=($(ls Databases))

show_databases () {
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