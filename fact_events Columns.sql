SELECT * FROM retail_events_db.fact_events;

ALTER TABLE fact_events ADD COLUMN Revenue_BeforePromo int;

UPDATE fact_events SET Revenue_BeforePromo = base_price * `quantity_sold(before_promo)`;

ALTER TABLE fact_events ADD COLUMN discount_price int;

UPDATE fact_events SET discount_price = base_price * 0.5 WHERE promo_type = '50% OFF';
UPDATE fact_events SET discount_price = base_price * 0.75 WHERE promo_type = '25% OFF';
UPDATE fact_events SET discount_price = base_price * 0.67 WHERE promo_type = '33% OFF';
UPDATE fact_events SET discount_price = base_price - 500 WHERE promo_type = '500 Cashback';
UPDATE fact_events SET discount_price = base_price * 0.5 WHERE promo_type = 'BOGOF';

ALTER TABLE fact_events ADD COLUMN Revenue_AfterPromo int;
UPDATE fact_events SET Revenue_AfterPromo = `quantity_sold(after_promo)` * discount_price; 

UPDATE fact_events SET `quantity_sold(after_promo)` = `quantity_sold(after_promo)`*2 WHERE promo_type = 'BOGOF';

ALTER TABLE fact_events ADD COLUMN IR int;
ALTER TABLE fact_events ADD COLUMN ISU int;
UPDATE fact_events SET IR =Revenue_AfterPromo - Revenue_BeforePromo ; 
UPDATE fact_events SET ISU = `quantity_sold(after_promo)` - `quantity_sold(before_promo)`; 


UPDATE fact_events SET `quantity_sold(after_promo)` = `quantity_sold(after_promo)` * 2 WHERE promo_type = 'BOGOF';
