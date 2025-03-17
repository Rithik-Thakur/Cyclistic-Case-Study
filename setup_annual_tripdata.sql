-- Joined q1,q2,q3 and q4 as 2024_annual_tripdata
-- this combination is only possible because we have same column name and data type
-- converted ride_length from time to interval
-- cleaned duplicate ride_id. ROW_NUMBER() OVER (PARTITION BY ride_id) AS row_num:Generates a unique row number for each ride_id to help identify and eliminate duplicates.

CREATE TABLE `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata` AS
WITH combined_data AS (
    SELECT 
        ride_id,
        rideable_type,
        started_at,
        ended_at,
        start_station_name,
        end_station_name,
        member_casual,
        INTERVAL EXTRACT(HOUR FROM ride_length) HOUR + 
                INTERVAL EXTRACT(MINUTE FROM ride_length) MINUTE + 
                INTERVAL EXTRACT(SECOND FROM ride_length) SECOND AS ride_length,
        day_of_week,
        ride_date,
        ride_month,
        start_time,
        end_time,
        ROW_NUMBER() OVER (PARTITION BY ride_id) AS row_num
    FROM (
        SELECT * FROM `data-analytics-learner.2024_cyclistic_cs.2024_q1_tripdata`
        UNION ALL
        SELECT * FROM `data-analytics-learner.2024_cyclistic_cs.2024_q2_tripdata`
        UNION ALL
        SELECT * FROM `data-analytics-learner.2024_cyclistic_cs.2024_q3_tripdata`
        UNION ALL
        SELECT * FROM `data-analytics-learner.2024_cyclistic_cs.2024_q4_tripdata`
    ) AS combined_data
)

SELECT 
    ride_id,
    rideable_type,
    started_at,
    ended_at,
    start_station_name,
    end_station_name,
    member_casual,
    ride_length,
    day_of_week,
    ride_date,
    ride_month,
    start_time,
    end_time
FROM 
    combined_data
WHERE 
    row_num = 1;
