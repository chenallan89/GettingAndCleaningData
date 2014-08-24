# 
# File: run_analysis.R
# 
# Coursera Getting and Cleaning Data Course Project Script
# for August 2014 session
#

# load the plyr library for split-apply-combine operations
library(plyr)

#
# Constants
#
testDataFile       <- "./data/test/X_test.txt"
testLabelFile      <- "./data/test/y_test.txt"
testSubjectFile    <- "./data/test/subject_test.txt"

trainDataFile      <- "./data/train/X_train.txt"
trainLabelFile     <- "./data/train/y_train.txt"
trainSubjectFile   <- "./data/train/subject_train.txt"

activityLabelFile  <- "./data/activity_labels.txt"
featureFile        <- "./data/features.txt"

outputFile         <- "./data/Mean-and-StdDev-by-Sub-and-Act.txt"

#
# Make sure we have our data!
#

fileList <- c(testDataFile, testLabelFile, testSubjectFile, 
              trainDataFile, trainLabelFile, trainSubjectFile, 
              activityLabelFile, featureFile)

missingData <- 0
for (i in fileList){
    if(!file.exists(i)){
        print(paste0("Data file ", i, " is missing"))
        missingData <- 1
    }
}

# exit if the data is missing
if(missingData != 0){ stop("Error: Cannot continue with missing data.")}

#
# Load the data into apprpriate containers
#

activityLabels <- read.table(activityLabelFile)[,2]
features <- as.character(read.table(featureFile)[,2])

XtestData <- read.table(testDataFile, col.names=features)
XtestLabels <- read.table(testLabelFile)
XtestSubject <- read.table(testSubjectFile)
XtestData <- data.frame(Activity = XtestLabels[,1], XtestData)
XtestData <- data.frame(Subject = XtestSubject[,1], XtestData)


XtrainData <- read.table(trainDataFile, col.names=features)
XtrainLabels <- read.table(trainLabelFile)
XtrainSubject <- read.table(trainSubjectFile)
XtrainData <- data.frame(Activity = XtrainLabels[,1], XtrainData)
XtrainData <- data.frame(Subject = XtrainSubject[,1], XtrainData)

#
# Merge the data seta
#

XfullData <- merge(XtestData, XtrainData, all=TRUE, sort=FALSE)

#
# create a new data set from the columns we are interested in.
#

XMeanAndStdDevData <- XfullData[,grep("Subject|Activity|.mean.|.std.", colnames(XfullData))]

#
# Reduce the data by subsetting the columns by activity and subject then average each 
# subset column

XMeanAndStdDevAve <- ddply(XMeanAndStdDevData, .(Activity,Subject), colMeans)

#
# Reorder the final data set so that we are ordered by subject.
#

XMeanAndStdDevAve <- XMeanAndStdDevAve[with(XMeanAndStdDevAve, order(Subject)),]

#
# Replace the numerical values in the activity column with the values from the activityLabels. The
# column needs to be cast as a factor first for this to work.
#

XMeanAndStdDevAve$Activity <- as.factor(XMeanAndStdDevAve$Activity)
levels(XMeanAndStdDevAve$Activity) <- activityLabels

#
# Create the clean data set file
#

write.table(XMeanAndStdDevAve, outputFile, row.names=FALSE)
