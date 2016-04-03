
---------------------------------------------------------------------------
#Physical activity calculator
---------------------------------------------------------------------------


This code computes minutes of physical activity (PA) intensity (sedentary, light, moderate and vigorous) using  evidence-based cut points for accelerometry data (ActiGraph). The implemented procedure follows the protocol proposed by ISCOLE as treatment of accelerometry data for children. As an output for each participant, it provides: 1) Number of valid days of use; 2)Total wear time in minutes; 3) Average minutes and counts of each physical activity intensity level between days. It also calculates minutes and counts of each PA intensity level for midweek and weekend.

Results are exported to a CSV file.

##Table of contents
1. R and RStudio
2. Required packages
3. How to use this code?

--------------------------------------------------------------------

#R and RStudio
##R
R is a free software environment for statistical computing and graphics. It compiles and runs on a wide variety of UNIX platforms, Windows and MacOS. To download R, please choose your preferred Comprehensive R Archive Network (CRAN) mirror:


- [University of California, Los Angeles, CA](http://cran.stat.ucla.edu/)
- [National Cancer Institute, Bethesda, MD](http://watson.nci.nih.gov/cran_mirror/)
- [Michigan Technological University, Houghton, MI](http://cran.mtu.edu/)
- [Washington University, St. Louis, MO](http://cran.wustl.edu/)
- [Case Western Reserve University, Cleveland, OH](http://cran.case.edu/)
- [Statlib, Carnegie Mellon University, Pittsburgh, PA](http://lib.stat.cmu.edu/R/CRAN/)
- [National Institute for Computational Sciences, Oak Ridge, TN](http://mirrors.nics.utk.edu/cran/)
- [Revolution Analytics, Dallas, TX](http://cran.revolutionanalytics.com)
- [Fred Hutchinson Cancer Research Center, Seattle, WA](http://cran.fhcrc.org/)
- [Western Washington University, Bellingham, WA](http://cran.cs.wwu.edu/)

##RStudio
RStudio is a free and open source integrated development environment for R (See Fig 1). It is not required to run or develop code in R but it is a useful tool to do it. 

![Fig 1](http://www.rstudio.com/images/screenshots/rstudio-windows.png "Fig 1. RStudio IDE")

For further information about RStudio, the reader may refer to RStudio [webpage](http://www.rstudio.com/). You can download the RStudio installer from the following links:

- [RStudio 0.98.484 - Windows XP/Vista/7/8](http://download1.rstudio.org/RStudio-0.98.484.exe)
- [RStudio 0.98.484 - Mac OS X 10.6+ (64-bit)](http://download1.rstudio.org/RStudio-0.98.484.dmg)

#Required packages
In R, *Packages* are collections of R functions, data, and compiled code in a well-defined format. In order to execute the code, some packages are required and must be downloaded, installed and loaded prior to running the code.

The required packages are:

- *Hmisc*
- *RSQLite*
- *sqldf*
- *xlsx*

To install any package, you can use the built-in function:

    install.packages(<package_name>)

Or, if you decided to install RStudio, this IDE provides easy tool to automatically download and install multiple packages at the same time. Under the Packages tab (bottom-right panel), you can see all your installed packages. There, you can use the "Install package" button to download and install the required packages. The following image presents this dialog.

![Fiq 2](http://imageshack.com/a/img7/4936/qtgi.jpg "Fig 2 Install package dialog")

#How to use this code?
In order to use the code, the R file ***ac\_protocol.R*** have to be edited. The code holds five important components: *Working directory*, *Required libraries*, *Functions*, *Global parameters* and *Main routine*. In this section, the description of those components is presented.

##Set the working directory
The working directory (wd) is the folder which stores the R code, the input data and the code's output data. Likewise, the wd folder must contain the following folders:

 - **R**: The code is stored in this folder.
 - **data**: Contains all the .agd files to be processed.
 - **output**: The final data frame and a log will be stored in this folder.

Line 5 sets the working directory.

##Load required libraries
Starting at line 9, the lines load all the required libraries. Those libraries must be installed before running the code; otherwise, an error message will be printed on Console. 

    Error in library("Hmisc") : there is no package called ‘Hmisc’

The reader may refer back to *Requiered libraries* section for more information.

##Load functions
From line 20 until 446, all the functions are declared. Those function must be loaded in the *Workspace* to run the main routine.

##Set global parameters
Before the main routine, a set of global parameters must be fixed.

- **inputdir**: Input data folder directory.
- **outputdir**: Output folder directory.
- **outputfile**: Output .csv file name.
- **packdir**: Pack file directory. This file must be a .xlsx file and must have the same format as in the example.
- **sheets**: Sheets contained within the Pack file.

##Load and run the main function
In the main function, you should fix the values for the functions parameters. In the framework, the values defined as parameters are those described in the paper *Collection, Management and Treatment in the International Study of Children's Obesity, Lifestyle and Environment (ISCOLE)*; however, the reader is free to modify them as their needs.

The main function is composed of nine blocks:

###1. Read data form the .agd files (SQLite databases)

The following block reads the database (.agd file) using the file directory `dbDir` and save the accelerometry data on the variable `data` and all the settings parameters on the variable `settings`.

    db <- readDatabase(dbDir)
    data <- db$data
    settings <- db$settings

###2. Quality control checks

This line performs all the quality control checks and receives as parameters the file directory, the accelerometry data, the settings and the pack data frame.

	valid <- qualityControlCheck(dbDir,data, settings, pack)

###3. Data aggregation

In this block the data is aggregated in 15sec epoch and 60sec epoch. In addition, an activity column is added to both data frames (all epochs are marked as "wear/wake").

	data15 <- aggregation(15, data)
    data60 <- aggregation(60, data)
    data15$activity <- rep("wear",nrow(data15)) #Activity (sleep, non-wear, wear/wake)
    data60$activity <- rep("wear",nrow(data60)) #Activity (sleep, non-wear, wear/wake)

###4. Sleep period identification
	
The function `sleepPeriods` identifies all the sleep periods and the non-wear periods within the sleep periods. As output, it returns a list with the sleep and non-wear periods. This function receives as parameter:
		
- **data:** The data frame to identified the sleep periods (if epoch < 60sec, the data is aggregate to 60sec epoch).
- **sleepOnsetHours:** Range of day hours in which a sleep period can start.
- **bedTimemin:** Number of consecutive minutes to start a sleep period.
- **minSleepTime:** Minimum sleep period length (in minutes).
- **tolMatrix:** Tolerance matrix. Consecutive minutes of non-sleep to declare the end of a sleep period. The minutes may differ between range of hours.
- **tolBsleepMatrix:** Tolerance matrix before identifying a sleep period. Consecutive minutes of non-sleep to declare the end of a sleep period. The minutes may differ between range of hours.
- **scanParam:** Scan parameter to identify the sleep minutes using Sadeh et al. (1994) algorithm (axis1, axis2, axis3 or vm).
- **nonWearPSleep:** Boolean parameter. If TRUE -> non-wear periods are identified within the sleep periods;otherwise, non-wear periods within the sleep periods are not identified.
- **nonWearscanParam:** Scan parameter to identify the non-wear periods within sleep periods (axis1, axis2, axis3 or vm).
- **nonWearInact:** Minimum non-wear period length (in minutes).
- **nonWearTol:** Maximum minutes of activity (i.e. counts per minute > 0) to declare the end of a non-wear period.
- **overlap\_frac:** Fraction of time to declare a sleep period a non-wear period. If the overlap_frac of a sleep period is identified as non-wear, the sleep period is marked as non-wear.

Additionally, the function `setActivity()` adds the activity label to the *activity* column between the intervals in the data frame given as parameter.

	sleep <- sleepPeriods(data=data60,sleepOnsetHours= c(19,5),
						bedTimemin = 5,
						minSleepTime = 160,
						tolMatrix = matrix(c(0,5,20,
                                             5,19,10,
                                             19,24,20),3,3,byrow=T),
                        tolBsleepMatrix = matrix(c(0,24,10),1,3,byrow=T),
                        scanParam = "axis1",
                        nonWearPSleep = T, nonWearscanParam = "axis1",nonWearInact = 90, 
						nonWearTol = 2,
                        overlap_frac = 0.9)
	 data60 <- setActivity(label="sleep",intv=sleep$sleep,data60)
	 data60 <- setActivity(label="non-wear",intv=sleep$sleepnw,data60)

###5. Non-wear period identification

In this block the non-wear periods are identified over the unlabeled minutes. The function `nonWearPeriods()` receives as parameter the data frame, the scan parameter used to identify the non-wear periods, the minimum number of minutes to identify a non-wear period and the tolerance.

    nWP <- nonWearPeriods(data60, scanParam="axis1",innactivity=20,tolerance=0) #nonWearPeriods. Innactivity and tolerance in minutes
    data60 <- setActivity("non-wear",nWP,data60)

###6. Wear periods check

The following function search for count per epoch greater than the `maxcpm` parameter. Those epoch are labeled as invalid. Furthermore, the first minutes of the first day of the sample are labeled as "sleep".

	data60 <- checkWearPeriods(data60,maxcpm = 20000)

###7. Cleaning (Remove last day of data and more than 7 days of data)

The function `removeData()` deletes the days/hours/minutes/seconds (given as parameter) from the data frame.

	udays <- unique(as.Date(data60$datetime))
    firstday <- min(udays)
    lastday <- max(udays)
    validdays <- seq(firstday,firstday+6,by=1) 
    daystoremove <- udays[!(udays%in%validdays)]
    data15 <- removeData(data15,toremove=c(daystoremove,lastday),units="days") 
    data60 <- removeData(data60,toremove=c(daystoremove,lastday),units="days") 

###8. Add intensity physical activity

This block performs two procedures. 1) Add the activity column from the 60sec epoch data frame to the 15sec epoch data frame. 2) Add the physical activity intensity to each epoch using evidence-based cut points. In this case, the Evenson et al. (2008) cut points are used.

    data15 <- mergingActivity(data15,data60)
    data15$intensityEV <- mapply(cut_points_evenson,epoch=15, data15$axis1)
	   

###9. Get the datafile observation for the final data frame (only wear periods)
	
Extract all the physical activity intensity related variables for each participant.
	      
	ob <- getobs(dbDir,data15, timeunit="min")


For further information about the functions and their parameters, you can refer to the function documentation.



*After compile and load all the fuctions into the *workspace*, run the function `main( )` to obtain the final data frame.*

##Output
The R code will generate a file named *log.txt* and a .csv file with the result of the analysis. On one hand, the *log.txt* file presents all the the information of the run. The following is an example for four .agd files:

	A1109_10459_201307181sec.agd........OK
	A1110_10488_201307181sec.agd........OK  
	A1111_10482_201307181sec.agd........SKIPPED (Wrong epoch) 
	A1112_10483_201307181sec.agd........OK

On the other hand, each row of the .csv file contains the aggregate information of one .agd file (i.e one participant). The variables are generated as follows:

- **PID**: Participant ID
- **valid**: At least 4 days with 10+ hours of wake/wear time, including 1 valid weekend day
- **valdays**: Number of days with 10+ hours of wake/wear time
- **valwkdays**: Number of WEEKDAYS with 10+ hours of wake/wear time
- **valwkend**: Number of WEEKEND DAYS with 10+ hours of wake/wear time
- **allMeanWakeWear**: Mean wake/wear time (mins) per day from all valid days
- **allMeanSleepNW**: Mean sleep and non-wear (mins) per day from all valid days
- **allmean\_mv\_EV**: Mean duration (mins) of (Evenson) MVPA per day
- **allmean\_cntmv\_EV**: Mean daily total intensity counts in (Evenson) MVPA
- **allmean\_v\_EV**: Mean duration (mins) of (Evenson) vigorous activity per day
- **allmean\_cntv\_EV**: Mean daily total intensity counts in (Evenson) vigorous
- **allmean\_m\_EV**: Mean duration (mins) of (Evenson) moderate activity per day
- **allmean\_cntm\_EV**: Mean daily total intensity counts in (Evenson) moderate
- **allmean\_l\_EV**: Mean duration (mins) of (Evenson) light activity per day
- **allmean\_cntl\_EV**: Mean daily total intensity counts in (Evenson) light
- **allmean\_s\_EV**: Mean duration (mins) of (Evenson) sedentary per day
- **allmean\_cnts\_EV**: Mean daily total intensity counts in (Evenson) sedentary
- **allMeanActCounts**: Mean daily total intensity counts
- **allMeanIntenPerMin**: Mean intensity count per minute
- **WKDAYMeanWakeWear**: Mean wake/wear time (mins) per day from all valid WEEKDAYS
- **WKDAYMeanSleepNW**: Mean sleep and non-wear (mins) per day from all valid WEEKDAYS
- **WKDAYmean\_mv\_EV**: Mean duration of (Evenson) MVPA per WEEKDAY
- **WKDAYmean\_cntmv\_EV**: Mean daily total intensity counts in (Evenson) MVPA per WEEKDAY
- **WKDAYmean\_v\_EV**: Mean duration of (Evenson) vigorous activity per WEEKDAY
- **WKDAYmean\_cntv\_EV**: Mean daily total intensity counts in (Evenson) vigorous per WEEKDAY
- **WKDAYmean\_m\_EV**: Mean duration of (Evenson) moderate activity per WEEKDAY
- **WKDAYmean\_cntm\_EV**: Mean daily total intensity counts in (Evenson) moderate per WEEKDAY
- **WKDAYmean\_l\_EV**: Mean duration of (Evenson) light activity per WEEKDAY
- **WKDAYmean\_cntl\_EV**: Mean daily total intensity counts in (Evenson) light per WEEKDAY
- **WKDAYmean\_s\_EV**: Mean duration of (Evenson) sedentary per WEEKDAY
- **WKDAYmean\_cnts\_EV**: Mean daily total intensity counts in (Evenson) sedentary per WEEKDAY
- **WKDAYMeanActCounts**: Mean daily total intensity counts from WEEKDAYS
- **WKDAYMeanIntenPerMin**: Mean intensity count per minute from WEEKDAYS
- **WKENDMeanWakeWear**: Mean wake/wear time (mins) per day from all valid WEEKEND DAYS
- **WKENDMeanSleepNW**: Mean sleep and non-wear (mins) per day from all valid WEEKEND DAYS
- **WKENDmean\_mv\_EV**: Mean duration of (Evenson) MVPA per WEEKEND DAY
- **WKENDmean\_cntmv\_EV**: Mean daily total intensity counts in (Evenson) MVPA per WEEKEND DAY
- **WKENDmean\_v\_EV**: Mean duration of (Evenson) vigorous activity per WEEKEND DAY
- **WKENDmean\_cntv\_EV**: Mean daily total intensity counts in (Evenson) vigorous per WEEKEND DAY
- **WKENDmean\_m\_EV**: Mean duration of (Evenson) moderate activity per WEEKEND DAY
- **WKENDmean\_cntm\_EV**: Mean daily total intensity counts in (Evenson) moderate per WEEKEND DAY
- **WKENDmean\_l\_EV**: Mean duration of (Evenson) light activity per WEEKEND DAY
- **WKENDmean\_cntl\_EV**: Mean daily total intensity counts in (Evenson) light per WEEKEND DAY
- **WKENDmean\_s\_EV**: Mean duration of (Evenson) sedentary per WEEKEND DAY
- **WKENDmean\_cnts\_EV**: Mean daily total intensity counts in (Evenson) sedentary per WEEKEND DAY
- **WKENDMeanActCounts**: Mean daily total intensity counts from WEEKEND DAYS
- **WKENDMeanIntenPerMin**: Mean intensity count per minute from WEEKEND DAYS



