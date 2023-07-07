-- Create the temporary table
CREATE TABLE temp_table(
    member_casual VARCHAR(255),
	rideable_type VARCHAR(255),
    num_of_ride INT,
    avg_ride_length_mins FLOAT
);
-- Populate the temporary table with calculated values
INSERT INTO temp_table( member_casual, rideable_type, num_of_ride, avg_ride_length_mins)
SELECT  member_casual, rideable_type, COUNT(*) AS num_of_ride, AVG(DATEDIFF(SECOND, started_at, ended_at))/60 AS avg_ride_length_mins
FROM GoogleCapstone..['202301-divvy-tripdata$']
GROUP BY member_casual, rideable_type;
-- Retrieve the data from the temporary table
SELECT * FROM temp_table;
-- Drop the temporary table when no longer needed
DROP TABLE temp_table;

-- AVG RIDE LENGTH AND TOTAL RIDE LENGTH BY MEMBER TYPE AND RIDEABLE TYPE
SELECT member_casual, rideable_type,
       num_of_ride,
       avg_ride_length_mins,
       num_of_ride * avg_ride_length_mins AS total_ride_length_hours
FROM (
    SELECT member_casual, rideable_type,
           COUNT(*) AS num_of_ride,
           AVG(DATEDIFF(SECOND, started_at, ended_at))/60 AS avg_ride_length_mins
    FROM ['202301-divvy-tripdata$']
    GROUP BY member_casual, rideable_type
) AS subquery;

-- MIN & MAX RIDE LENGTH BY MEMBER TYPE AND RIDEABLE TYPE
SELECT member_casual, rideable_type, min_ride_length_secs, max_ride_length_mins
FROM (
    SELECT member_casual, rideable_type, MIN(DATEDIFF(SECOND, started_at, ended_at)) AS min_ride_length_secs,
           MAX(DATEDIFF(SECOND, started_at, ended_at))/60 AS max_ride_length_mins
    FROM ['202301-divvy-tripdata$']
    GROUP BY member_casual, rideable_type
) AS subquery;

-- MOST FREQUENT DAY OF THE WEEK
SELECT TOP 1 day_of_week, count
FROM
(
    SELECT DATENAME(dw, started_at) AS day_of_week, COUNT(*) AS count
    FROM ['202301-divvy-tripdata$']
    GROUP BY DATENAME(dw, started_at)
) AS subquery
ORDER BY count DESC;

--NUM OF RIDE AND AVG RIDE LENGTH BY DAY OF THE WEEK
SELECT day_of_week, num_of_rides, avg_ride_length_mins
FROM
(
    SELECT COUNT(*) AS num_of_rides, DATENAME(dw, started_at) AS day_of_week, AVG(DATEDIFF(SECOND, started_at, ended_at))/60 AS avg_ride_length_mins
    FROM ['202301-divvy-tripdata$']
    GROUP BY DATENAME(dw, started_at)
) AS subquery
ORDER BY 2 DESC;
