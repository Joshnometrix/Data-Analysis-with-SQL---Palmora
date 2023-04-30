
/* Introduction
From the international breweries data recorded for a duration of three years, you are
directed to do the following analyses to aid better decision making in order to maximize
profit and reduce loss to the lowest minimum.
*/

-- selecting database --
use brewery;

-- Having a quick view of our table - interbrew --
select * from interbrew;

-- Profit Analysis --
-- To calculate profit by brand --
select brands, 
	sum(profit) as total_profit 
from interbrew
group by brands
order by total_profit desc;

-- Total Profit --
select sum(profit) as total_profit 
from interbrew;

-- Total Profit by Territory --
select territory, 
	sum(profit) as total_profit 
from interbrew
group by territory;

-- Country that generated the highest profit in 2019 --
select year, 
	country, 
    sum(profit) as total_profit 
from interbrew
where year = 2019
group by country
order by total_profit desc
limit 1;

-- The year with the highest profit --
select year, 
	sum(profit) as Total_Profit 
from interbrew
group by year
order by total_profit desc
limit 1;

-- Which month in the three years was the least profit generated? --
select month, 
	sum(profit) as profit 
from interbrew
group by month
order by profit
limit 1;

-- Minimum profit in the month of December 2018? --
select month, 
	year, profit as min_profit 
from interbrew
where month = "Dec" and year = 2018
order by profit
limit 1;

-- Updating the interbrew table by adding a new column (monthNum) for sorting by month --
/* alter table interbrew
add column monthNum int;

update interbrew
set monthNum = CASE
    WHEN month="Jan" THEN 1
    WHEN month="Feb" THEN 2
    WHEN month="Mar" THEN 3
    WHEN month="Apr" THEN 4
    WHEN month="May" THEN 5
    WHEN month="Jun" THEN 6
    WHEN month="Jul" THEN 7
    WHEN month="Aug" THEN 8
    WHEN month="Sep" THEN 9
    WHEN month="Oct" THEN 10
    WHEN month="Nov" THEN 11
    ELSE 12
END;
*/

-- Comparing the profit in percentage for each of the month in 2019 --
select month, 
	monthNum, 
	sum(profit) as Monthly_profit,
    round((sum(profit)/(select sum(profit) 
		from interbrew where year = 2019)) *100, 2) as Percentage
from interbrew
where year = 2019
group by month, monthNum
order by monthNum;

-- brand generated the highest profit in Senegal --
select brands, 
	sum(profit) as totalprofit 
from interbrew
where country = 'Senegal'
group by brands
order by totalprofit desc
limit 1;

-- BRAND ANALYSIS --
-- the top three brands consumed in the francophone countries in the last two years--

select brands, 
	sum(quantity) as total_quantity 
from interbrew
where year in (2018, 2019) and territory = 'Francophone'
group by brands
order by total_quantity desc
limit 3;


-- the top two choice of consumer brands in Ghana --
select country, 
	brands, 
    sum(quantity) as quantity_sold 
from interbrew
where country = 'Ghana'
group by country, brands
order by quantity_sold desc
limit 2;


-- Details of beers consumed in the past three years in the most oil rich country in West Africa --
select country, 
	brands, 
	sum(quantity) as total_quantity, 
	sum(profit) as total_profit 
from interbrew
where country = 'Nigeria'
group by country, brands
order by 3 desc;

-- Favorite malt brand in Anglophone region between 2018 and 2019 --

select territory, 
	brands, 
	sum(quantity) as quantity_sold 
from interbrew
where year in (2018, 2019) 
	and territory ='Anglophone' 
	and brands like ('%malt')
group by territory, brands
order by quantity_sold desc
limit 1;


-- brand that sold the highest in 2019 in Nigeria? --
select year, 
	country, 
	brands, 
	sum(quantity) as quantity_sold 
from interbrew
where year = 2019 and country = 'Nigeria'
group by year, country, brands
order by quantity_sold desc
limit 1;


-- Favorite brand in South_South region in Nigeria --
select country, 
	region, 
	brands, 
	sum(quantity) as quantity_sold
from interbrew
where country = 'Nigeria' and region = 'South South'
group by country, region, brands
order by quantity_sold desc
limit 1;


-- Beer consumption in Nigeria --
select country,
	 brands, 
	 sum(quantity) as quantity_sold 
from interbrew
where country = 'Nigeria' and brands not like ('%malt%')
group by country, brands
order by quantity_sold desc;

-- Consumption of Budweiser in the regions in Nigeria --
select country, 
	region, 
	brands, 
	sum(quantity) as quantity_sold 
from interbrew
where country = 'Nigeria' and brands = 'budweiser'
group by country, region, brands
order by quantity_sold desc;


-- Consumption of Budweiser in the regions in Nigeria in 2019 --
select year,
	brands, 
	region, 
	sum(quantity) as quantity_sold 
from interbrew
where country = 'Nigeria' and brands = 'Budweiser' and year = 2019
group by year, region, brands
order by quantity_sold desc;


-- COUNTRIES ANALYSIS --
-- Country with the highest consumption of beer --
select country, 
	brands, 
	sum(quantity) as quantity 
from interbrew
where brands not like ('%malt%')
group by country, brands
order by quantity desc
limit 1;

-- Highest sales personnel of Budweiser in Senegal --
select country, 
	brands, 
    sales_rep, 
	sum(quantity) as quantity 
from interbrew
where country ='Senegal' and brands = 'budweiser'
group by country, sales_rep, brands
order by quantity desc
limit 1;

-- Country with the highest profit of the fourth quarter in 2019 --
select year, 
	quarter, 
	country, 
	max(profit) as profit 
from interbrew
where year = 2019 and quarter = 4
group by country, quarter, year
order by profit desc
limit 1;

-- OR --

select year, 
	country, 
	max(profit) as profit 
from interbrew
where month in ('Oct', 'Nov', 'Dec') and year = 2019
group by year, country
order by profit desc
limit 1;

select brands, quantity, sum(quantity) over (partition by brands)
from interbrew;

-- Sales Rep --
select distinct sales_rep from interbrew;







































































































