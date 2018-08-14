# Creation of a database to extract estimated LAT values defined by a study area

One Paragraph of project description goes here

## Getting Started

These instructions will get you a copy of the project up and running on your local machine. 

### Prerequisites

You will need PostgreSQL+PostGIS, a relational database with geometry functions to rapidly access heights. PostgreSQL WITH PostGIS,a relational database with geometry functions to rapidly access heights. PgAdmin3 in order to easily create a database, and to make random checks. QGIS to determine the consistency of the spatial data. 
```
PostgreSQL 9.6 WITH latest PostGIS
PgAdmin3 (PgAdmin 4 is still a little bit buggy)
QGIS (>2.18)
```
### Installing

A step by step series that tell you how to get ayour database up and running

```
1. Download and install PostgreSQL with PostGIS , PgAdmin3 and QGIS in case you havent yet.

2. Check that the installation by opening PgAdmin 3, creating a new database, and adding the postgis extension.
	(i.e, once PgAdmin 3 is open, query the following lines 
		CREATE DATABASE dtu_mss;
		\connect dtu_mss;
		CREATE EXTENSION postgis;
		
3. Download and extract the DTU xyz files to be imported. In this script we will import DTU10, DTU 13 and DTU 15 with 2 min, 1 min and 2 min separation respectively from:
	[dtu10](ftp://ftp.space.dtu.dk/pub/DTU13/2_MIN/DTU13MSS_2min.xyz.zip)
	[dtu13](ftp://ftp.space.dtu.dk/pub/DTU10/2_MIN/DTU10MSS_2min.xyz.zip)
	[dtu15](ftp://ftp.space.dtu.dk/pub/DTU15/2_MIN/DTU15MSS_2min.xyz.zip)
	
4. Open the database manager in QGIS, and run the following queries to create the database. 

5. Open QGIS to create a study area polygon.

6. Extract to CSV
```

