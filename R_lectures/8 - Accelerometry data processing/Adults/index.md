
---------------------------------------------------------------------------
#Physical activity calculator
---------------------------------------------------------------------------


This code computes minutes of physical activity (PA) intensity (moderate and vigorous) using  evidence-based cut points for accelerometry data (ActiGraph).  It provides as an output for each participant: 1) Number of valid days of use; 2)Total wear time for moderate and vigorous PA intensity (in minutes); 3) Total minutes within bouts registered (minutes of break time, minutes of moderate activity, minutes of vigorous activity, and total bout duration in minutes) for each participant. It also computes minutes and counts for moderate and vigorous PA intensity level for midweek and weekend separately.

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
From line 15 until 213, all the functions are declared. Those function must be loaded in the *Workspace* to run the main routine.

##Set global parameters
Before the main routine, a set of global parameters must be fixed.

- **inputdir**: Input data folder directory.
- **outputdir**: Output folder directory.
- **outputfile**: Output .csv file name.

##Load and run the main function
In the main function, you should fix the values for the functions parameters.

The main function is composed of six blocks:

###1. Read data form the .agd files (SQLite databases)

The following block reads the database (.agd file) using the file directory `dbDir` and save the accelerometry data on the variable `data` and all the settings parameters on the variable `settings`.

    db <- readDatabase(dbDir)
    data <- db$data
    settings <- db$settings

###2. Non-wear period identification

In this block the non-wear periods are identified. The function `nonWearPeriods()` receives as parameter the data frame, the scan parameter used to identify the non-wear periods, the minimum number of minutes to identify a non-wear period and the tolerance.

	nw <- nonWearPeriods(data,innactivity=60,tolerance=0,scanParam="axis1")
    data$activity <- setValues(rep("wear",nrow(data)),"non-wear", nw)

###3. PA identification

Add the physical activity intensity to each epoch using evidence-based cut points. In this case, the Freedson et al. (1998) cut points are used.

    data$PA <- mapply(FUN=cut_points_freedsonAdults1998,data$axis1,60)

###4. Bout identification

The bout identification can be done by using two definitions of bouts:

 - *Maximum total break duration*: This definition declares a maximum noncontinuous time for the break time allowed within a bout. For example, if the maximum total break duration is fixed at 2 minutes, when the participant spend 3 minutes of non-moderate or non-vigorous activity, the bout is disrupted (regardless of how long the bout has been).
 
		boutsMaxTotalBreakDuration(PAvector,boutlen,bouttol)

 - *Percentage of activity*: A ratio between the total time of moderate to vigorous physical activity and the total time of bout duration (including breaks) is used to declare the end of a bout. The maximum break length is defined as: [total bout duration]*[ratio].This length applies after the bout duration is greater than minimum bout length.

	 	boutsPercActiv(PAvector,boutlen,bouttol,ratio)
	
The users are free to choose the definition that better fit their needs. The following block use the *Percentage of activity* bout definition to classify each epoch in the data frame.

    bouts <- boutsPercActiv(PAvector=data$PA,boutlen=10,bouttol=2, ratio = 0.2)
    data$bouted <- setValues(rep("unbout",nrow(data)),"bouted", bouts)

###5. Cleaning (Remove last day of data and more than 7 days of data)

The function `removeData()` deletes the days/hours/minutes/seconds (given as parameter) from the data frame.

    sample_days <- sort(unique(as.Date(data$datetime)))
    first_day <- min(sample_days)
    last_day <- max(sample_days)
    toremove <- sample_days[sample_days>first_day+6]
    data <- removeData(data,toremove=c(toremove,last_day),units="days")

###6. Consolidation

Extract all the physical activity intensity related variables for each participant.


For further information about the functions and their parameters, you can refer to the function documentation.



*After compile and load all the fuctions into the *workspace*, run the function `main( )` to obtain the final data frame.*

##Output
The R code will generate a .csv file with the result of the analysis. Each row of the .csv file contains the aggregate information of one .agd file (i.e one participant). The variables are generated as follows:

- **PID**: Participant ID.
- **valid**: At least 4 days with 10+ hours of wake/wear time, including 1 valid weekend day.
- **VldDays**: Number of days with 10+ hours of wake/wear time.
- **VldDays_WK**: Number of WEEKDAYS with 10+ hours of wake/wear time.
- **VldDays_WD**: Number of WEEKEND DAYS with 10+ hours of wake/wear time.
- **Tot_MinMVPA**: Total minutes (unbouted) of moderate to vigorous activity, considering only activity from valid days.
- **Tot_MinMPA**: Total minutes (unbouted) of moderate activity, considering only activity from valid days.
- **Tot\_MinVPA**: Total minutes (unbouted) of vigorous activity, considering only activity from valid days.
- **Tot\_MinMVPA\_WK**: Total minutes (unbouted) of moderate to vigorous activity during week days, considering only activity from valid week days.
- **Tot\_MinMPA\_WK**: Total minutes (unbouted) of moderate activity during week days, considering only activity from valid week days.
- **Tot\_MinVPA\_WK**: Total minutes (unbouted) of vigorous activity during week days, considering only activity from valid week days.
- **Tot\_MinMVPA\_WD**: Total minutes (unbouted) of moderate to vigorous activity during week-end days, considering only activity from valid weekend days.
- **Tot\_MinMPA\_WD**: Total minutes (unbouted) of moderate activity during week-end days, considering only activity from valid weekend days.
- **Tot\_MinVPA\_WD**: Total minutes (unbouted) of vigorous activity during week-end days, considering only activity from valid weekend days.
- **btMVPA\_num**: Total number of bouts of moderate to vigorous activity, using only valid days.
- **btVPA\_num**: Total number of bouts of moderate to vigorous activity that contains at least 1 min of vigorous activity, using only valid days.
- **bt\_min**: Total bout length (including MVPA plus breaks), using only valid days.
- **bt\_rest**: Total minutes of break-time within bouts, considering only valid days.
- **bt\_MVPA**: Total minutes of moderate to vigorous activity (excluding break-time) within MVPA bouts, using only valid days.
- **bt\_MPA**: Total minutes of moderate activity within MVPA bouts, using only valid days.
- **bt\_VPA**: Total minutes of vigorous activity within MVPA bouts, using only valid days.
- **btMVPA\_num\_WK**: Total number of bouts of moderate to vigorous activity, using only valid week days.
- **btVPA\_num\_WK**: Total number of bouts of moderate to vigorous activity that contains at least 1 min of vigorous activity, using only valid week days.
- **bt\_min\_WK**: Total bout length (MVPA plus breaks), using only valid week days.
- **bt\_rest\_WK**: Total minutes of break-time within MVPA bouts using only valid week days.
- **bt\_MVPA\_WK**: Total minutes of moderate to vigorous activity (excluding break-time) within MVPA bouts, using only valid week days.
- **bt\_MPA\_WK**: Total minutes of moderate activity within MVPA bouts, using only valid week days.
- **bt\_VPA\_WK**: Total minutes of vigorous activity within MVPA bouts, using only valid week days.
- **btMVPA\_num\_WD**: Total number of bouts of moderate to vigorous activity, using only valid weekend days.
- **btVPA\_num\_WD**: Total number of bouts of moderate to vigorous activity that contains at least 1 min of vigorous activity, using only valid weekend days.
- **bt\_min\_WD**: Total bout length (MVPA plus breaks), using only valid weekend days.
- **bt\_rest\_WD**: Total minutes of break-time within MVPA bouts using only valid weekend days.
- **bt\_MVPA\_WD**: Total minutes of moderate to vigorous activity (excluding break-time) within MVPA bouts, using only valid weekend days.
- **bt\_MPA\_WD**: Total minutes of moderate activity within MVPA bouts, using only valid weekend days.
- **bt\_VPA\_WD**: Total minutes of vigorous activity within MVPA bouts, using only valid weekend days.

