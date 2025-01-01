# User journey

## 1- prompt the user menu (Menu)
 
create database|List Database|connect database|drop database|

- `create database` (function create_database(database_name) null print(database name) )
creates metadata_file ---> create metadata()
creates dir
- `list database` (function list_database() null print(databases))
- `drop database` (function drop_database(database_name) null list_database())
-  `connect database` (function connect_database(database_name) --> metadata_file_path,print(conencted to database x succefully))

## 2- database after connection

- prompt user table menu
### DDL
- `create table` (create_table(table_name,column_no,name_list,type_list) => )
- `drop table` (drop_table(table_name) permenantly delete table and delete data )
- `truncate table` (truncate_table(table_name) delete data) (not required)
- `list tables` (list_tables())
- `update table metadata` (update_tables(table_name,name_list,type_list))
- `print table` (print_table(table_name) => print table formatted) 

### DML
- `insert data into table` (insert_data(table_name,column_list,value_list))
- `select data from table` (select_data(table_name,column_list,*id*))
- `update data in table` (update_data(table_name,column_list,value_list,*id*))
- `delete data from table` (delete_data(table_name,column_list,value_list,*id*))

## global helper functions (helper methods)

```
used in 
(create_table,**alter_table_metadata (not required)**) 
```
***if it contains method overloading the two types of the method signature would be used***
***for simplicity and mvp would be done inside the menu logic***
- list input validation (col_no,name_list,type_list) (){ 
	check for null values
	check for lengths of input arrays column_no against names_list and type_list
	return appropriate errors and exit codes
} 
```
(insert_data,update_data,update_table_metadata)
```
- `type_validation` (type_list, value_list) { 
	errors	
}
- `type_extraction` (column_name) =>{metadata} type

### metadata
- `metadata_parser` => list(types),list(columns),pkIndex 
- `metadata_creation` (list(columns),list(types),pkIndex,tableName) 
- `update_metadata` (METAFUNCS,list_of_tables) => 

METACODES
1- add column
2- drop column
3- update column
4- add_table
5- drop_table
6- alter_table_name (not required)
```
# keep in mind arguments either tables or columns are entered in the form of a list

create_table => update_metadata(4,Bishoy)
drop_table => update_metadata(5,Bishoy)
alter_column => update_metadata(3,Bishoy,table_name)
add_column => update_metadata(1,Bishoy,table_name)
drop_column => update_metadata(2,Bishoy,table_name)
```

### rowfinder
***defualt primaryColumn value primaryKey***
- `rowfinder` (column_name,value) => row,rows 
