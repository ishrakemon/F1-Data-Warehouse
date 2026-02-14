/* 
THE SILVER LAYER:
JOINING & CLEANING 
created by: Ishrakuzzaman Emon
*/

USE F1_Data; -- Make sure to use the correct database
GO

CREATE VIEW vw_PowerBI_F1_Performance AS 
SELECT 
    r.points AS Points,
    r.positionOrder AS Position_Order,
    r.grid AS Grid,
    ISNULL(TRY_CAST(r.fastestLapSpeed AS DECIMAL(10,3)), 0) AS Fastest_Lap_Speed, -- Handling the NULLs
    -- Categorizing the race status into more meaningful groups
    CASE 
        WHEN s.status = 'Finished' THEN 'Finished'
        WHEN s.status LIKE '+%Lap%' THEN 'Lapped'
        WHEN s.status IN ('Engine', 'Gearbox', 'Transmission', 'Clutch', 'Hydraulics', 'Electrical') THEN 'Mechanical DNF'
        WHEN s.status IN ('Accident', 'Collision', 'Spun off') THEN 'Accident'
        ELSE 'Other'
    END AS Race_Status,

    d.forename + ' ' + d.surname AS Driver_Name, -- Concatenating forename and surname to get the full name of the driver
    c.name AS Constructor_Name,
    r2.name AS Race_Name,
    cr.name AS Circuit_Name,
    r2.year AS Race_Year,
    cr.lat,
    cr.lng,
    cr.country AS Country
FROM results r -- The main table
LEFT JOIN drivers AS d ON r.driverId = d.driverId
LEFT JOIN constructors AS c ON r.constructorId = c.constructorId
LEFT JOIN races AS r2 ON r.raceId = r2.raceId
LEFT JOIN circuits AS cr ON r2.circuitId = cr.circuitId
LEFT JOIN status AS s ON r.statusId = s.statusId;
