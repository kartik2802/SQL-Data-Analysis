drop table temp_tablebi5;
create table temp_tableBI5
(
	Row_ID int,
	Order_ID  varchar(255),
	Order_Date   varchar(255),
	Ship_date   varchar(255),
	Ship_Mode varchar(255),
	Customer_ID  varchar(255),
	Customer_name varchar(255),
	Segment  varchar(255),
	Country  varchar(255),
	City  varchar(255),
	State  varchar(255),
	Postal_code  varchar(255),
	Region  varchar(255),
	Product_ID  varchar(255),
	Category  varchar(255),
	Sub_category varchar(255),
	Product_name  varchar(255),
	Sales   float,
	Quantity int,
	Discount  float,
	Profit  float
);
select * from temp_tableBI5;
describe temp_tableBI5;

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

-- Uploading Orders Table
INSERT IGNORE INTO Orders( Order_ID,Order_Date, Ship_date ,Ship_Mode )
SELECT DISTINCT Order_ID,Order_Date, Ship_date ,Ship_Mode FROM temp_tablebi5;

select * from Orders;

-- Uploading Customers Table
INSERT IGNORE INTO Customers(Customer_ID,Customer_name,Segment)
SELECT DISTINCT Customer_ID,Customer_name,Segment from temp_tablebi5;

select * from customers;

-- Uploading Products Table
INSERT IGNORE INTO Products(Product_ID ,Category,Sub_category,Product_name)
SELECT DISTINCT Product_ID ,Category,Sub_category,Product_name from temp_tablebi5;

select * from Products;

-- Uploading Location Table
INSERT IGNORE INTO Location(Country,City ,State ,Postal_code,Region)
SELECT DISTINCT Country,City ,State ,Postal_code,Region from temp_tablebi5;

select * from location;

-- Uploading Fact Table

INSERT IGNORE INTO fact_table(Sales,Quantity,Discount,Profit,Product_ID, Customer_ID , Order_ID)
SELECT DISTINCT
    t.Sales,
    t.Quantity,
    t.Discount,
    t.Profit ,
    p.Product_ID,
    c.Customer_ID ,
    o.Order_ID
FROM temp_tablebi5  t inner join products p on t.Product_ID= p.Product_ID
inner join customers c on t.Customer_ID = c.Customer_ID 
inner join orders o on t.Order_ID = o.Order_ID



;

select * from fact_table;

select count(*) as cnt from temp_tablebi5;
-- Trying to see if these have any duplicates
select * from products;
select Product_ID , Category , Sub_category , Product_name , count(*) as cnt
from products
group by Product_ID , Category , Sub_category , Product_name ;
-- results shows no duplicates..hence inserting duplicates to check the query
INSERT INTO products (Product_ID , Category , Sub_category , Product_name)
VALUES('FUR-BO-10000113',
'Furniture',
'Bookcases',
'BushBirminghamCollectionBookcaseDarkCherry');
-- it is not allowing to create a duplicate row due to primary key constraint

select Category , Sub_category , Product_name , count(*) as cnt
from products
group by Category , Sub_category , Product_name 
having count(*)>1;

-- checking the same in data loaded in temp table
select Category , Sub_category , Product_name, count(*) as cnt
from temp_tablebi5
where Category ='Furniture'and
Sub_category ='Furnishings' and
Product_name ='EldonWaveDeskAccessories';

select * from temp_tablebi5;
INSERT INTO temp_tablebi5
VALUES (
3,'
CA-2020-138688','
6/12/2020	','
6/16/2020	','
Second Class','
DV-13045','
Darrin Van Huff','
Corporate','
United States','
Los Angeles','
California','
90036	','
West	','
OFF-LA-10000240	','
Office Supplies	','
Labels	','
SelfAdhesiveAddressLabelsforTypewritersbyUniversal',
14.62,
2,
0	,
6.8714);

select Row_ID ,
	Order_ID ,
	Order_Date  ,
	Ship_date   ,
	Ship_Mode ,
	Customer_ID  ,
	Customer_name ,
	Segment  ,
	Country  ,
	City ,
	State ,
	Postal_code ,
	Region  ,
	Product_ID  ,
	Category ,
	Sub_category ,
	Product_name  ,
	Sales  ,
	Quantity ,
	Discount  ,
	Profit  , count(*) as count
    from temp_tablebi5
    group by Row_ID ,
	Order_ID ,
	Order_Date  ,
	Ship_date   ,
	Ship_Mode ,
	Customer_ID  ,
	Customer_name ,
	Segment  ,
	Country  ,
	City ,
	State ,
	Postal_code ,
	Region  ,
	Product_ID  ,
	Category ,
	Sub_category ,
	Product_name  ,
	Sales  ,
	Quantity ,
	Discount  ,
	Profit
    having count(*)>1;
    
    -- Another attempt to find duplicate values
    --  Without Location ID many duplicates
    select * from location;
    select Country , City , State ,Postal_code , Region , count(*) as cnt
    from location
    group by Country , City , State ,Postal_code , Region
    having count(*)>1;
    
    -- With Location ID no duplicates are the findings
    
    -- trying to use case when in the temp table
    
    select *
    from temp_tablebi5;
    
    select case when profit> 0 then 'Good' 
				when profit >1000 then ' Very Good'
				when profit <0 then 'Bad'
                when profit = 0 then 'no change' end as Indicator , profit
	from temp_tablebi5;
    
    
    -- use of Null if
    
    select * , nullif(state ,'Kentucky') as KFC
    from location;
    
    
    -- use of Coalesce
    
select * , coalesce( state, 'Kentucky') as LFC 
from location;

--  use of distinct and counting total states in data

select count(distinct state)
from temp_tablebi5;

select * from temp_tablebi5;

-- Use of window functions to calculate running total of profit
select  Order_ID, Customer_ID , Profit ,Row_ID, sum(profit) over ( order by Row_ID) as running_total_profit
from temp_tablebi5;

-- Use of window functions to calculate running total of Sales
select  Order_ID, Customer_ID , Sales ,Row_ID, sum(sales) over ( order by Row_ID) as running_total_sales
from temp_tablebi5
;
-- pivot data to show profit within each category

select *,(case when category = 'Furniture' then profit end ) as 'Furniture',
(case when category = 'Office Supplies' then profit end ) as 'Office Supplies',
(case when category = 'Technology' then profit end ) as 'Technology'
from temp_tablebi5;

select * from temp_tablebi5;

-- Calculating Delta of Profit	wrt previous row

select * , profit - lag(profit,1) over (order by Row_ID) as delta
from temp_tablebi5;

-- Calculating Delta of Profit	wrt next row

 select * , profit - lead(profit,1) over (order by Row_ID) as delta
from temp_tablebi5;

-- date transformations and manipulation
describe temp_tablebi5;

with cte_1 as (
select distinct state from location where state IN ('Texas' , 'California')
),

cte_2 as (
select avg(profit) as avgprofit , Order_Date
from temp_tablebi5
where date_format(str_to_date( Order_Date, '%m/%d/%y'), '%m-%y') between '01-19' and '01-20'
)

select Row_id , Order_Date , Profit ,Order_ID, State from temp_tablebi5 where state in ( select  distinct state from cte_1)
and Order_Date in (Select Order_Date from cte2) ;



    