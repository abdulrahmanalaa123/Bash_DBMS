#!/usr/bin/bash
#4) DELETE FROM table_name WHERE condition;

delete_record() {
  table_name=($(echo $input | grep -oiP '(?<=delete from).*(?=where)'))
  id=($(echo $input | sed 's/ //g' | grep -oiP '(?<=whereid=).*'))
  if [ -n "$table_name" ] && [ -n "id" ]; then
    delete_row_by_id $table_name $id
  fi
}

delete_row_by_id(){
  table_name=$1
  primary_key=$2
  DATABASE="school"

  local table_file="Databases/$DATABASE/${table_name}.csv"

#   table exist validation
#    if [ ! -f $table_file ]; then
#         echo "Table not found"
#            return 1
#    fi

  if grep -q "${primary_key}" "$table_file"; then
    sed -i "/${primary_key},/d" "$table_file"
    echo "Row deleted successfully"
  else
    echo "ROW NOT FOUND"
    return 1
  fi
}
