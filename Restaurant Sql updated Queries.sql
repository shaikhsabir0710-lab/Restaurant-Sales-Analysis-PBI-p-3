         -----Restaurant Sales Analysis-----

-- Table Creations.

create table Restaurant(
Order_ID int primary key,
ord_Date date,
Product varchar(30),
Price decimal,
Quantity decimal ,
Purchase_Type varchar(20),
Payment_Method varchar(30),
Manager varchar(50),
City varchar(50)
)

-- Cleaning Parts.

--1.check duplicate values
with my as (select *,
dense_rank()over(partition by order_id,ord_date,product,price,quantity,purchase_type,payment_method,manager,city) as rnk
from restaurant)
select * from my where rnk>1


--2.check null values.

select * from restaurant
where order_id is null 
or ord_date is null
or product is null
or price is null
or quantity is null
or purchase_type is null
or payment_method is null
or manager is null
or city is null;

--3.data standardization.
---we update the manager column and remove leading space and trim it.
update restaurant set manager=trim(manager)

--Problems Statement

--1.what is the total Sales .
--2.what is total quantity sold.
--3.what is total Oroders.
--4.what is average total sales by each product.
--5.what is total sales by product.
--6.what is total sales by each payment methode.
--7.what is total sales by each purchase_type
--8.what is total sales by each manager.
--9.what is total quantity by each product.
--10.what is the total sales by product and city.

--Problem Solutions.

--1.what is the total Sales .
--select round(sum(price*quantity),2) as total_Sales from restaurant;

--2.what is total quantity sold.
--select round(sum(quantity),2) as quantity_sold from restaurant;

--3.what is total Oroders.
--select  count(*) as total_orders from restaurant 

--4.what is average total_sales by each product.

--with my as (select *,
--sum(price*quantity)over(partition by product) as total_sales from restaurant)
--select product,avg(total_sales) from my group by product 

--or
--select product,avg(total_sales) as avg_sale_per_product from(select *,
--sum(price*quantity)over(partition by product) as total_sales
--from restaurant) as my
--group by product;

--5.what is total sales by each product.

--select product,sum(price*quantity) as total_sales_by_product from restaurant 
--group by product order by total_sales_by_product desc;
--or
--with my as  (select product,price,quantity,
--sum(price*quantity)over(partition by product) as total_sales
--from restaurant)
--select product,total_sales from my 


--6.what is total sales by each payment methode.

--select payment_method,sum(price*quantity) as tota_sales from restaurant
--group by payment_method

--7.what is total sales by each purchase_type

--select purchase_type,sum(price*quantity) as total_sales_by_purchase_type from restaurant
--group by  purchase_type

--8.what is total sales top3 by each manager.

--select manager,sum(price*quantity) as total_sales_manager from restaurant
--group by manager order by total_sales_manager desc limit 3

--9.what is total quantity by each product.

--select product,sum(quantity) as quantity_sold from restaurant
--group by product order by quantity_sold desc;

--10.what is the total sales by product and city.

--select product,city,sum(price*quantity) as total_sales from restaurant 
--group by product,city order by total_sales desc ;
