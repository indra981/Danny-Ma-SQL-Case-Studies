CSB - Data Analysis Question

--How many customers has Foodie-Fi ever had?
SELECT COUNT(DISTINCT customer_id) AS 'Distinct Customers'
FROM subscriptions;

--What is the monthly distribution of trial plan start_date values for our dataset 
SELECT MONTH(start_date),
       COUNT(DISTINCT customer_id) as 'monthly distribution'
FROM subscriptions s
JOIN plans p
ON s.plan_id = p.plan_id
WHERE plan_id=0
GROUP BY MONTH(start_date); 

--What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
SELECT plan_id,
       plan_name,
       COUNT(*) AS 'count of events'
FROM subscriptions
JOIN plans USING (plan_id)
WHERE YEAR(start_date) > 2020
GROUP BY plan_id;


--What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
WITH cte AS
  (SELECT plan_name,
          COUNT(DISTINCT customer_id) AS distinct_customer_count,
          SUM(CASE
                  WHEN plan_id=4 THEN 1
                  ELSE 0
              END) AS churned_customer_count
   FROM subscriptions
   JOIN plans USING (plan_id))
SELECT *,
       round(100*(churned_customer_count/distinct_customer_count), 2) AS churn_percentage
FROM cte;

--How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
WITH next_plan_cte AS
  (SELECT *,
          LEAD(plan_id, 1) OVER(PARTITION BY customer_id
                                ORDER BY start_date) AS next_plan
   FROM subscriptions),
     churners AS
  (SELECT *
   FROM next_plan_cte
   WHERE next_plan=4
     AND plan_id=0)
SELECT count(customer_id) AS 'churn after trial count',
       round(100 * COUNT(customer_id)/
               (SELECT count(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS 'churn percentage'
FROM churners;

--What is the number and percentage of customer plans after their initial free trial?
SELECT plan_name,
       COUNT(customer_id) customer_count,
       round(100 * COUNT(DISTINCT customer_id) /
               (SELECT COUNT(DISTINCT customer_id) AS 'distinct customers'
                FROM subscriptions), 2) AS 'customer percentage'
FROM subscriptions s
JOIN plans p
ON s.plan_id = p.plan_id
WHERE plan_name != 'trial'
GROUP BY plan_name
ORDER BY plan_id;

--What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
WITH latest_plan_cte AS
  (SELECT *,
          ROW_NUMBER() OVER(PARTITION BY customer_id
                            ORDER BY start_date DESC) AS latest_plan
   FROM subscriptions s
   JOIN plans p
   ON s.plan_id = p.plan_id
   WHERE start_date <='2020-12-31' )
SELECT plan_id,
       plan_name,
       COUNT(customer_id) AS customer_count,
       round(100*COUNT(customer_id) /
               (SELECT COUNT(DISTINCT customer_id)
                FROM subscriptions), 2) AS percentage_breakdown
FROM latest_plan_cte
WHERE latest_plan = 1
GROUP BY plan_id
ORDER BY plan_id;

--How many customers have upgraded to an annual plan in 2020?
WITH previous_plan_cte AS
  (SELECT *,
          LAG(plan_id, 1) OVER(PARTITION BY customer_id
                               ORDER BY start_date) AS previous_plan_id
   FROM subscriptions s
   JOIN plans p 
   ON s.plan_id = p.plan_id

SELECT c.plan_id, COUNT(customer_id) upgraded_plan_customer_count
FROM previous_plan_cte c
WHERE previous_plan_id<3
  AND plan_id=3
  AND YEAR(start_date) = 2020
GROUP BY c.plan_id;
  
--How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
WITH trial_plan_cte AS
  (SELECT *
   FROM subscriptions
   JOIN plans USING (plan_id)
   WHERE plan_id=0),
   
annual_plan_cte AS
  (SELECT *
   FROM subscriptions
   JOIN plans USING (plan_id)
   WHERE plan_id=3)
   
SELECT 
round(avg(datediff(annual_plan_cte.start_date, trial_plan_cte.start_date)), 2) AS avg_conversion_days
FROM trial_plan_cte
INNER JOIN annual_plan_cte USING (customer_id);


--How many customers downgraded from a pro monthly to a basic monthly plan in 2020?
WITH next_plan_cte AS
  (SELECT *,
          lead(plan_id, 1) over(PARTITION BY customer_id
                                ORDER BY start_date) AS next_plan
   FROM subscriptions
  )

SELECT COUNT(*) AS downgrade_count
FROM next_plan_cte
WHERE plan_id=2
  AND next_plan=1
  AND year(start_date);