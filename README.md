# Creation of a database to extract estimated LAT values defined by a study area

In order to provide calibration geoids for subsea surveying equipment, I have written this small guideline. It makes use of a relational database which is common in GIS called PostgreSQL. The guideline starts from 0 to 100. We will go through extracting MSS values for a selected area, to transform them to LAT values making use of BLAST.

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
	1.1 Follow this link to download PostgreSQL with PostGIS 
		```
		https://www.enterprisedb.com/software-downloads-postgres 
		```
	Here you need to get EDB Postgres Standard / PostgreSQL >= 9.6
	
	After having chosen the right location for the program files, make sure yu choose the hard drive where you want to have your 		database. I used an internal Solid State Drive to ease on speed. At the end of the installation you will have the possibility to 	install addons. Here you have the option to install PostGIS and create a sample Database. Do this.
	
	1.2 Follow this link to install PgAdmin3
		```
		https://www.pgadmin.org/download/
		```
	At the time I wrote this I wasnt being very succesful with pgAdmin4, hence I recommend pgAdmin3.
	
	1.3 Follow this link to install QGIS
		```
		https://qgis.org/en/site/forusers/download.html
		```
	The Standalon installer will do for now.
	
	2.1 Get PostgresSQL up and running by opening PGAdmin3 and creating a new database. Use a username and password you will 		remember. I used postgres. 
	2.2 Create a new database by right clicking the already existing database. Dont go for a too fancy name, I went for dtu.
	3.3 Click on dtu/Schemas/Tables(0). This is the place where our new tables will be listed. At the moment its empty. Go back to 		this step to check if you running your steps accordingly.
	4.1 Minimiz PGadmin3, we will come back soon.
	
	
3. Download and extract the DTU xyz files to be imported. In this script we will import DTU10, DTU 13 and DTU 15 with 2 min separation  from:	
	```
	ftp://ftp.space.dtu.dk/pub/DTU13/2_MIN/DTU13MSS_2min.xyz.zip
	
	ftp://ftp.space.dtu.dk/pub/DTU10/2_MIN/DTU10MSS_2min.xyz.zip
	
	ftp://ftp.space.dtu.dk/pub/DTU15/2_MIN/DTU15MSS_2min.xyz.zip
	
	
4. Mouse yourself into PgAdmin3 to dtu/Schemas/Tables(0) and run the following [QUERIES](./queries.sql) to create the database. 

	![Alt text](/screenshot1.png?raw=true "Optional Title")
	
5. After succesfully running all the queries, keep going.
	

4. Open QGIS, on the browser, look for the ~~pink~~ blue elephant and right click on it, >Add new PostGIS connection
	
	![Alt text](/screenshot2.png?raw=true "Optional Title")
	
	Add your username and password
	
5. Go to the DBase manager inside QGIS


2. Connect to your localhost and database


3. Right click on the created table and select >Add to canvas to the new study areas


4. Export as CSV/xyz 




