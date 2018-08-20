
/*First we create a table which we will use to parse individual columns. We also create the postgis extension inside the database to make sure its there.
 This is a standard procedure to copy values from a fixed space table into postgresql. Replace path to file as shown here*/ 

CREATE TABLE dtu10_parse(data text); CREATE EXTENSION postgis; 
COPY dtu10_parse FROM 'E:/dtu10/DTU10MSS_2min.txt' DELIMITER AS '|';

/*Then we create a table that will be populated with the the important data, namely lat lon height. We populate the fields by making use of the substring function.
SUBSTRING ( string ,start_position , length ). Literally, it begins reading each row at a certain point and acquires the amount of values you tell him. It copies this to each cell, and jumps to the next one.*/

CREATE TABLE DTU10_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO DTU10_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,33,7)As height
FROM dtu10_parse;

/*Afterwards we transform the string columns to numeric values. This will allow us to further process it as numbers.*/


ALTER TABLE DTU10_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Here we do some data muggling in order to transform the TOPEX coordinate system, to WGS84. This begins with transforming longitudes ranging from 0,360 to a -180,180 scale, and substracting 0.7m to the height values to adapt to 
the WGS84  ellipsoid.*/

UPDATE dtu10_mss2 SET lon = lon -360 WHERE lon >= 180 ;  
ALTER TABLE dtu10_mss2
ADD COLUMN newheight varchar;
UPDATE dtu10_mss2 SET newheight = height -0.7;                                                                        
                                                                     
/*In case we want to run the data through BLAST, we already insert the static indices it needs. columns*/

ALTER TABLE lat_dtu10 ADD COLUMN Country integer;
ALTER TABLE lat_dtu10 ADD COLUMN Syst integer;
UPDATE lat_dtu10 SET Syst = 2 ;
UPDATE lat_dtu10 SET Country = 8 ;                                                                     
                                           
/*Adding geometry properties*/ 

ALTER TABLE DTU10_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE DTU10_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE DTU10_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
                                                                        
/*We define the study areas of interest and create our tables */

CREATE TABLE NAME_OF_NEWTABLE AS(SELECT * FROM NAME_OF_POINTTABLE  WHERE geom && ST_MakeEnvelope((xmin,ymin,xmax,ymax,srid) ));
CREATE TABLE DTU10_BALTIC AS(SELECT * FROM dtu10_mss2  WHERE geom && ST_MakeEnvelope(8.8498963749078907,52.8723845733182998,34.5668618090039033,66.5277591033835023,4326 ));
CREATE TABLE DTU10_NORTHSEA AS(SELECT * FROM dtu10_mss2  WHERE geom && ST_MakeEnvelope(-16.4937176894747992,42.6980038817051977,13.8900195517934009,59.8250856833049980,4326 ));

/*Now we can visualize the mean sea surface derived from the dtu in our study areas */                                                                                 
                                                                                       
-----------------------------------dtu13--------------------------------------------------------------------------------------------------                                                                                       
   
/*First we create a table which we will use to parse individual columns. We also create the postgis extension inside the database to make sure its there.
 This is a standard procedure to copy values from a fixed space table into postgresql. */ 

CREATE TABLE dtu13_parse(data text); CREATE EXTENSION postgis; 
COPY dtu13_parse FROM 'E:/destinationto/your/dtuXXfile.txt' DELIMITER AS '|';

/*Then we create a table that will be populated with the the important data, namely lat lon height. We populate the fields by making use of the substring function.
SUBSTRING ( string ,start_position , length ). Literally, it begins reading each row at a certain point and acquires the amount of values you tell him. It copies this to each cell, and jumps to the next one.*/

CREATE TABLE DTU13_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO DTU13_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,33,7)As height
FROM dtu13_parse;

/*Afterwards we transform the string columns to numeric values. This will allow us to further process it as numbers.*/


ALTER TABLE dtu13_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE dtu13_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE dtu13_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Here we do some data muggling in order to transform the TOPEX coordinate system, to WGS84. This begins with transforming longitudes ranging from 0,360 to a -180,180 scale, and substracting 0.7m to the height values to adapt to 
the WGS84  ellipsoid.*/

UPDATE dtu13_mss2 SET lon = lon -360 WHERE lon >= 180 ;  
ALTER TABLE dtu13_mss2
ADD COLUMN newheight varchar;
UPDATE dtu13_mss2 SET newheight = height -0.7;                                                                        
                                                                     
/*In case we want to run the data through BLAST, we already insert the static indices it needs. columns*/

ALTER TABLE lat_dtu13 ADD COLUMN Country integer;
ALTER TABLE lat_dtu13 ADD COLUMN Syst integer;
UPDATE lat_dtu13 SET Syst = 2 ;
UPDATE lat_dtu13 SET Country = 8 ;                                                                     
                                           
/*Adding geometry properties*/ 

ALTER TABLE dtu13_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE dtu13_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE dtu13_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
                                                                        
/*We define the study areas of interest and create our tables */

CREATE TABLE NAME_OF_NEWTABLE AS(SELECT * FROM NAME_OF_POINTTABLE  WHERE geom && ST_MakeEnvelope((xmin,ymin,xmax,ymax,srid) ));
CREATE TABLE dtu13_BALTIC AS(SELECT * FROM dtu13_mss2  WHERE geom && ST_MakeEnvelope(8.8498963749078907,52.8723845733182998,34.5668618090039033,66.5277591033835023,4326 ));
CREATE TABLE dtu13_NORTHSEA AS(SELECT * FROM dtu13_mss2  WHERE geom && ST_MakeEnvelope(-16.4937176894747992,42.6980038817051977,13.8900195517934009,59.8250856833049980,4326 ));

/*Now we can visualize the mean sea surface derived from the dtu in our study areas */                                                                                 
                                                                                       
  -----------------------------------dtu15--------------------------------------------------------------------------------------------------                                                                                       

                                                                                          
/*First we create a table which we will use to parse individual columns. We also create the postgis extension inside the database to make sure its there.
 This is a standard procedure to copy values from a fixed space table into postgresql. */ 

CREATE TABLE dtu15_parse(data text); CREATE EXTENSION postgis; 
COPY dtu15_parse FROM 'E:/destinationto/your/dtuXXfile.txt' DELIMITER AS '|';

/*Then we create a table that will be populated with the the important data, namely lat lon height. We populate the fields by making use of the substring function.
SUBSTRING ( string ,start_position , length ). Literally, it begins reading each row at a certain point and acquires the amount of values you tell him. It copies this to each cell, and jumps to the next one.*/

CREATE TABLE dtu15_mss2 (lat varchar(8), lon varchar(8), height varchar(7));
INSERT INTO dtu15_mss2 (lat, lon, height)
SELECT substring(data,8,8)As lat, substring(data,18,8)As lon, substring(data,33,7)As height
FROM dtu15_parse;

/*Afterwards we transform the string columns to numeric values. This will allow us to further process it as numbers.*/


ALTER TABLE dtu15_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE dtu15_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE dtu15_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Here we do some data muggling in order to transform the TOPEX coordinate system, to WGS84. This begins with transforming longitudes ranging from 0,360 to a -180,180 scale, and substracting 0.7m to the height values to adapt to 
the WGS84  ellipsoid.*/

UPDATE dtu15_mss2 SET lon = lon -360 WHERE lon >= 180 ;  
ALTER TABLE dtu15_mss2
ADD COLUMN newheight varchar;
UPDATE dtu15_mss2 SET newheight = height -0.7;                                                                        
                                                                     
/*In case we want to run the data through BLAST, we already insert the static indices it needs. columns*/

ALTER TABLE lat_dtu15 ADD COLUMN Country integer;
ALTER TABLE lat_dtu15 ADD COLUMN Syst integer;
UPDATE lat_dtu15 SET Syst = 2 ;
UPDATE lat_dtu15 SET Country = 8 ;                                                                     
                                           
/*Adding geometry properties*/ 

ALTER TABLE dtu15_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE dtu15_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE dtu15_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
                                                                        
/*We define the study areas of interest and create our tables */

CREATE TABLE NAME_OF_NEWTABLE AS(SELECT * FROM NAME_OF_POINTTABLE  WHERE geom && ST_MakeEnvelope((xmin,ymin,xmax,ymax,srid) ));
CREATE TABLE dtu15_BALTIC AS(SELECT * FROM dtu15_mss2  WHERE geom && ST_MakeEnvelope(8.8498963749078907,52.8723845733182998,34.5668618090039033,66.5277591033835023,4326 ));
CREATE TABLE dtu15_NORTHSEA AS(SELECT * FROM dtu15_mss2  WHERE geom && ST_MakeEnvelope(-16.4937176894747992,42.6980038817051977,13.8900195517934009,59.8250856833049980,4326 ));

/*Now we can visualize the mean sea surface derived from the dtu in our study areas */      
