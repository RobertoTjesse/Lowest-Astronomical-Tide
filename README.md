# Creation of a PostgreSQL database to extract estimated mss values defined by a study area prior to BLAST processing

In order to provide calibration geoids for subsea surveying equipment, I have written this small guideline. It makes use of a relational database which is common in GIS called PostgreSQL. The guideline starts from 0 to 100. We will go through extracting MSS values for a selected area, to transform them to LAT values making use of BLAST.

## Getting Started

These instructions will get you a copy of the database up and running on your local machine. 

### Prerequisites

+ You will need PostgreSQL+PostGIS, a relational database with geometry functions to rapidly access heights
+ PgAdmin3 (PgAdmin 4 is still a little bit buggy) in order to easily create a database, and to make random checks
+ QGIS (>2.18)
+ BLAST more info [here](http://www.blast-project.eu/), find a download link [here](http://blast-project.eu/media.php?file=604)

### Installing


1. Download and install PostgreSQL with PostGIS , PgAdmin3 and QGIS in case you havent yet
	1. Follow this link to download PostgreSQL with PostGIS 
		```
		https://www.enterprisedb.com/software-downloads-postgres 
		```
	Here you need to get EDB Postgres Standard / PostgreSQL >= 9.6
	
	After having chosen the right location for the program files, make sure you choose the hard drive where you want to have your 		database. I used an internal Solid State Drive to ease on speed. At the end of the installation you will have the possibility to 	install addons. Here you have the option to install PostGIS and create a sample Database. Do this.
	
	2. Follow this link to install PgAdmin3
		```
		https://www.pgadmin.org/download/
		```
	At the time I wrote this I wasnt being very succesful with pgAdmin4, hence I recommend pgAdmin3.
	
	3. Follow this link to install QGIS
		```
		https://qgis.org/en/site/forusers/download.html
		```
	The Standalone installer will do for now.

	4. Follow this link to get BLAST
		```
		http://blast-project.eu/media.php?file=604
		```
	
	
	5. Get PostgresSQL running by opening PGAdmin3 and creating a new database. Use a username and password you will 		remember. 
	6. Create a new database by right clicking the already existing database. 
	7. Click on dtu/Schemas/Tables(0). This is the place where our new tables will be listed. At the moment its empty. Go back to 		this step to check if you are running your steps accordingly.
	8. Minimize PGadmin3, we will come back soon.
	
	
3. Download and extract the DTU xyz files to be imported. In this script we will import DTU10, DTU 13 and DTU 15 with 2 min separation  from:	
	```
	ftp://ftp.space.dtu.dk/pub/DTU13/2_MIN/DTU13MSS_2min.xyz.zip
	
	

### Make a CSV with MSS (Mean Sea Surface) values

	
4. Mouse yourself into PgAdmin3 to dtu/Schemas/Tables(0) and run the following [QUERIES](./queries.sql) to create the database. 

	![Alt text](/screenshot1.png?raw=true "Optional Title")
	
5. After succesfully running all the queries, keep going.
	

4. Open QGIS, on the browser, look for the ~~pink~~ blue elephant and right click on it, >Add new PostGIS connection
	
	![Alt text](/screenshot2.png?raw=true "Optional Title")
	
	Add your username and password
	
5. Go to the DBase manager inside QGIS


2. Connect to your localhost and database


3. Right click on the created table and select >Add to canvas to the new study areas


4. Export as CSV in case you need to use the model


### Make a CSV with LAT (Lowest Astronomical Tide) values

5. For this we will run the derived MSS file through BLAST

5. To get BLAST running you just need to decompress BLAST in your program file folder. Afterwards make sure to make a folder in
	your C drive entitled blastdata ```C:/blastdata``` Inhere paste 2 folders, vrf and masks. They are located in the decompressed blast
	folder.
2. Open your CSV file with the MSS values for your study area. Add a new column entitled Title and automatically fill it with a 
	increasing index (for example: 1,2,3,4... or A001,A002...)
5. Export it as a tab delimited file
5. It should look like
	```
	Title	lat	lon	newheight	country	syst
	A0001	58.25	2.8667	44.176	8	2
	A0002	58.25	2.9	44.155	8	2
	A0003	58.25	2.9333	44.13	8	2
	A0004	58.25	2.9667	44.106	8	2
	A0005	58.25	3	44.086	8	2
	A0006	58.25	3.0333	44.067	8	2
	...
	```
5. Open the file and add a # in fron of the header
5. Save the file as data_06.inp
5. Download the following [folder](dtu_lat.7z) and save it under your examples folder. In my case it is 
	```C:\ProgramFiles\BLAST_height_transformation_tool\blastrafo_release1.1\examples```
5. Run the example_66.bat

![Alt text](/screenshot3.png?raw=true "Optional Title")

6. The resulting dtu_lat.inp.out is your resulting LAT model.

7. Open it with EXCEL in order to edit the variable space between columns and save it as a flatsimple CSV.	









