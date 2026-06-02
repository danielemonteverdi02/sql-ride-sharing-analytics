/* Section 3 */

/* In this section I use SQL window functions to perform advanced analytics without collapsing the data, 
   including ROW_NUMBER(), LAG(), SUM() OVER, AVG() OVER, and RANK() 
   to compute rankings, running totals, rolling averages, and comparisons with previous records. */

/* A1 · Most recent trip for each driver */

WITH recent_trip AS (
	SELECT t.driver_id, t.completed_at,
		   ROW_NUMBER() OVER(PARTITION BY t.driver_id ORDER BY t.completed_at DESC) AS r_trips
	FROM trips t 
	WHERE t.status = 'completed')

SELECT rt.driver_id, rt.completed_at
FROM recent_trip rt
WHERE rt.r_trips = 1;

/* A2 · Time between consecutive trips per driver */

SELECT t.driver_id, t.completed_at,
    LAG(t.completed_at) OVER (PARTITION BY t.driver_id ORDER BY t.completed_at) AS previous_trip,
    ROUND(JULIANDAY(t.completed_at) - JULIANDAY(LAG(t.completed_at) OVER (PARTITION BY t.driver_id ORDER BY t.completed_at)), 0) AS days_between_trips
FROM trips t 
WHERE t.status = 'completed';

/* A3 · Cumulative earnings */

SELECT t.driver_id, t.completed_at, t.total_fare,
	   SUM(t.total_fare) OVER(PARTITION BY t.driver_id ORDER BY t.completed_at) AS cumulative_fare
FROM trips t 
WHERE t.status = 'completed';

/* A4 · Rank drivers by revenue */

WITH total_revenue_generated AS (SELECT t.driver_id, SUM(t.total_fare) AS total_revenue
								 FROM trips t 
								 WHERE t.status = 'completed'
								 GROUP BY t.driver_id)
								 
SELECT trg.driver_id, trg.total_revenue,
	   RANK() OVER(ORDER BY trg.total_revenue DESC) AS rank_revenue
FROM total_revenue_generated trg;

/* A5 · Calculate a 7-day rolling average of daily trip count */

SELECT giorno, n_trips, 
    AVG(n_trips) OVER (ORDER BY giorno ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7day_avg
FROM(
     SELECT STRFTIME('%Y-%m-%d', t.completed_at) AS giorno, COUNT(*) AS n_trips
     FROM trips t 
     WHERE t.status = 'completed'
     GROUP BY giorno) AS daily_trips;

/* A6 · Average fare of the last 3 trips per driver */

WITH ranked AS (
	SELECT t.driver_id, t.total_fare,
        ROW_NUMBER() OVER (PARTITION BY t.driver_id ORDER BY t.completed_at DESC) AS rn
    FROM trips t
    WHERE t.status = 'completed'),
    
    last_3 AS (
    SELECT driver_id, total_fare
    FROM ranked
    WHERE rn <= 3)
    
SELECT driver_id, AVG(total_fare) AS avg_last_3_trips
FROM last_3
GROUP BY driver_id;

/* A7 · Most expensive trip per rider */

WITH rank_rider_fare AS (
	SELECT t.rider_id, t.trip_id, t.completed_at, t.total_fare,
	       DENSE_RANK() OVER(PARTITION BY t.rider_id ORDER BY t.total_fare DESC) AS rank_fare
	FROM trips t
	WHERE t.status = 'completed')

SELECT rrf.rider_id, rrf.trip_id, rrf.completed_at, rrf.total_fare
FROM rank_rider_fare rrf
WHERE rrf.rank_fare = 1;
