#!/usr/bin/bash

show_tables () {
  input=$@
  show_tables=($(echo $input | sed 's/ //g' | grep -oiP '^showtables$'))
  if [[ -n $show_tables ]]; then
    files=($(ls Databases/$database))
    for f in "${files[@]}" ; do
      if [[ $f =~ \.csv$ ]]; then
          echo "$f" | sed 's/\.csv$//'
      fi
    done
  fi
}