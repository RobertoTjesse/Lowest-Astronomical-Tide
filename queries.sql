
/*First we create a table to insert in one column all the data. The PostGIS adds geometry function to the database */ 

CREATE TABLE dtu10_parse(data text); CREATE EXTENSION postgis; 
COPY dtu10_parse FROM 'E:/dtu10/DTU10MSS_2min.txt' DELIMITER AS '|';

/*Then we create a table with string fields to parse the important data, namely lat lon height*/

CREATE TABLE DTU10_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO DTU10_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,33,7)As height
FROM dtu10_parse;

/*Afterwards we transofrm string data to numeric values*/


ALTER TABLE DTU10_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Do some data muggling (360 to 180-)*/

UPDATE dtu10_mss2 SET lon = lon -360 WHERE lon >= 180 ;   

/*Adding geometry properties*/ 

ALTER TABLE DTU10_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE DTU10_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE DTU10_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
--------------------------------------------------------------------------
/* First we create a table to insert in one column all the data*/

CREATE TABLE dtu13_parse(data text);
COPY dtu13_parse FROM 'E:/dtu10/DTU13MSS_1min.txt' DELIMITER AS '|';

/*Then we create a table with string fields to parse the important data, namely lat lon height*/

CREATE TABLE DTU13_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO DTU13_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,33,7)As height
FROM dtu13_parse;

/*Afterwards we transform string data to numeric values*/

ALTER TABLE DTU13_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE DTU13_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE DTU13_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Do some data muggling (360 to 180-)*/

UPDATE dtu13_mss2 SET lon = lon -360 WHERE lon >= 180 ;   

/*Adding geometry properties*/ 

ALTER TABLE DTU13_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE DTU13_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE DTU13_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
--------------------------------------------------------------------------
/* First we create a table to insert in one column all the data */

CREATE TABLE dtu15_parse(data text);
COPY dtu15_parse FROM 'E:/dtu10/DTU15MSS_2min.txt' DELIMITER AS '|';

/*Then we create a table with string fields to parse the important data, namely lat lon height* HERE THERE IS ONE EXTRA COLUMN*/

CREATE TABLE DTU15_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO DTU15_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,41,7)As height
FROM dtu15_parse;

/*Afterwards we transofrm string data to numeric values*/


ALTER TABLE DTU15_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE DTU15_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE DTU15_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Do some data muggling (360 to 180-)*/

UPDATE dtu15_mss2 SET lon = lon -360 WHERE lon >= 180 ;   

/*Adding geometry properties*/ 

ALTER TABLE DTU15_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE DTU15_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE DTU15_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
*//*
*/
ADDING A SPATIAL INDEX
 CREATE INDEX idx_dtu10 ON dtu10_mss2 USING GIST(geom);
 CREATE INDEX idx_dtu13 ON dtu13_mss2 USING GIST(geom);
 CREATE INDEX idx_dtu15 ON dtu15_mss2 USING GIST(geom);


-------------


CREATE TABLE grid_tweets AS
SELECT pts.*, grid.gid as gridID
FROM 
    "dtu13_mss1" AS pts, "vl" grid
WHERE ST_Contains( grid.geom, pts.geom)


----------------





CREATE TABLE lat_dtu10 AS
SELECT pts.*, grid.gid as gridID
FROM 
    "dtu10_mss2" AS pts, "vl" grid
WHERE ST_Contains( grid.geom, pts.geom);
ALTER TABLE lat_dtu10 ADD COLUMN Country integer;
ALTER TABLE lat_dtu10 ADD COLUMN Syst integer;
UPDATE lat_dtu10 SET Syst = 8  ;   

UPDATE lat_dtu10 SET Syst = 2 ;
UPDATE lat_dtu10 SET Country = 8 ;
CREATE TABLE lat_dtu13 AS
SELECT pts.*, grid.gid as gridID
FROM 
    "dtu13_mss1" AS pts, "vl" grid
WHERE ST_Contains( grid.geom, pts.geom);
ALTER TABLE lat_dtu13 ADD COLUMN Country integer;
ALTER TABLE lat_dtu13 ADD COLUMN Syst integer;
UPDATE lat_dtu13 SET Syst = 8  ;   

UPDATE lat_dtu13 SET Syst = 2 ;
UPDATE lat_dtu13 SET Country = 8 ;
CREATE TABLE lat_dtu15 AS
SELECT pts.*, grid.gid as gridID
FROM 
    "dtu15_mss2" AS pts, "vl" grid
WHERE ST_Contains( grid.geom, pts.geom);
ALTER TABLE lat_dtu15 ADD COLUMN Country integer;
ALTER TABLE lat_dtu15 ADD COLUMN Syst integer;
UPDATE lat_dtu15 SET Syst = 8  ;   

UPDATE lat_dtu13 SET Syst = 2 ;
UPDATE lat_dtu13 SET Country = 8 ;
