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

select * from temp_tablebi5;