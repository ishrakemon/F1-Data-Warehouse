/*
Created by: Ishrakuzzaman Emon
Schema: F1_Data 
*/

CREATE DATABASE F1_Data;
GO
USE F1_Data;
GO

-- CIRCUITS (Tracks)
CREATE TABLE circuits (
    circuitId INT PRIMARY KEY,
    circuitRef VARCHAR(255),
    name VARCHAR(255),
    location VARCHAR(255),
    country VARCHAR(255),
    lat FLOAT,
    lng FLOAT,
    alt INT,
    url VARCHAR(MAX)
);

-- DRIVERS (The Athletes)
CREATE TABLE drivers (
    driverId INT PRIMARY KEY,
    driverRef VARCHAR(255),
    number VARCHAR(10), 
    code VARCHAR(10),
    forename VARCHAR(255),
    surname VARCHAR(255),
    dob DATE,
    nationality VARCHAR(255),
    url VARCHAR(MAX)
);

-- CONSTRUCTORS (The Teams)
CREATE TABLE constructors (
    constructorId INT PRIMARY KEY,
    constructorRef VARCHAR(255),
    name VARCHAR(255),
    nationality VARCHAR(255),
    url VARCHAR(MAX)
);

-- SEASONS (Years)
CREATE TABLE seasons (
    year INT PRIMARY KEY,
    url VARCHAR(MAX)
);

-- STATUS (Race Outcomes)
CREATE TABLE status (
    statusId INT PRIMARY KEY,
    status VARCHAR(255)
);

-- RACES (The Schedule)
CREATE TABLE races (
    raceId INT PRIMARY KEY,
    year INT,
    round INT,
    circuitId INT,
    name VARCHAR(255),
    date DATE,
    time VARCHAR(50),
    url VARCHAR(MAX),
    fp1_date VARCHAR(50),
    fp1_time VARCHAR(50),
    fp2_date VARCHAR(50),
    fp2_time VARCHAR(50),
    fp3_date VARCHAR(50),
    fp3_time VARCHAR(50),
    quali_date VARCHAR(50),
    quali_time VARCHAR(50),
    sprint_date VARCHAR(50),
    sprint_time VARCHAR(50)
);

-- RESULTS (The Main Data)
CREATE TABLE results (
    resultId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number VARCHAR(10),
    grid INT,
    position VARCHAR(10), 
    positionText VARCHAR(255),
    positionOrder INT,
    points FLOAT,
    laps INT,
    time VARCHAR(255),
    milliseconds VARCHAR(255), 
    fastestLap VARCHAR(10),
    rank VARCHAR(10),
    fastestLapTime VARCHAR(255),
    fastestLapSpeed VARCHAR(255),
    statusId INT
);

-- PIT STOPS
CREATE TABLE pit_stops (
    raceId INT,
    driverId INT,
    stop INT,
    lap INT,
    time VARCHAR(255),
    duration VARCHAR(255),
    milliseconds INT
);

-- QUALIFYING
CREATE TABLE qualifying (
    qualifyId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    position INT,
    q1 VARCHAR(255),
    q2 VARCHAR(255),
    q3 VARCHAR(255)
);

-- LAP TIMES (Big Table)
CREATE TABLE lap_times (
    raceId INT,
    driverId INT,
    lap INT,
    position INT,
    time VARCHAR(255),
    milliseconds INT
);

-- SPRINT RESULTS
CREATE TABLE sprint_results (
    resultId INT PRIMARY KEY,
    raceId INT,
    driverId INT,
    constructorId INT,
    number INT,
    grid INT,
    position INT,
    positionText VARCHAR(255),
    positionOrder INT,
    points FLOAT,
    laps INT,
    time VARCHAR(255),
    milliseconds VARCHAR(255),
    fastestLap VARCHAR(10),
    fastestLapTime VARCHAR(255),
    statusId INT
);
