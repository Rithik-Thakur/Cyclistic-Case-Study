--average ride length by bike type and as per member type
SELECT
 rideable_type,
 member_casual,
 AVG(ride_length) AS ride_length_AVG
FROM
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
  1,2--average ride length by bike type
SELECT
 rideable_type,
 AVG(ride_length) AS ride_length_AVG
FROM
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
  1

 -- Looking at average ride length per day of week

SELECT
        day_of_week,
        AVG(ride_length) AS average_ride_length
FROM 
    (
     SELECT
         member_casual,
         day_of_week,
         ride_length,
        FROM
         `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata` 
        )
GROUP BY
        day_of_week
ORDER BY
        average_ride_length DESC
-- Average Ride Lengths: Members vs Casual  
-- Looking at overall, member and casual average ride lengths
SELECT
    AVG(ride_length) AS AvgRideLength_Overall,
    AVG(CASE WHEN member_casual = 'member' THEN ride_length END) AS AvgRideLength_Member,
    AVG(CASE WHEN member_casual = 'casual' THEN ride_length END) AS AvgRideLength_Casual
FROM
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`;
--AVG ride length per day of week for casual and member

SELECT
   member_casual,
   day_of_week,
   AVG(ride_length) AS average_ride_length
FROM 
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY
   day_of_week,
   member_casual
ORDER BY
   average_ride_length DESC
 -- Rides per day: member and casual
 -- Looking at which days have the highest number of rides

SELECT
  member_casual,
  day_of_week AS mode_day_of_week # Top number of day_of_week
FROM 
 (
   SELECT
         DISTINCT member_casual,
         day_of_week,
         ROW_NUMBER() OVER (PARTITION BY member_casual ORDER BY COUNT(day_of_week) DESC) rn
   FROM
         `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
   GROUP BY
         member_casual,
         day_of_week 
        )
WHERE
        rn = 1
ORDER BY
        member_casual DESC
-- End stations: member vs casual
-- end station counts

SELECT 
    end_station_name,
    COUNT(*) AS total,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual
FROM 
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
    end_station_name
ORDER BY 
    total DESC;
--max ride length by bike type and member type
SELECT
  rideable_type,
  member_casual,
  MAX(ride_length) AS ride_length_MAX
FROM
  `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
 1,2 --max ride length by bike type

SELECT
  rideable_type,
  MAX(ride_length) AS ride_length_MAX
FROM
  `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
 1-- Max Ride Lengths: Members vs Casual  
 -- Looking at max ride lengths to check for outliers

SELECT
    member_casual,
    MAX(ride_length) AS ride_length_MAX
FROM `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`

GROUP BY member_casual
--median ride length per day of week
SELECT
 DISTINCT median_ride_length,
 day_of_week
FROM 
    (SELECT
       day_of_week,
       ride_length,
       PERCENTILE_DISC(ride_length, 0.5 IGNORE NULLS) OVER(PARTITION BY day_of_week) AS median_ride_length
     FROM
       `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
        )
ORDER BY
    median_ride_length DESC-- median ride lengths per day as per member type
SELECT
    DISTINCT median_ride_length,
    member_casual,
    day_of_week
FROM (
    SELECT
        member_casual,
        day_of_week,
        ride_length,
        PERCENTILE_DISC(ride_length, 0.5 IGNORE NULLS) OVER(
            PARTITION BY member_casual, day_of_week
        ) AS median_ride_length
    FROM
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
)
ORDER BY
    median_ride_length DESC;

-- Monthly Average Ride Lengths: Members vs Casual  
SELECT
    ride_month,
    AVG(ride_length) AS AvgRideLength_Overall,
    AVG(CASE WHEN member_casual = 'member' THEN ride_length END) AS AvgRideLength_Member,
    AVG(CASE WHEN member_casual = 'casual' THEN ride_length END) AS AvgRideLength_Casual
FROM
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY
    ride_month
ORDER BY
    CASE
        WHEN ride_month = 'January' THEN 1
        WHEN ride_month = 'February' THEN 2
        WHEN ride_month = 'March' THEN 3
        WHEN ride_month = 'April' THEN 4
        WHEN ride_month = 'May' THEN 5
        WHEN ride_month = 'June' THEN 6
        WHEN ride_month = 'July' THEN 7
        WHEN ride_month = 'August' THEN 8
        WHEN ride_month = 'September' THEN 9
        WHEN ride_month = 'October' THEN 10
        WHEN ride_month = 'November' THEN 11
        WHEN ride_month = 'December' THEN 12
    END;
-- Monthly Max Ride Lengths: Members vs Casual 
SELECT
    ride_month,
    member_casual,
    MAX(ride_length) AS ride_length_MAX
FROM 
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY
    ride_month,
    member_casual
ORDER BY
    CASE
        WHEN ride_month = 'January' THEN 1
        WHEN ride_month = 'February' THEN 2
        WHEN ride_month = 'March' THEN 3
        WHEN ride_month = 'April' THEN 4
        WHEN ride_month = 'May' THEN 5
        WHEN ride_month = 'June' THEN 6
        WHEN ride_month = 'July' THEN 7
        WHEN ride_month = 'August' THEN 8
        WHEN ride_month = 'September' THEN 9
        WHEN ride_month = 'October' THEN 10
        WHEN ride_month = 'November' THEN 11
        WHEN ride_month = 'December' THEN 12
    END,
    member_casual;
-- Median Ride Lengths: Members vs Casual 
 -- Looking at median because of outliers influence on AVG

SELECT
    DISTINCT ride_month,
    median_ride_length,
    member_casual
FROM (
    SELECT
        ride_id,
        member_casual,
        ride_length,
        ride_month,
        PERCENTILE_DISC(ride_length, 0.5 IGNORE NULLS) OVER(PARTITION BY member_casual, ride_month) AS median_ride_length
    FROM 
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
)
ORDER BY
    CASE
        WHEN ride_month = 'January' THEN 1
        WHEN ride_month = 'February' THEN 2
        WHEN ride_month = 'March' THEN 3
        WHEN ride_month = 'April' THEN 4
        WHEN ride_month = 'May' THEN 5
        WHEN ride_month = 'June' THEN 6
        WHEN ride_month = 'July' THEN 7
        WHEN ride_month = 'August' THEN 8
        WHEN ride_month = 'September' THEN 9
        WHEN ride_month = 'October' THEN 10
        WHEN ride_month = 'November' THEN 11
        WHEN ride_month = 'December' THEN 12
    END;-- Monthly Total Trips: Members vs Casual 
SELECT
    ride_month,
    TotalTrips,
    TotalMemberTrips,
    TotalCasualTrips,
    ROUND(TotalMemberTrips / TotalTrips * 100, 2) AS MemberPercentage,
    ROUND(TotalCasualTrips / TotalTrips * 100, 2) AS CasualPercentage
FROM (
    SELECT
        ride_month,
        COUNT(ride_id) AS TotalTrips,
        COUNTIF(member_casual = 'member') AS TotalMemberTrips,
        COUNTIF(member_casual = 'casual') AS TotalCasualTrips
    FROM
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
    GROUP BY
        ride_month
)
ORDER BY
    CASE
        WHEN ride_month = 'January' THEN 1
        WHEN ride_month = 'February' THEN 2
        WHEN ride_month = 'March' THEN 3
        WHEN ride_month = 'April' THEN 4
        WHEN ride_month = 'May' THEN 5
        WHEN ride_month = 'June' THEN 6
        WHEN ride_month = 'July' THEN 7
        WHEN ride_month = 'August' THEN 8
        WHEN ride_month = 'September' THEN 9
        WHEN ride_month = 'October' THEN 10
        WHEN ride_month = 'November' THEN 11
        WHEN ride_month = 'December' THEN 12
    END;
-- most popular bike types per member vs casual
-- Overall counts

SELECT COUNTIF(rideable_type = rideable_type) AS `Rows`,
       rideable_type,
       member_casual
FROM `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY rideable_type, 
         member_casual
ORDER BY `Rows` DESC;
 -- Looking at most popular start and end station combos 
 -- Overall count

SELECT 
        COUNTIF(end_station_name = end_station_name AND start_station_name = start_station_name) AS `Rows`, 
        start_station_name, 
        end_station_name
FROM
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
        start_station_name, 
        end_station_name
ORDER BY 
        `Rows` DESC -- most popular start and end station combos

SELECT 
   start_station_name, 
   end_station_name,
   COUNT(*) AS combination_cnt
FROM
     `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
WHERE 
     start_station_name IS NOT NULL 
     AND end_station_name IS NOT NULL
GROUP BY 
        1,2
ORDER BY 
        combination_cnt DESC
 -- Looking at most popular start and end station combos
 -- Filtering by member or casual 

SELECT 
    start_station_name, 
    end_station_name,
    COUNT(*) AS combination_cnt,
    member_casual
FROM
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
WHERE 
     start_station_name IS NOT NULL 
     AND end_station_name IS NOT NULL

GROUP BY 
 1,2,4
ORDER BY 
 combination_cnt DESC--Overall counts ride per bike type
SELECT rideable_type,
      COUNT(ride_id) AS TotalTrips
FROM `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY rideable_type
ORDER BY TotalTrips DESC;
-- percentage of total number of trips per member type
-- Overall, member, casual
-- total number of trips per day 
SELECT 
    day_of_week,
    COUNT(DISTINCT ride_id) AS TotalTrips,
    SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
    SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips,
    ROUND(SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) / COUNT(DISTINCT ride_id) * 100, 2) AS MemberPercentage,
    ROUND(SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) / COUNT(DISTINCT ride_id) * 100, 2) AS CasualPercentage
FROM 
    `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
    day_of_week
ORDER BY 
    TotalTrips DESC;
-- quarterly Average Ride Lengths: Members vs Casual
SELECT
    ride_quarter,
    AVG(ride_length) AS AvgRideLength_Overall,
    AVG(CASE WHEN member_casual = 'member' THEN ride_length END) AS AvgRideLength_Member,
    AVG(CASE WHEN member_casual = 'casual' THEN ride_length END) AS AvgRideLength_Casual
FROM (
    SELECT
        member_casual,
        ride_length,
        CASE 
            WHEN ride_month IN ('January', 'February', 'March') THEN 'Q1'
            WHEN ride_month IN ('April', 'May', 'June') THEN 'Q2'
            WHEN ride_month IN ('July', 'August', 'September') THEN 'Q3'
            WHEN ride_month IN ('October', 'November', 'December') THEN 'Q4'
        END AS ride_quarter
    FROM 
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
)
GROUP BY
    ride_quarter
ORDER BY
    CASE
        WHEN ride_quarter = 'Q1' THEN 1
        WHEN ride_quarter = 'Q2' THEN 2
        WHEN ride_quarter = 'Q3' THEN 3
        WHEN ride_quarter = 'Q4' THEN 4
    END;
-- Quarterly Max Ride Lengths: Members vs Casual 
SELECT
    ride_quarter,
    member_casual,
    MAX(ride_length) AS ride_length_MAX
FROM (
    SELECT
        member_casual,
        ride_length,
        CASE 
            WHEN ride_month IN ('January', 'February', 'March') THEN 'Q1'
            WHEN ride_month IN ('April', 'May', 'June') THEN 'Q2'
            WHEN ride_month IN ('July', 'August', 'September') THEN 'Q3'
            WHEN ride_month IN ('October', 'November', 'December') THEN 'Q4'
        END AS ride_quarter
    FROM 
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
)
GROUP BY
    ride_quarter,
    member_casual
ORDER BY
    CASE
        WHEN ride_quarter = 'Q1' THEN 1
        WHEN ride_quarter = 'Q2' THEN 2
        WHEN ride_quarter = 'Q3' THEN 3
        WHEN ride_quarter = 'Q4' THEN 4
    END,
    member_casual;
-- Quarterly Median Ride Lengths: Members vs Casual 
SELECT
    DISTINCT ride_quarter,
    median_ride_length,
    member_casual
FROM (
    SELECT
        member_casual,
        ride_length,
        CASE 
            WHEN ride_month IN ('January', 'February', 'March') THEN 'Q1'
            WHEN ride_month IN ('April', 'May', 'June') THEN 'Q2'
            WHEN ride_month IN ('July', 'August', 'September') THEN 'Q3'
            WHEN ride_month IN ('October', 'November', 'December') THEN 'Q4'
        END AS ride_quarter,
        PERCENTILE_DISC(ride_length, 0.5 IGNORE NULLS) OVER(
            PARTITION BY member_casual, 
            CASE 
                WHEN ride_month IN ('January', 'February', 'March') THEN 'Q1'
                WHEN ride_month IN ('April', 'May', 'June') THEN 'Q2'
                WHEN ride_month IN ('July', 'August', 'September') THEN 'Q3'
                WHEN ride_month IN ('October', 'November', 'December') THEN 'Q4'
            END
        ) AS median_ride_length
    FROM 
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
)
ORDER BY
    CASE
        WHEN ride_quarter = 'Q1' THEN 1
        WHEN ride_quarter = 'Q2' THEN 2
        WHEN ride_quarter = 'Q3' THEN 3
        WHEN ride_quarter = 'Q4' THEN 4
    END,
    member_casual,
    median_ride_length DESC;

-- Quarterly Total Trips: Members vs Casual 
SELECT
    ride_quarter,
    TotalTrips,
    TotalMemberTrips,
    TotalCasualTrips,
    ROUND(TotalMemberTrips / TotalTrips * 100, 2) AS MemberPercentage,
    ROUND(TotalCasualTrips / TotalTrips * 100, 2) AS CasualPercentage
FROM (
    SELECT
        CASE 
            WHEN ride_month IN ('January', 'February', 'March') THEN 'Q1'
            WHEN ride_month IN ('April', 'May', 'June') THEN 'Q2'
            WHEN ride_month IN ('July', 'August', 'September') THEN 'Q3'
            WHEN ride_month IN ('October', 'November', 'December') THEN 'Q4'
        END AS ride_quarter,
        COUNT(ride_id) AS TotalTrips,
        COUNTIF(member_casual = 'member') AS TotalMemberTrips,
        COUNTIF(member_casual = 'casual') AS TotalCasualTrips
    FROM
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
    GROUP BY
        ride_quarter
)
ORDER BY
    CASE
        WHEN ride_quarter = 'Q1' THEN 1
        WHEN ride_quarter = 'Q2' THEN 2
        WHEN ride_quarter = 'Q3' THEN 3
        WHEN ride_quarter = 'Q4' THEN 4
    END;
-- Start stations: member vs casual
-- start station counts
SELECT 
  start_station_name,
  COUNT(ride_id) AS total,
  SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS member,
  SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS casual
FROM 
 `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY 
  start_station_name
ORDER BY 
  total DESC;
-- Overall, member, casual
 -- Looking at total number of trips per day 

SELECT day_of_week,
       COUNT(ride_id) AS TotalTrips,
       SUM(CASE WHEN member_casual = 'member' THEN 1 ELSE 0 END) AS MemberTrips,
       SUM(CASE WHEN member_casual = 'casual' THEN 1 ELSE 0 END) AS CasualTrips
FROM `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`

GROUP BY 1

ORDER BY TotalTrips DESC;-- Overall trips per day
-- Looking at total number of trips per day_of_week

SELECT
  day_of_week,
  COUNT(ride_id) AS TotalTrips,
  (COUNT(ride_id)/TotalTrips_Overall)*100 AS PercentageOfTotal
FROM
    (SELECT 
       COUNT(ride_id) AS TotalTrips_Overall
     FROM
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
        ),
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
GROUP BY
        day_of_week, TotalTrips_Overall
ORDER BY
      TotalTrips DESC --total trips per day(date) and member type
SELECT
    TotalTrips,
    member_casual,
    ride_date
FROM 
    (
      SELECT
         COUNT(ride_id) AS TotalTrips,
         member_casual,
         ride_date
      FROM
            `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
      WHERE 
             ride_date IS NOT NULL
      GROUP BY
         member_casual,
         ride_date
    )
ORDER BY ride_date ASC;
 -- Total Trips: Members vs Casual 
 -- Looking at overall, annual member and casual rider totals

SELECT
        TotalTrips,
        TotalMemberTrips,
        TotalCasualTrips,
        ROUND(TotalMemberTrips/TotalTrips,2)*100 AS MemberPercentage,
        ROUND(TotalCasualTrips/TotalTrips,2)*100 AS CasualPercentage
FROM 
        (
        SELECT
                COUNT(ride_id) AS TotalTrips,
                COUNTIF(member_casual = 'member') AS TotalMemberTrips,
                COUNTIF(member_casual = 'casual') AS TotalCasualTrips
        FROM
                `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
        )--Trips per day(date) and member/casual along with percentage
SELECT
 ride_date,
 TotalTrips_both,
 TotalMemberTrips,
 TotalCasualTrips,
 ROUND(CAST(TotalMemberTrips/TotalTrips_both AS NUMERIC),2)*100 AS MemberPercentage,
 ROUND(CAST(TotalCasualTrips/TotalTrips_both AS NUMERIC),2)*100 AS CasualPercentage
FROM 
   (SELECT
         ride_date,
         COUNT(ride_id) AS TotalTrips_both,
         COUNTIF(member_casual = 'member') AS TotalMemberTrips,
         COUNTIF(member_casual = 'casual') AS TotalCasualTrips
    FROM
         `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
    WHERE 
         ride_date = ride_date
    GROUP BY 
         ride_date
        )
GROUP BY 
  1,2,3,4
ORDER BY 
  ride_date
--trips per start hour and member/casual along with percentage
WITH base_data AS (
    SELECT 
        EXTRACT(HOUR FROM start_time) AS start_hour,
        ride_id,
        member_casual
    FROM 
        `data-analytics-learner.2024_cyclistic_cs.2024_annual_tripdata`
),

hourly_counts AS (
    SELECT 
        start_hour,
        COUNT(CASE WHEN member_casual = 'member' THEN 1 END) AS member_trips,
        COUNT(CASE WHEN member_casual = 'casual' THEN 1 END) AS casual_trips,
        COUNT(ride_id) AS total_trips
    FROM 
        base_data
    GROUP BY 
        start_hour
)

SELECT
    start_hour,
    member_trips,
    casual_trips,
    total_trips,
    ROUND((member_trips * 100.0 / total_trips), 2) AS member_percentage,
    ROUND((casual_trips * 100.0 / total_trips), 2) AS casual_percentage
FROM 
    hourly_counts
ORDER BY  
    start_hour;

