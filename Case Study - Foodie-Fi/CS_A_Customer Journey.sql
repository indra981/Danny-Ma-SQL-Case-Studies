CSA - Customer Journey

--Requirements
Based off the 8 sample customers provided in the sample from the subscriptions table, write a brief description about each customer’s onboarding journey.

***

--Customer 1
SELECT customer_id,
       p.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN plans p 
ON s.plan_id = p.plan_id
WHERE customer_id =1;

--Observations
Customer started the free trial on August 1, 2020
Subscribed to the basic monthly during the seven day the trial period (on August 8, 2020)


--Customer 37
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =37;

--Observations
Customer started the free trial on August 5, 2020 
Subscribed to the basic monthly during the seven day the trial period (on August 12, 2020)
Upgraded to the pro monthly plan after 3 months (on November 11, 2020)


--Customer 73
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =62;

--Observations
Customer started the free trial on October 12, 2020
Subscribed to the basic monthly after the seven day the trial period (on October 19, 2020)
Subscription upgraded to the pro monthly plan after 3 months (January 2, 2021)
Cancelled the subscription after 1 month (Fabruary 23, 2021)


--Customer 87
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =87;


--Observations
Customer started the free trial on August 8, 2020
Subscribed to pro monthly after the seven day the trial period (on August 15, 2020)
Upgraded to the pro annual plan in September 2020


--Customer 99
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =99;

--Observations
Customer started the free trial on December 5, 2020
Subscription cancelled on the last day of the trial period.


--Customer 299
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =299;

--Observations
Customer started the free trial on January 10, 2020
Subscribed to the basic monthly plan during the seven day the trial period


--Customer 542
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =542;

--Observations
Customer started the free trial on April 7, 2020
Upgraded tl Pro Annual on seven day trail period (on Aprtl 14, 2020)
Subscription cancelled exactly after 1 year (on April 14, 2021)


--Customer 999
SELECT customer_id,
       s.plan_id,
       plan_name,
       start_date
FROM subscriptions s
JOIN Plans p
ON s.plan_id = p.plan_id
WHERE customer_id =999;

--Observations
Customer started the free trial on October 23, 2020
Upgraded tl Pro Monthly on October 30, 2020
Subscription cancelled on December 1, 2020
