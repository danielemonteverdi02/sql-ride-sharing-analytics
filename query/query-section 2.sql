/* Section 2 */

/* In this section I extend basic SQL usage by combining multiple tables using JOIN and by applying GROUP BY with HAVING for grouped filtering. 
   I also use scalar and derived subqueries for intermediate aggregations, together with conditional logic (CASE WHEN) for custom categorizations. 
   Date and time functions such as STRFTIME and JULIANDAY are used to aggregate and slice data by time periods. */

/* I1 · What is the average total_fare per payment_method? */

SELECT t.payment_method, ROUND(AVG(t.total_fare), 2) AS avg_total_fare
FROM trips t 
WHERE t.status = 'completed'
GROUP BY t.payment_method;

/* I2 · Which city has the most registered users? */

SELECT u.city, COUNT(*) AS total_users
FROM users u 
GROUP BY u.city 
ORDER BY total_users DESC
LIMIT 1;

/* I3 · Find the top 5 drivers by total number of completed trips */

SELECT t.driver_id, COUNT(*) AS n_completed_trips
FROM trips t 
WHERE t.status = 'completed'
GROUP BY t.driver_id 
ORDER BY n_completed_trips DESC
LIMIT 5;

/* I4 · What is the total revenue (sum of total_fare) per month? */

SELECT STRFTIME('%Y-%m', t.requested_at) AS period, SUM(t.total_fare) AS revenue
FROM trips t 
WHERE t.status = 'completed'
GROUP BY period
ORDER BY period;

/* I5 · How many trips does each rider have on average? */

WITH n_trips_rider AS(
	SELECT t.rider_id, COUNT(*) AS n_trips
	FROM trips t 
	GROUP BY t.rider_id) 

SELECT ROUND(AVG(n_trips), 2) AS avg_trips
FROM n_trips_rider;

/* I6 · Find all drivers who have never received a rating below 3 */

SELECT r.reviewee_id, d.user_id
FROM reviews r
INNER JOIN drivers d ON r.reviewee_id = d.user_id
GROUP BY r.reviewee_id, d.user_id
HAVING MIN(r.rating) >= 3;

/* I7 · Which pickup zone generates the most revenue? */

SELECT t.pickup_location_id, l.city, SUM(t.total_fare) AS total_revenue
FROM trips t 
INNER JOIN locations l ON t.pickup_location_id = l.location_id 
GROUP BY t.pickup_location_id, l.city 
ORDER BY total_revenue DESC
LIMIT 1;

/* I8 · What percentage of trips were cancelled? */

SELECT
  	   100 * SUM(
  			     CASE WHEN status = 'cancelled' THEN 1 
  			     ELSE 0 
  			     END) / COUNT(*) AS cancelled_percentage
FROM trips;

/* I9 · List riders who have spent more than $500 in total fares */

SELECT t.rider_id, SUM(t.total_fare) AS tot_fare
FROM trips t 
GROUP BY t.rider_id 
HAVING tot_fare > 500;

/* I10 · Find the average trip duration per zone_type */

SELECT l.zone_type, ROUND(AVG(t.duration_mins), 2) AS avg_trip_duration
FROM trips t 
INNER JOIN locations l ON t.pickup_location_id = l.location_id
GROUP BY l.zone_type;

/* I11 · Which drivers cancelled the most trips? */

SELECT d.driver_id, COUNT(*) AS n_cancelled_trips
FROM drivers d 
INNER JOIN trips t ON d.driver_id = t.driver_id 
WHERE t.status = 'cancelled'
GROUP BY d.driver_id
ORDER BY n_cancelled_trips DESC;

/* I12 · What is the surge multiplier distribution? (buckets: 1.0, 1.0–1.5, 1.5–2.0, 2.0+) */

SELECT 
	 CASE 
		 WHEN t.surge_multiplier <= 1 THEN '1'
	 	 WHEN t.surge_multiplier > 1 AND t.surge_multiplier <= 1.5 THEN '1-1.5'
	 	 WHEN t.surge_multiplier > 1.5 AND t.surge_multiplier <= 2 THEN '1.5-2'
	 	 ELSE '2+' 
	 	 END AS SurgeMulti_distib,
	 COUNT(*) AS freq
FROM trips t
GROUP BY SurgeMulti_distib;

/* I13 · Find all riders who have taken trips in more than one city */

SELECT t.rider_id
FROM trips t
INNER JOIN locations l ON t.pickup_location_id = l.location_id
GROUP BY t.rider_id
HAVING COUNT(DISTINCT l.city) > 1;

/* I14 · What is the average wait time (minutes between requested_at and started_at) per city? */

SELECT l.city, ROUND(AVG((JULIANDAY(t.started_at) - JULIANDAY(t.requested_at)) * 1440), 2) AS avg_wait_time
FROM trips t 
INNER JOIN locations l ON t.pickup_location_id = l.location_id 
GROUP BY l.city;

/* I15 · Which vehicle make is most common among active drivers? */

SELECT d.vehicle_make, COUNT(*) AS freq
FROM drivers d 
WHERE d.is_active = 1
GROUP BY d.vehicle_make
ORDER BY freq DESC
LIMIT 1;

/* I16 · Find drivers who have both completed trips and cancellations in the same month */

WITH completed_months AS (
    SELECT t.driver_id, STRFTIME('%Y-%m', completed_at) AS month
    FROM trips t
    WHERE status = 'completed'
    GROUP BY t.driver_id, month),
	
    cancelled_months AS (
    SELECT t.driver_id, STRFTIME('%Y-%m', c.cancelled_at) AS month
    FROM cancellations c
    JOIN trips t ON t.trip_id = c.trip_id
    GROUP BY t.driver_id, month)

SELECT cm.driver_id, cm.month
FROM completed_months cm
JOIN cancelled_months ca ON ca.driver_id = cm.driver_id AND ca.month = cm.month
ORDER BY cm.month;

/* I17 · What is the total refunded amount per month? */

SELECT STRFTIME('%Y-%m', p.paid_at) AS month, SUM(p.amount) AS total_refunded_amount
FROM payments p 
WHERE p.status = "refunded"
GROUP BY month
ORDER BY month;

/* I18 · Show the cancellation rate per cancellation reason */

SELECT reason, COUNT(*) AS count, ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM cancellations), 2) AS pct 
FROM cancellations 
GROUP BY reason 
ORDER BY count DESC;

/* I19 · Which riders have never left a review after any of their trips? */

SELECT r.rider_id
FROM riders r 
LEFT JOIN reviews r2 ON r.rider_id = r2.reviewer_id 
WHERE r2.review_id IS NULL;

/* I20 · Find the busiest hour of the day by number of trip requests */

SELECT STRFTIME('%H', t.requested_at) AS hour, COUNT(*) AS n_trip_request
FROM trips t 
GROUP BY hour
ORDER BY n_trip_request DESC
LIMIT 1;

/* I21 · For each driver, show their total earnings and number of trips in a single query */

SELECT t.driver_id, SUM(t.total_fare) AS total_earning, COUNT(*) AS total_trips
FROM trips t 
WHERE t.status = 'completed'
GROUP BY t.driver_id;

/* I22 · Which zone pair (pickup → dropoff) is the most frequent route? */

SELECT t.pickup_location_id, t.dropoff_location_id, COUNT(*) AS freq
FROM trips t 
GROUP BY t.pickup_location_id, t.dropoff_location_id
ORDER BY freq DESC
LIMIT 1;
