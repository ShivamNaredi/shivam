create database users; -- creation of database
 -- drop database users;
 use users;
 create table manager(first_name varchar(50), 
					last_name varchar(50), 
                    manager_id int not null unique, 
                    dob DATE, -- YYYY-MM-DD
                    primary key (manager_id));
-- primary key is always unique and not null. It represents each row in the table uniquely and can be a group of columns.
 create table employee(first_name varchar(50), 
					last_name varchar(50), 
                    emp_id int not null unique,
                    manager_id int not null,
                    dob DATE, -- YYYY-MM-DD
                    primary key (emp_id),
                    foreign key (manager_id) references manager(manager_id));
-- foreign key is the primary key of the referring table.
insert into manager values("Muskan", "Gupta", 2, "1998-12-25");
insert into employee values("Siya", "Mundhada", 4, 2, "2003-08-14");
select * from manager;
select * from employee order by dob DESC;
select first_name from employee where manager_id = 2;
drop table employee;
Alter table employee add column address varchar(20) not null;
select employee.emp_id AS EMP_ID, employee.first_name AS EMP_NAME, manager.manager_id AS MANAGER_ID, manager.first_name AS MANAGER_NAME from employee inner join manager on employee.manager_id = manager.manager_id;

create table item(item_id int not null unique,
					item_name varchar(50),
                    stock int,
                    store_id int,
                    primary key(item_id),
                    foreign key(store_id) references store(store_id));
insert into item values(1, "Samsung Mobile Phone", 50, 101);
insert into item values(2, "LG Washing Machine", 5, 101);
insert into item values(3, "Godrej Table", 10, 102);
insert into item values(4, "Green Soul Office Chair", 25, 102);
insert into item values(5, "Sony LED TV", 100, 103);
insert into item values(6, "Whirlpool Refrigerator", 11, 104);
insert into item values(7, "Apple iphone", 21, 104);
select * from item;
select * from store order by Location limit 1;
select count(Location) from store;
select * from store;
create table store(store_id int not null unique,
						Location varchar(50),
                        capacity int,
                        primary key(store_id));
insert  into store values(103, "Delhi", 20000);
insert into store values(104, "Lucknow", 5000);

select item.item_name as NAME, store.Location as LOCATION from item inner join store on item.store_id = store.store_id order by NAME;
-- 1: 4, 5, 1, 0 = 0
-- 2: 6, -2, 0, -5 = -5

update item set store_id = 104 where item_id = 6;

select avg(stock) from item;
select store_id, sum(stock) as "Stocks per store" from item group by store_id;

DELIMITER $$
-- funtion to call max stock
CREATE FUNCTION GetMaxStock() RETURNS INT
BEGIN
    DECLARE max_stock INT;
    SELECT MAX(stock) INTO max_stock FROM item;
    RETURN max_stock;
END $$
DELIMITER ;
SELECT GetMaxStock() AS MaxStock;


