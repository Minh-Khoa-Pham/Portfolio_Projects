CREATE TABLE CombinedTable (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat FLOAT,
    start_lng FLOAT,
    end_lat FLOAT,
    end_lng FLOAT,
    member_casual VARCHAR(255)
	);
-- Import data from the first Excel file
INSERT INTO CombinedTable (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=D:\Coursera\Google Data Analytics\Capstone\Data\2023_Q1\202301-divvy-tripdata.xlsx', 'SELECT * FROM [Sheet1$]');

-- Import data from the second Excel file
INSERT INTO CombinedTable (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=D:\Coursera\Google Data Analytics\Capstone\Data\2023_Q1\202302-divvy-tripdata.xlsx', 'SELECT * FROM [Sheet1$]');

-- Import data from the third Excel file
INSERT INTO CombinedTable (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=D:\Coursera\Google Data Analytics\Capstone\Data\2023_Q1\202303-divvy-tripdata.xlsx', 'SELECT * FROM [Sheet1$]');

-- Import data from the fourth Excel file
INSERT INTO CombinedTable (ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual)
SELECT ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Excel 12.0;Database=D:\Coursera\Google Data Analytics\Capstone\Data\2023_Q1\202304-divvy-tripdata.xlsx', 'SELECT * FROM [Sheet1$]');
