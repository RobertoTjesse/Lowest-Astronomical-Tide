-----------------------------------dtu10--------------------------------------------------------------------------------------------------                                                                                       

/*First we create a table which we will use to parse individual columns. We also create the postgis extension inside the database to make sure its there.
 This is a standard procedure to copy values from a fixed space table into postgresql. The update query replaces any kind of number of spaces into one space. This makes handling easier in following steps. Replace path to file as shown here*/ 

CREATE temporary TABLE dtu10_parse(data text); 
COPY dtu10_parse FROM 'E:/DTU10MSS_2min.xyz' DELIMITER AS E'|';
UPDATE dtu10_parse SET data = trim(regexp_replace(data, '\s+', ' ', 'g'));

/*Then we create a table that will be populated with the organized data; station,lat,lon,error,height. We populate the fields by making use of the function regexp *stands for regular expression*. This will extract individual columns from each full string. It copies this to each cell, and jumps to the next one.*/

CREATE TABLE DTU10_mss2 (station varchar (5),lat varchar(8), lon varchar(8), error varchar (4), height varchar(8));
INSERT INTO DTU10_mss2 (station,lat, lon, error, height)
SELECT 	split_part(data, ' ', 1),
		split_part(data, ' ', 2),
		split_part(data, ' ', 3),
		split_part(data, ' ', 4),
		split_part(data, ' ', 5) 
FROM   dtu10_parse;
/*Afterwards we transform the string columns to numeric values. This will allow us to further process it as numbers.*/

ALTER TABLE DTU10_mss2 ALTER COLUMN lat TYPE NUMERIC(8,4) USING (lat::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN lon TYPE NUMERIC(8,4) USING (lon::numeric);
ALTER TABLE DTU10_mss2 ALTER COLUMN height TYPE NUMERIC(7,3) USING (height::numeric);

/*Here we do some data muggling in order to transform the TOPEX coordinate system to WGS84. This begins with transforming longitudes ranging from 0,360 to a -180,180 scale, and substracting 0.7 m to the height values to adapt to the WGS84  ellipsoid.*/

	                                                                     
ALTER TABLE dtu10_mss2
	ADD COLUMN newheight NUMERIC;
	UPDATE dtu10_mss2 SET newheight = height -0.7;                                                                        
                                                                                                                                   
                                           
/*Adding geometry properties*/ 

ALTER TABLE DTU10_mss2 ADD COLUMN gid serial PRIMARY KEY;
ALTER TABLE DTU10_mss2 ADD COLUMN geom geometry(POINT,4326);
UPDATE DTU10_mss2 SET geom = ST_SetSRID(ST_MakePoint(lon,lat),4326);
UPDATE DTU10_mss2 SET lon = ST_X(geom::geometry);   
                                                                        
/*We define the study areas of interest and create our tables */

CREATE TABLE DTU10_BALTIC AS(SELECT * FROM dtu10_mss2  WHERE geom && ST_MakeEnvelope(8.8498963749078907,52.8723845733182998,34.5668618090039033,66.5277591033835023,4326 ));
CREATE TABLE DTU10_NORTHSEA AS(SELECT * FROM dtu10_mss2  WHERE geom && ST_MakeEnvelope(-16.4937176894747992,42.6980038817051977,13.8900195517934009,59.8250856833049980,4326 ));

/*Now we can visualize the mean sea surface derived from the dtu in our study areas */         
                                                                                       
 /*In case we want to run the data through BLAST, we already insert the static indices it needs. columns*/

ALTER TABLE DTU10_BALTIC ADD COLUMN country integer;
ALTER TABLE DTU10_BALTIC ADD COLUMN syst integer;
	UPDATE DTU10_BALTIC SET Syst = 4 ;
	UPDATE DTU10_BALTIC SET Country = 8 ;                      
ALTER TABLE DTU10_NORTHSEA ADD COLUMN country integer;
ALTER TABLE DTU10_NORTHSEA ADD COLUMN syst integer;
	UPDATE DTU10_NORTHSEA SET syst = 4 ;
	UPDATE DTU10_NORTHSEA SET country = 8 ;    
	
COPY DTU10_NORTHSEA(station,lat,lon,newheight,country,syst) to 'E:\example_06.inp' WITH DELIMITER E'\t';  
																					   
