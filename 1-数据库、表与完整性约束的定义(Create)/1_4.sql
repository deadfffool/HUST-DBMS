drop database if exists MyDb;
create database MyDb;

use MyDb;
create table products(
    pid char(10) primary key,
    name varchar(32),
    brand char(10) constraint CK_products_brand CHECK(brand in ('A','B')),
    price int constraint CK_products_price CHECK(price > 0)
);