create database Apocolypse_store_and_sales;
use Apocolypse_store_and_sales;

select * from `apocolypse food prep - dax tutorial`;
select * from `apocolypse store`;

rename table `apocolypse food prep - dax tutorial` to apocolypse_Sales;
rename table `apocolypse store` to apocolypse_Store;

select * from apocolypse_Sales;
select * from apocolypse_Store;

-- max unit sold product

select `Product ID`, max(`Units Sold`)
from apocolypse_sales;

-- Top 5 unit sold products details list 

select *
from apocolypse_sales
order by `Units Sold` desc
limit 5;

-- distinct customers

select distinct Customer
from apocolypse_sales
order by Customer;

-- sales count per customers

select distinct Customer, count(`Order ID`) as sales_per_customres
from apocolypse_sales
group by Customer
order by count(`Order ID`) desc;

select * 
from apocolypse_sales;

-- update apocolypse_sales
-- set `Date Purchased`=str_to_date(`Date Purchased`,'%d-%m-%y');


select * from apocolypse_Store;

-- joined apocolypse_sales and apocolypse_store
-- store tada in new table created as  Apocolypse_Sales_Store

create table Apocolypse_Sales_Store as
select A.Customer,A.`Product ID`,B.`Product Name`,A.`Order ID`,A.`Units Sold`,B.Price,B.`Production Cost`,A.`Date Purchased`
from apocolypse_sales as A right join apocolypse_store as B
on A.`Product ID`=B.`Product ID`;

select * from apocolypse_sales_store;

-- heigh profitable product

select distinct `Product ID`,`Product Name`, (Price-`Production Cost`) as profit_on_products
from apocolypse_sales_store
order by profit_on_products desc
limit 1;

-- Top sales products

select `Product ID`,`Product Name`,sum(`Units Sold`),Price, round(sum(`Units Sold`*Price),2)  as sales,
round(sum(Price-`Production Cost`)*`Units Sold`,2) as profit_on_sales
from apocolypse_sales_store
group by `Product ID`
order by sales desc;

-- Top 5 heigher profit by products

select `Product ID`,`Product Name`,sum(`Units Sold`),Price, round(sum(`Units Sold`*Price),2)  as sales,
round(sum(Price-`Production Cost`)*`Units Sold`,2) as profit_on_sales
from apocolypse_sales_store
group by `Product ID`
order by profit_on_sales desc
limit 5;

-- Top product sales rank per customers

select Customer,`Product ID`,`Product Name`, round(sum(`Units Sold`*Price),2)  as sales, 
dense_rank() over (partition by Customer order by round(sum(`Units Sold`*Price),2) desc)
from  apocolypse_sales_store
group by `Product ID`;




