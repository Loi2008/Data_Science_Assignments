set search_path to business;
create schema international_debt;

set search_path to international_debt;

create table international_debt_analysis (
country_name varchar (100),
country_code varchar (20),
indicator_name text,
indicator_code varchar (20),
debt numeric
);

select * from international_debt_analysis;

-- 1. The Total Amount of Debt Owed
select sum(debt) as total_debt 
from international_debt_analysis;

-- The Total Amount of Debt Owed is 2,823,893,300,273

-- 2. Total number of distinct countries
select count(distinct country_name) as distinct_country 
from international_debt_analysis; 

-- Total number of distinct countries is 125

-- 3. List of distinct indicator code
select distinct indicator_code, indicator_name
from international_debt_analysis
where indicator_name is not null
and indicator_name <> ''
and indicator_code is not null
and indicator_code <> '';

-- there is a total of 25 distinct indicator names

-- 4. Country with Highest Total Debt, and the Amount
select country_name, sum(debt) as total_debt
from international_debt_analysis
where country_name is not null
and country_name <> ''
group by country_name
order by total_debt desc
limit 1;

-- The county is China	with the debt of  283,748,948,518

-- 5. The Average Debt Across Different Debt Indicators
select indicator_name, AVG(debt) AS avg_debt
from international_debt_analysis
group by indicator_name
order by avg_debt desc;

-- 6. Country with Highest Principal Repayment
select country_name, SUM(debt) AS total_principal_repayment
from international_debt_analysis
where indicator_name like '%Principal repayment%' and debt> 0
group by country_name
order by total_principal_repayment desc
limit 1;

-- The county is China with the principal repayment amount of 168,611,607,050

-- 7. Most Common Debt Indicator 
select indicator_name, COUNT(*) AS frequency
from international_debt_analysis
where indicator_name is not null
and indicator_name <> ''
group by indicator_name
order by frequency desc
limit 1;

-- the most common debt indicator is PPG, official creditors (AMT, current US$)	with a total of 124

-- 8.1 Five countries with the most debt
select country_name, sum(debt) as total_debt
from international_debt_analysis
group by country_name
order by total_debt desc
limit 5;

-- 8.2 Five countries with the least debt
select country_name, sum(debt) as total_debt
from international_debt_analysis
where debt> 0 
group by country_name
order by total_debt asc
limit 5;

-- 8.3 Number of countries with 0 or missing debt values
select count(distinct country_name) as countries_with_zero_or_missing_debt
from international_debt_analysis
where debt is null or debt = 0;

-- the number is 110