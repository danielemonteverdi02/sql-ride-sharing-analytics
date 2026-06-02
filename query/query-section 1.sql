/* Section 1 */

/* In this section I use the core SQL building blocks for data exploration, including SELECT to extract data, WHERE to filter rows, 
   ORDER BY and LIMIT to sort and restrict results, and DISTINCT to obtain unique values. 
   I also apply basic aggregation functions such as COUNT and MIN, together with simple grouping via GROUP BY and filtering of aggregated results using HAVING. 
   In addition, I use date handling with STRFTIME. */


/* B1 · List the first 10 trips ordered by requested_at */

SELECT t.*
FROM trips t 
ORDER BY t.requested_at ASC
LIMIT 10;

/* B2 · How many total users are in the database? */

SELECT COUNT(*) AS total_users 
FROM users u;

/* B3 · Show all trips with a surge_multiplier greater than 2.0 */

SELECT *
FROM trips t 
WHERE t.surge_multiplier > 2.0;

/* B4 · List all drivers who are currently inactive */

SELECT *
FROM drivers d 
WHERE d.is_active = 0;

/* B5 · What are the distinct payment methods used? */

SELECT DISTINCT p."method" 
FROM payments p;

/* B6 · Show all trips that were cancelled */

SELECT *
FROM trips t 
WHERE t.status = 'cancelled';

/* B7 · Find all riders who joined in 2023 */

SELECT *
FROM riders r 
WHERE STRFTIME('%Y', r.created_at) = '2023'; 

/* B8 · Show the 5 most expensive trips by total_fare */

SELECT *
FROM trips t 
ORDER BY t.total_fare DESC
LIMIT 5;

/* B9 · List all zones of type 'airport' */

SELECT *
FROM locations l 
WHERE l.zone_type = 'airport';

/* B10 · How many trips were paid by cash? */

SELECT t.payment_method, COUNT(*) AS n_payments
FROM trips t
GROUP BY t.payment_method;

SELECT COUNT(*) AS n_payments
FROM trips t
WHERE t.payment_method = 'cash';

/* B11 · What is the longest trip by distance_km? */

SELECT *
FROM trips t 
ORDER BY t.distance_km DESC
LIMIT 1;

/* B12 · List all unique cities in the locations table */

SELECT DISTINCT l.city 
FROM locations l;

/* B13 · How many drivers joined after January 1, 2023? */

SELECT COUNT(*) AS n_driver
FROM drivers d 
WHERE d.join_date > '2023-01-01';

/* B14 · Find all payments that failed */

SELECT *
FROM payments p 
WHERE p.status = 'failed';

/* B15 · List trips that have no completed_at value */

SELECT *
FROM trips t 
WHERE t.completed_at IS NULL;

/* B16 · How many reviews have a rating of 5? */

SELECT COUNT(*) AS rating_5
FROM reviews r 
WHERE r.rating = 5;

SELECT r.rating, COUNT(*) AS rating_5
FROM reviews r
GROUP BY r.rating
HAVING r.rating = 5;

/* B17 · Show all cancellations made by riders */

SELECT *
FROM cancellations c 
WHERE c.cancelled_by = 'rider';

/* B18 · What is the shortest trip duration in the dataset? */

SELECT t.duration_mins 
FROM trips t 
ORDER BY t.duration_mins
LIMIT 1;

SELECT MIN(t.duration_mins) AS shortest_duration
FROM trips t;

/* B19 · List the 10 most recent reviews with their rating and comment */

SELECT r.review_id, r.rating, r.comment, r.reviewed_at  
FROM reviews r 
ORDER BY r.reviewed_at DESC
LIMIT 10;

/* B20 · How many active drivers have a rating above 4.5? */

SELECT COUNT(*) AS n_drivers
FROM drivers d 
WHERE d.is_active = 1 AND d.rating > 4.5;
