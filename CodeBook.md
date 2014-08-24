# Code Book for the Getting and Cleaning Data Course Project

## File \: run_analysis.R

This is the script that will create the final data set. It is not very complicated, it performs the
following tasks:
* Test for the data files
* Read all of the data files into tables
* Create a consolidated data set for the training and test data files
* Merge the two sets into a complete data set
* Extract the data columns we are interested in:
  * Subject
  * Activity
  * all columns that contain means
  * all columns that contain standard deviation
* Subset and reduce the data to averages for each Subject and Activity
* Reorder by Subject
* Replace the numerical values for Activity with the text versions
* Write the resulting data set to a file

### Constants used:

testDataFile - The test data set from the volunteers
testLabelFile - The column labels for the test data
testSubjectFile - The subjects for each ow of data in the test data file
trainDataFile - The training data set from the volunteers
trainLabelFile - The column labels for the training data
trainSubjectFilee - The subjects for each ow of data in the training data file
activityLabelFile - The activity descriptions for the activity numbers in the data sets
featureFile - The list of all the data points in each row
outputFile - The final tidy dataset created by the program

Output from the script will be places in the file *Mean-and-StdDev-by-Sub-and-Act.txt* in the data directory


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

## Data Set

### For each record it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Included files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Data License

The data set also comes with a license condition, specifically that the use of the dataset in publications must be acknowledged by referencing the following publication

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones
> using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
> Vitoria-Gasteiz, Spain. Dec 2012
