create database SQLPROJECT;
use SQLPROJECT;
drop table merged_table;
rename table `sales table` to sales;
rename table `store location` to  saleslocation;
rename table `sales team` to salesteam;
alter table salesteam 
rename column `Sales Team` to SalesTeam;
alter table sales
rename column `Product Categories` to product_category;
alter table salesteam
drop column MyUnknownColumn,
drop column `MyUnknownColumn_[0]`, drop column `MyUnknownColumn_[1]`,
drop column `MyUnknownColumn_[2]`, drop column `MyUnknownColumn_[3]`,
drop column `MyUnknownColumn_[4]`, drop column `MyUnknownColumn_[5]`,
drop column `MyUnknownColumn_[6]`, drop column `MyUnknownColumn_[7]`,
drop column `MyUnknownColumn_[8]`, drop column `MyUnknownColumn_[9]`, drop column `MyUnknownColumn_[10]`,
drop column `MyUnknownColumn_[11]`, drop column `MyUnknownColumn_[12]`, drop column `MyUnknownColumn_[13]`,
drop column `MyUnknownColumn_[14]`, drop column `MyUnknownColumn_[15]`, drop column `MyUnknownColumn_[16]`;
select s.`Order Number`, s.`Sales Date`, s.`Sales Channel`, s.Currency, s.Population, s.Median_Income,
s.`Order qty`, s.`Product Categories`, s.`unit price`, s.`unit cost`, st.SalesTeam, sl.name, sl.county,
sl.state, p.`Product Name`
from sales as s 
left join salesteam as st on s.Salesteamindex= st.Index
left join saleslocation as sl on s.Storeindex= sl.id
left join products as p on s.Productindex= p.Index;

select SalesTeam, ROUND(SUM(`unit price`* `Order qty`), 2) as Maximum_Sales from merged_table
group by SalesTeam
order by Maximum_Sales DESC
limit 5;

select SalesTeam, `unit cost`, `Order qty`, round(`unit cost`* `Order qty`, 2) as Total_cost from merged_table;

select `Product Categories`, round(sum(`unit price`* `Order qty`), 2) as Revenew from merged_table
group by `Product Categories`
order by Revenew DESC
limit 5;

-- Without a proper analysis, i will always have issue with my sales, you are hereby charged with the
-- responsibility of analyzing the revenue of each sales, each product, revenue generated by each sales team
-- The most sold product, total number of products sold, Sales team of each year.

select `Product Categories`,
count(`Product Name`) as Sold_Product
from merged_table
group by `Product Categories`
order by Sold_Product DESC;

select SalesTeam,
sum(profit) as `each sales team profit`
from merged_table
group by SalesTeam
order by `each sales team profit` DESC;


select `Product Name`,
count(`Product Name`) as Product_sold
from merged_table
group by `Product Name`
order by Product_sold DESC
limit 5;

ALTER TABLE merged_table
ADD COLUMN date_column DATE;
ALTER TABLE merged_table
ADD COLUMN profit int;
update merged_table 
set profit = ((`unit price`* `Order qty`) - (`unit cost` * `Order qty`));


SET SQL_SAFE_UPDATES = 0;
UPDATE merged_table 
SET date_column = STR_TO_DATE(`Sales Date`, '%d/%m/%Y') ;
ALTER TABLE merged_table
DROP COLUMN `Sales Date`;


select year(date_column) as sales_month, SalesTeam,
round(sum(`unit price` * `Order qty`), 2) as total_sales
from merged_table
group by sales_month, SalesTeam
order by sales_month, total_sales DESC;


select month(date_column) as sales_month, SalesTeam,
round(sum(`unit price` * `Order qty`), 2) as total_sales
from merged_table
group by sales_month, SalesTeam
order by sales_month, total_sales DESC; 

-- I will like to know which month do we have the best sales, which month do we have a down time, 
-- which year is supposed to be our best year, which year is not supposed to be in our calender
-- In addition, we have different type of categories of products, which category do we earn more? 
-- and which category do we earn least? what is the total product sales by category? what is the profit made in each category?
-- Do you think that we should keep selling all our products? 

select *
from best_sales_team_of_each_month
where  total_sales = (select max(total_sales) as monthly_max_sales from best_sales_team_of_each_month);

select sales_month,
round(sum(total_sales), 2) as total_monthly_sales
from  best_sales_team_of_each_month
group by sales_month
order by total_monthly_sales DESC;
-- this will show us the month with the lowest and highest sales

select `Product Categories`,
sum(profit) as category_profit
from merged_table
group by `Product Categories`
order by category_profit DESC;
-- from the above we earned the most on DECORATIVES product category
-- We earned least from SPORTS product categories
-- the total sales of each product category is showed in our revenew table
-- table category_profit
-- since we have a good profit margin to the cost i will advise to keep selling every product


-- We have different stores in different location, which one do you advise that we should shutdown?
-- which one do you think gives us more profit? Kindly produce a table that shows total number of sales by store location,
-- total cost of sales by location, Revenue by location, Profit made in each location.
-- Based on your results and findings, kindly draw and insight from the data, conclude and make recommendations.

select state,
sum(profit) as `state profit`
from merged_table
group by state
order by `state profit` DESC;

select state,
round(sum(`unit cost` * `Order qty`),2) as `states cost`
from merged_table
group by state
order by `states cost` DESC;

select state,
round(sum(`unit price` * `Order qty`), 2) as `state Revenue`,
round(sum((`unit price` * `Order qty`)-(`unit cost` * `Order qty`)), 2) as `profit per state`,
round(sum(`unit cost` * `Order qty`),2) as `states cost`,
count(`unit price`) as `number of sales per location`
from merged_table
group by state
order by `state Revenue` DESC;

-- after a long scrutiny of the dataset i was able to see that ARKANSAS has a very low profit due to the unit cost of each product
-- based on this i will advise the complany to close production in this location
-- CALIFONIA is yielding the highest profit based on the sales_table_based_on_location

-- from the dataset i was able to know the team with the highest profit, teams that are performing and teams that are underperforming
-- the best location and the location with less yield and the months where we earned the most

-- after proper analysis i will like to recomend that all the sales teams should kept cause the difference in their output is close
-- and the stores in ARKANSAS should be closed based on the low yeld 
-- from the product category the spoting category should be drop cause of the profit is too small based on the unit cost of each 
-- product bought

