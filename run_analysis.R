library(plyr)

## Download and unzip the UCI HAR Dataset

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Check for adequate memory

if( !dir.exists("./data")) { 
    dir.create("./data") 
}

dateDownloaded <- date()
download.file(fileUrl,destfile = "./data/UCI_HAR_Dataset.zip", mode='wb')
dateDownloaded

z=unzip("./data/UCI_HAR_Dataset.zip",exdir = "./data")

## Read in the features data file. This data will provide the initial column
## names for the merged dataset and will also be used to determine which 
## columns to extract (any column containing mean() or std() )
fname           <- "./data/UCI HAR Dataset/features.txt"
features        <- read.table(fname)
names(features) <- c("id","feature")
i               <- grep("mean\\(",features$feature)
i2              <- grep("std\\(",features$feature)
extractCols     <- c(i,i2)
cnames          <- as.character(features[,2])

## Read in the subject data files
stestname  <- "./data/UCI HAR Dataset/test/subject_test.txt"
strainname <- "./data/UCI HAR Dataset/train/subject_train.txt"
stestdata  <- read.table(stestname)
straindata <- read.table(strainname)

## Read in the activity labels table
afilename             <- "./data/UCI HAR Dataset/activity_labels.txt"
activityLabels        <- read.table(afilename)
names(activityLabels) <- c("activityid","activityname")

## Read in the X data files ...
xtestname  <- "./data/UCI HAR Dataset/test/X_test.txt"
xtrainname <- "./data/UCI HAR Dataset/train/X_train.txt"
xtestdata  <- read.table(xtestname, col.names = cnames)
xtraindata <- read.table(xtrainname, col.names = cnames)

## Read in the y data files
ytestname  <- "./data/UCI HAR Dataset/test/y_test.txt"
ytrainname <- "./data/UCI HAR Dataset/train/y_train.txt"
ytestdata  <- read.table(ytestname)
ytraindata <- read.table(ytrainname)

## Merge the files (for xdata, only merge the measurements we want to extract)
all_X                 <- rbind(xtestdata[,extractCols],xtraindata[,extractCols])
all_y                 <- rbind(ytestdata,ytraindata)
all_subject           <- rbind(stestdata,straindata)
names(all_y)          <- c("activityName")
names(all_subject)    <- c("subjectId")
all_data              <- cbind(all_y,all_subject,all_X)

## Perform the summarization analysis
averages <- ddply(all_data, .(activityName,subjectId), colMeans)

## Tidy up the column names a bit
colnames(averages)    <- gsub("^f","freq",colnames(averages))
colnames(averages)    <- gsub("^t","time",colnames(averages))
colnames(averages)    <- gsub("\\.","",colnames(averages))
colnames(averages)    <- gsub("Acc","Accelerometer",colnames(averages))
colnames(averages)    <- gsub("mean","Mean",colnames(averages))
colnames(averages)    <- gsub("std","Std",colnames(averages))
averages$activityName <- activityLabels[averages$activityName,2]

## Output the file to the working directory
filename <- "UCI_HAR_Mean_and_Std_Averages.txt"
write.table(averages, file=filename, row.name=FALSE)

