--Joined Han,Feb And Mar tables as Q1 'quarter'
-- This query is only possible as all the tables have same column and data type
---converted the data of day_of_week from numeric values (1-7) to corresponding weekday names ('Monday' to 'Sunday').
-- converted data of ride_month from numerical values (1-12) to corresponding month names ('January' to 'December'). Done at the same time while combining data because i can't update the table in the free(non billing version)

CREATE TABLE `data-analytics-learner.2024_cyclistic_cs.2024_q1_tripdata` AS
WITH combined_data AS (
    SELECT *
    FROM `data-analytics-learner.2024_cyclistic_cs.202401_tripdata`
    UNION DISTINCT
    SELECT *
    FROM `data-analytics-learner.2024_cyclistic_cs.202402_tripdata`
    UNION DISTINCT
    SELECT *
    FROM `data-analytics-learner.2024_cyclistic_cs.202403_tripdata`
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
    CASE 
        WHEN day_of_week = 1 THEN 'Monday'
        WHEN day_of_week = 2 THEN 'Tuesday'
        WHEN day_of_week = 3 THEN 'Wednesday'
        WHEN day_of_week = 4 THEN 'Thursday'
        WHEN day_of_week = 5 THEN 'Friday'
        WHEN day_of_week = 6 THEN 'Saturday'
        WHEN day_of_week = 7 THEN 'Sunday'
    END AS day_of_week,
    ride_date,
    CASE 
        WHEN ride_month = 1 THEN 'January'
        WHEN ride_month = 2 THEN 'February'
        WHEN ride_month = 3 THEN 'March'
        WHEN ride_month = 4 THEN 'April'
        WHEN ride_month = 5 THEN 'May'
        WHEN ride_month = 6 THEN 'June'
        WHEN ride_month = 7 THEN 'July'
        WHEN ride_month = 8 THEN 'August'
        WHEN ride_month = 9 THEN 'September'
        WHEN ride_month = 10 THEN 'October'
        WHEN ride_month = 11 THEN 'November'
        WHEN ride_month = 12 THEN 'December'
    END AS ride_month,
    start_time,
    end_time
FROM combined_data;
