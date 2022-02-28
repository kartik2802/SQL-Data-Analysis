
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