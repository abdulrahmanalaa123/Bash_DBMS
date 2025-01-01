# Requirements

1- Create,List,drop,isnert, select,delete, update

query columns from valid name
enum bishoy [Select,create,delete,udpate]
	[1,2,3,4]
1)
function select
2)
function delete
3)
function create
4)

space  [select,\*,from,database]
where,id,=,x
Select \* from database where id = x

# Database

Main database dir
- dir --> database (hamada)
- files --> tables
- list --> table (show tables)
- list table specific --> cat file (Table module) 
- create table --> file creation
- delete table --> file deletion

# Tables

CSV
drop table data --> file delete data rewrite 
inserting data --> append data to file check for uniqueness of primary key (auto increment)
row finder --> function to find the specific row or a range of rows using a clause
row finder --> row
row --> delete,update,select 


# Menu

## DataBase menu
1) create database --> mkdir
2) List Database --> ls -d root database dir for directories
3) connect Database --> check validity of database  (exists) (executable)
4) drop Database --> delete directory
5) exit

## Menu after connection (session)
function table printing 

DDL
1) create table
2) List table"s"
3) drop table"s"
4) update table's metadata

DML
4) insert data into table
5) select data from table
6) delete data from table
7) update data in table row

```
- prompt ddl 
enter table name 
enter space seperated data

- delete update
enter table name
enter id

update
enter data 
```

advanced

alter table metadata

# Metadata for every table

- table name
- attribute number (number of columns)
- attribute names (column names)
- attribute types (types of columns)
- primary key (which column, enforce unique not null)
