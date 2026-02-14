/* ANALYSIS VIEW */

USE F1_Data; -- Make sure to use the correct database
GO

-- This query calculates the average and best position gains for each driver in each constructor, considering
SELECT 
    Driver_Name,
    Constructor_Name,
    COUNT(*) AS Total_Races,
    AVG(Grid - Position_Order) AS Avg_Positions_Gained,
    MAX(Grid - Position_Order) AS Best_Charge_In_Single_Race
FROM vw_PowerBI_F1_Performance
WHERE Race_Status = 'Finished' -- Only consider races where the driver finished to calculate position gains
GROUP BY Driver_Name, Constructor_Name
ORDER BY Avg_Positions_Gained DESC; -- This will show which drivers consistently gain positions during (overtaking)

--===================================================================================================

-- This query calculates the DNF percentage for each constructor
SELECT 
    Constructor_Name,
    COUNT(*) AS Total_Starts,
    SUM(CASE WHEN Race_Status = 'Mechanical DNF' THEN 1 ELSE 0 END) AS Mechanical_Failures, -- Count of mechanical DNFs
    SUM(CASE WHEN Race_Status = 'Accident' THEN 1 ELSE 0 END) AS Crashes, -- Count of accidents
    CAST(SUM(CASE WHEN Race_Status IN ('Mechanical DNF', 'Accident') THEN 1 ELSE 0 END) AS FLOAT) 
        / COUNT(*) * 100 AS DNF_Percentage -- DNF percentage calculation
FROM vw_PowerBI_F1_Performance
GROUP BY Constructor_Name
HAVING COUNT(*) > 5 -- Filters out one-off guest teams
ORDER BY DNF_Percentage DESC;     

--===================================================================================================

-- This query calculates the average track speed and points per driver for each circuit.
SELECT 
    Country,
    Circuit_Name,
    AVG(Fastest_Lap_Speed) AS Avg_Track_Speed,
    MAX(Fastest_Lap_Speed) AS Record_Lap_Speed,
    AVG(Points) AS Avg_Points_Per_Driver
FROM vw_PowerBI_F1_Performance
WHERE Fastest_Lap_Speed > 0 -- Only consider valid lap speeds for the average and record calculations
GROUP BY Country, Circuit_Name
ORDER BY Avg_Track_Speed DESC;

--===================================================================================================

-- This query compares the performance of two constructors (e.g., Ferrari vs McLaren) over the years.
WITH TeamComparison AS (
    SELECT 
        Constructor_Name,
        Race_Year,
        SUM(Points) AS Total_Points,
        AVG(Position_Order) AS Avg_Finish,
        COUNT(*) AS Total_Starts,
        SUM(CASE WHEN Race_Status = 'Finished' THEN 1 ELSE 0 END) AS Total_Finishes
    FROM vw_PowerBI_F1_Performance
    WHERE Constructor_Name IN ('Ferrari', 'McLaren') 
    GROUP BY Constructor_Name, Race_Year
)
SELECT 
    Race_Year,
    -- Ferrari Stats
    MAX(CASE WHEN Constructor_Name = 'Ferrari' THEN Total_Points ELSE 0 END) AS Ferrari_Points,
    MAX(CASE WHEN Constructor_Name = 'Ferrari' THEN Avg_Finish ELSE NULL END) AS Ferrari_Avg_Finish,
    -- McLaren Stats
    MAX(CASE WHEN Constructor_Name = 'McLaren' THEN Total_Points ELSE 0 END) AS McLaren_Points,
    MAX(CASE WHEN Constructor_Name = 'McLaren' THEN Avg_Finish ELSE NULL END) AS McLaren_Avg_Finish
FROM TeamComparison
GROUP BY Race_Year
ORDER BY Race_Year DESC;
