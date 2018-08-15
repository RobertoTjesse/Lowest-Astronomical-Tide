# Creation of a database to extract estimated LAT values defined by a study area

In order to provide calibration geoids for subsea surveying equipment, I have written this small guidelines. It makes use of a relational database which is common in GIS packages. The steps go from downloading the files to extracting MSS values for a selected area, or LAT values making use of BLAST.

## Getting Started

These instructions will get you a copy of the database up and running on your local machine. 

### Prerequisites

+ You will need PostgreSQL+PostGIS, a relational database with geometry functions to rapidly access heights
+ PgAdmin3 (PgAdmin 4 is still a little bit buggy) in order to easily create a database, and to make random checks
+ QGIS (>2.18)
+ BLAST more info [here](http://www.blast-project.eu/), find a download link [here](http://blast-project.eu/media.php?file=604)

### Installing

A step by step series that tell you how to get your database up 'n running


1. Download and install PostgreSQL with PostGIS , PgAdmin3 and QGIS in case you havent yet

2. Check that the installation by opening PgAdmin 3, creating a new database, and adding the postgis extension
	(i.e, once PgAdmin 3 is open, query the following lines :
	
		```
		CREATE DATABASE dtu_mss;
		
		connect dtu_mss;
			
		CREATE EXTENSION postgis;
		```

3. Download and extract the DTU xyz files to be imported. In this script we will import DTU10, DTU 13 and DTU 15 with 2 min, 1 min and 2 min separation respectively from:	
	```
	ftp://ftp.space.dtu.dk/pub/DTU13/2_MIN/DTU13MSS_2min.xyz.zip
	
	ftp://ftp.space.dtu.dk/pub/DTU10/2_MIN/DTU10MSS_2min.xyz.zip
	
	ftp://ftp.space.dtu.dk/pub/DTU15/2_MIN/DTU15MSS_2min.xyz.zip
	
4. Open the database manager in QGIS, and run the following [QUERIES](./queries.sql) to create the database. 

5. Open QGIS to create a study area polygon.

6. Extract to CSV

