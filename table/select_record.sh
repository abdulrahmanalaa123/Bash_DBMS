#!/usr/bin/bash
#2) SELECT CustomerName, City FROM Customers;

function select_records() {
  getSelectValues $1
}

getSelectValues(){
  cols=($(echo $input | grep -oiP '(?<=select).*(?=from)'))
  id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))
  if [[ -n "$id" ]]; then
      table=($(echo $input | sed 's/ //g' | grep -oiP '(?<=from).*(?=where)'))
  else
      table=($(echo $input | sed 's/ //g' | grep -oiP '(?<=from).*'))
  fi
#  echo $table $id ${cols[@]}
}



