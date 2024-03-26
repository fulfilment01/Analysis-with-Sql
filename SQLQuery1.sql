-- select COUNT(Address) as adscount
-- from Eccomerce.dbo.[Ecommerce Purchases]
-- where Address is null;

-- select round(MAX(Eccomerce.dbo.[Ecommerce Purchases].Purchase_Price), 2) as maxpprice
-- from Eccomerce.dbo.[Ecommerce Purchases];

-- select round(MIN(Eccomerce.dbo.[Ecommerce Purchases].Purchase_Price), 2) as minpprice
-- from Eccomerce.dbo.[Ecommerce Purchases];

-- select round(AVG(Purchase_Price), 2) as Avrpprice
-- from [Ecommerce Purchases];

-- select * 
-- from [Ecommerce Purchases]
-- where Language = 'fr' ;

-- select count(LANGUAGE) as 'no of people that speaks french'
-- from [Ecommerce Purchases]
-- where Language = 'fr' ;

--create FULLTEXT CATALOG Mycatalog;
--create unique index IX_CC on [Ecommerce Purchases](Credit_Card);

--select * 
--from [Ecommerce Purchases]
--where Job COLLATE Latin1_General_CI_AI like '%engineer%';
-- this will return case insensitive

--select * 
--from [Ecommerce Purchases]
--where Job like '%engineer%';
-- this is case sensitive

--select * 
--from [Ecommerce Purchases]
--where IP_Address = '132.207.160.22';

-- select count(CC_Provider) as cc_provider_count
--from Eccomerce.dbo.[Ecommerce Purchases]
--where Purchase_Price > 50 and CC_Provider = 'Mastercard' ;

-- select * from Eccomerce.dbo.[Ecommerce Purchases];

--select Email 
--from [Ecommerce Purchases]
--where Credit_Card = 4664825258997302;

--select AM_or_PM, count(*) as AM_PM_Count
--from [Ecommerce Purchases]
-- group by AM_or_PM;


--alter table Eccomerce.dbo.[Ecommerce Purchases]
--alter column CC_Exp_Date DATE;

--alter table Eccomerce.dbo.[Ecommerce Purchases]
--add New_Year_column int

--UPDATE Eccomerce.dbo.[Ecommerce Purchases]
--SET New_Year_column = YEAR(CC_Exp_Date);

-- select * from Eccomerce.dbo.[Ecommerce Purchases]
-- where New_Year_column = 1900;

-- select * from Eccomerce.dbo.[Ecommerce Purchases];

-- Top 5 Most Popular Email Providers (e.g. gmail.com, yahoo.com, etc...)

--select top 5 value,
--COUNT(*) as "Count" 
--from(
--	select value
--	from Eccomerce.dbo.[Ecommerce Purchases]
--	CROSS APPLY STRING_SPLIT(Email, '@')
--) AS SPLITED_VALUES
--GROUP BY value
--order by count desc;