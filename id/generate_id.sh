#!/usr/bin/bash

generate_id(){
  string=`cat id/id.txt`
  id=$((string))
  echo $((id + 1)) > id/id.txt
}
