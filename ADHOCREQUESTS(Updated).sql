/*
LIST OF PRODUCTS WITH A BASE PRICE GREATER THAN 500 and FEATURED IN PROMO "BOGOF"


SELECT DISTINCT(p.product_name), e.base_price, e.promo_type FROM dim_products p RIGHT JOIN fact_events e
ON p.product_code = e.product_code
WHERE e.base_price>500 AND e.promo_type LIKE '%BOGOF%'

*/

/*
NUMBER OF STORES IN EACH CITY

SELECT city, COUNT(store_id) as Number_of_Stores FROM dim_stores
GROUP BY city
ORDER BY Number_of_Stores DESC

*/

/* 

Report that generates each campaign along with total revenue generated before and after the campaign 

SELECT campaign_id, ROUND(SUM(Revenue_BeforePromo)/1000000,2) as Revenue_Before_Promo_in_Mil,
ROUND(SUM(Revenue_AfterPromo)/1000000,2) as Revenue_After_Promo_in_Mil
FROM fact_events
GROUP BY campaign_id


*/


/* 
REPORT THAT CALCULATES INCREMENTAL SOLD QUANTITY (ISU) % FOR EACH CATEGORY IN DIWALI CAMPAIGN 

WITH CTE1 AS (
SELECT p.category, AVG(ROUND((fe.ISU/fe.`quantity_sold(before_promo)`)*100,2)) as ISU_PCT
FROM dim_products p JOIN fact_events fe ON p.product_code = fe.product_code
WHERE fe.campaign_id = 'CAMP_DIW_01' GROUP BY p.category
)
SELECT *, RANK() OVER(ORDER BY ISU_PCT DESC) as Ranking FROM CTE1

*/

/*
REPORT FEATURING TOP 5 PRODUCTS RANKED BY INCREMENTAL REVENUE PERCENTAGE ACROSS ALL CAMPAIGNS


WITH CTE1 AS (
SELECT p.product_name, p.category, fe.campaign_id, ROUND((fe.IR/fe.Revenue_BeforePromo)*100,2) as IR_PCT
FROM dim_products p JOIN fact_events fe
ON p.product_code = fe.product_code
)
SELECT *, ROW_NUMBER() OVER (ORDER BY IR_PCT DESC) as Ranking FROM CTE1 LIMIT 5

*/
