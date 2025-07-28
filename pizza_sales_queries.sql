create table pizza_sales(
	pizza_id integer primary key,
 	order_id integer not null,
	pizza_name_id varchar(100),
	quantity int not null,
	order_date date not null, 
	order_time time,
	unit_price decimal(6,2),
	total_price decimal(8,2),
	pizza_size varchar(50),
	pizza_category varchar(50), 
	pizza_ingredients text,
	pizza_name varchar(50)
);
	
select * from pizza_sales;

--A. KPI’s
-- Total Revenue:

select sum(total_price) as Total_Revenue from pizza_sales;

--2. Average Order Value
select sum(total_price)/count(distinct(order_id)) as Avg_Order_Value from pizza_sales;

--3. Total Pizzas Sold
select sum(quantity) as total_Pizza_sold from  pizza_sales;

--4. Total Orders
select count(distinct(order_id)) as total_orders from pizza_sales

--5. Average Pizzas Per Order
select cast(cast (sum(quantity)as decimal(10,2))/
cast(count(distinct(order_id))as decimal(10,2))as decimal(10,2))
as Avg_pizza_per_order from pizza_sales;

--B. Daily Trend for Total Orders

select to_char(order_date,'Day') as order_day,
count(distinct(order_id)) as Total_order
from pizza_sales
group by to_char(order_date,'Day');

--C. Monthly Trend for Orders

select to_char(order_date,'Month') as Month_Name,
count(distinct(order_id)) as Total_order
from pizza_sales
group by to_char(order_date,'Month')
order by Total_order desc;


--D. % of Sales by Pizza Category
select pizza_category,sum(total_price ) as total_sales,
sum(total_price)*100/(select sum(total_price) from pizza_sales 
)
as PCT
from pizza_sales	
group by pizza_category;

--E. % of Sales by Pizza Size
select pizza_size,cast(sum(total_price) as Decimal(10,2)) as total_sales,cast(
sum(total_price)*100/(select sum(total_price) from pizza_sales)
as decimal(10,2))
as PCT
from pizza_sales
group by pizza_size
order by PCT desc;



--F. Top 5 Pizzas by Revenue

select pizza_name,sum(total_price) as total_revenu from pizza_sales 
group by pizza_name order by total_revenu desc
limit 5 ;

--G. Bottom 5 Pizzas by Revenue
select pizza_name,sum(total_price) as total_revenue from pizza_sales 
group by pizza_name order by total_revenue asc
limit 5 ;

--H. Top 5 Pizzas by Quantity
select pizza_name,sum(quantity) as total_quantity	 from pizza_sales 
group by pizza_name order by total_quantity desc
limit 5 ;

--I. Bottom 5 Pizzas by Quantity
select pizza_name,sum(quantity) as Total_quantity from pizza_sales 
group by pizza_name order by Total_quantity asc
limit 5 ;

--J. Top 5 Pizzas by Total Orders
select pizza_name,count(distinct(order_id)) as total_order from pizza_sales 
group by pizza_name order by Total_order desc
limit 5 ;

--K. Bottom 5 Pizzas by Total Orders
select pizza_name,count(distinct(order_id)) as total_order from pizza_sales 
group by pizza_name order by Total_order asc
limit 5 ;