--drop table sys_city
--drop table sys_state
--drop table sys_country
--drop table sys_roles
--drop table sys_login
--drop table sys_users
--drop table sys_retail


-- sys_country
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_country]') and type in (N'U'))
BEGIN
create table sys_country (
id int identity(1,1) primary key,
countryName nvarchar(100) NOT NULL,
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END


-- sys_state
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_state]') and type in (N'U'))
BEGIN
create table sys_state (
id int identity(1,1) primary key,
stateName nvarchar(100) NOT NULL,
countryId int constraint fk_state_countryId foreign key references sys_country(id),
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END


-- sys_city
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_city]') and type in (N'U'))
BEGIN
create table sys_city (
id int identity(1,1) primary key,
cityName nvarchar(100) NOT NULL,
stateId int constraint fk_city_stateId foreign key references sys_state(id),
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END


-- sys_roles
if not exists (select * from sys.objects where object_id= OBJECT_ID(N'[dbo].[sys_roles]') and type in(N'U'))
begin

create table [dbo].[sys_roles]
(
id int identity(1,1) primary key NOT NULL,
roleName varchar(1000) NOT NULL,
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
end


-- sys_login
if not exists (select * from sys.objects where object_id= OBJECT_ID(N'[dbo].[sys_login]') and type in(N'U'))
begin
create table [dbo].[sys_login]
(
id int identity(1,1) PRIMARY KEY NOT NULL,
loginName nvarchar(1000) NOT NULL,
loginPassword nvarchar(1000) not null,
roleId int not null constraint fk_login_roledId foreign key references [dbo].[sys_roles](id),
isInActive bit default(0),
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
end


-- sys_users
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_users]') and type in (N'U'))
BEGIN
create table sys_users (
id int identity(1,1) primary key,
loginId int constraint fk_users_loginId foreign key references sys_login(id),
firstName nvarchar(255) NOT null,
middleName nvarchar(100) NULL,
lastName nvarchar(100) NOt null,
[address] nvarchar(1000) not null,
mobileNo nvarchar(20) not null,
landlineNo nvarchar(20) null,
age numeric(3,0) not null,
cityId int constraint fk_users_cityId foreign key references sys_city(id),
email nvarchar(100) null,
pincode numeric(20,0) not null,
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END


-- sys_retail
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_retail]') and type in (N'U'))
BEGIN
create table sys_retail (
id int identity(1,1) primary key,
loginId int constraint fk_retail_loginId foreign key references sys_login(id),
retailName nvarchar(255) NOT null,
[address1] nvarchar(1000) not null,
[address2] nvarchar(1000) not null,
mobileNo1 nvarchar(20) not null,
mobileNo2 nvarchar(20) not null,
landlineNo1 nvarchar(20) null,
landlineNo2 nvarchar(20) null,
cityId int constraint fk_retail_cityId foreign key references sys_city(id),
website nvarchar(100) null,
pincode numeric(20,0) not null,
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END


-- sys_retail2Images
IF not exists (select * from sys.objects where object_id = object_id(N'[dbo].[sys_retail2Images]') and type in (N'U'))
BEGIN
create table sys_retail2Images (
id int identity(1,1) primary key,
retailId int constraint fk_retail2Images_retailId foreign key references sys_retail(id),
[fileName] nvarchar(100) NOT NULL,
fileLocation nvarchar(500) NOT NULL,
createdBy nvarchar(255) null,
createdDate datetime null,
updatedBy nvarchar(255) null,
updatedDate datetime null
)
END
