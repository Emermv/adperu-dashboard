/*  ROOT DB  TABLES*/
/*select c.ruc,c.name,c.direction,c.creation_date,c.modification_date,c.expiration_date  from companys as c join invoice_config  as ic on ic.company_id=c.id where ic.production_mode=1*/
create table company(
id int not null primary key auto_increment,
code varchar(100) not null UNIQUE,
ruc char(11) not null UNIQUE,
name varchar(500),
direction varchar(500),
ubigeo varchar(15),
database_name varchar(100) not null UNIQUE,
state int default 1,
mode int default 1,
creation_date datetime,
modification_date datetime
);
create table users(
id int not null primary key auto_increment,
company_id int not null,
name varchar(100),
role varchar(45),
email varchar(150),
user varchar(45),
password varchar(45),
avatar varchar(250),
level int default 0,
state int  default 1,
creation_date datetime,
modification_date datetime,
foreign key(company_id) references company(id)
);
/*COMPANY DB TABLES*/
create table form(
id int not null primary key auto_increment,
title varchar(500),
state int  default 1,
creation_date datetime,
modification_date datetime
);
create table bell(
id int not null primary key auto_increment,
form_id int not null,
user_id int not null,
code varchar(45),
title varchar(500),
investment decimal(11,2),
state int  default 1,
creation_date datetime,
modification_date datetime,
foreign key(form_id) references form(id),
foreign key(user_id) references app_db.users(id)
);
create table scope(
id int not null primary key auto_increment,
name varchar(45),
state int  default 1,
creation_date datetime,
modification_date datetime
);
create table bell_scope(
id int not null primary key auto_increment,
bell_id int not null,
scope_id int not null,
creation_date datetime,
modification_date datetime,
foreign key(bell_id) references bell(id),
foreign key(scope_id) references scope(id)
);
create table lead(
id int not null primary key auto_increment,
bell_scope_id int not null,
ip varchar(15),
os varchar(45),
latitude varchar(45),
longitude varchar(45),
geo_description varchar(200),
state int  default 1,
creation_date datetime,
foreign key(bell_scope_id) references bell_scope(id)
);
create table lead_data(
id int not null primary key auto_increment,
lead_id int not null,
label varchar(200),
description varchar(500),
type varchar(45),
creation_date datetime,
foreign key(lead_id) references lead(id)
);