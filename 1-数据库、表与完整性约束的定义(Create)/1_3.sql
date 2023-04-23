drop database if exists MyDb;
create database MyDb;
use MyDb;
create table dept(
    deptNo int primary key,
    deptName varchar(32)
);
create table staff(
    staffNo INT primary key,
    staffName VARCHAR(32),
    gender CHAR(1),	
    dob date,
    salary numeric(8,2),
    deptNo INT,
    CONSTRAINT FK_staff_deptNo FOREIGN KEY(deptNo) REFERENCES dept(deptNo)        
);