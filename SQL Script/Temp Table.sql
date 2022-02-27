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
