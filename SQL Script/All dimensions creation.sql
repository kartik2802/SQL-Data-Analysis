-- Create #1 Dimention: Orders Table

create table Orders(
	Order_ID  varchar(255) not null,
	Order_Date   varchar(255),
	Ship_date   varchar(255),
	Ship_Mode varchar(255),
    primary key (Order_ID)
    );

select * from Orders;
    
-- Create #2 Dimention: Customers Table
create table Customers(
	Customer_ID  varchar(255) not null,
	Customer_name varchar(255),
	Segment  varchar(255),
    primary key (Customer_ID)
    );
select * from Customers ;
    
-- Create #3 Dimention: Products Table
create table Products(
	Product_ID  varchar(255) not null,
	Category  varchar(255),
	Sub_category varchar(255),
	Product_name  varchar(255),
    primary key (Product_ID)
    );
select * from Products;

-- Create #4 Dimention: Location Table
create table Location(
	Location_ID int not null auto_increment,
    Country  varchar(255),
	City  varchar(255),
	State  varchar(255),
	Postal_code  varchar(255),
	Region  varchar(255),
    primary key (Location_ID)
    );
  select * from customers;
  select * from location;
  
  
-- Create fact table
drop table fact_table;
create table fact_table
( 	fact_id int not null auto_increment,
	Sales   float,
	Quantity int,
	Discount  float,
	Profit  float,
    Product_ID  varchar(255),
    Customer_ID  varchar(255),
	Order_ID  varchar(255),
    Location_ID int,
    primary key (fact_id),
    foreign key (Product_ID) references Products (Product_ID) ON DELETE SET NULL,
    foreign key (Customer_ID ) references Customers (Customer_ID ) ON DELETE SET NULL,
    foreign key (Order_ID ) references Orders (Order_ID ) ON DELETE SET NULL,
    foreign key (Location_ID) references Location (Location_ID) ON DELETE SET NULL
);

select  * from fact_table;