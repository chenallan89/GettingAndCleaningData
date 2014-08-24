# Code Book for the Getting and Cleaning Data Course Project

This is the description document for the course project. 

## File: run_analysis.R

This is the script that will create the final data set. It is not very complicated, it performs the
following tasks:
* Test for the data files
* Read all of the data files into tables
* Create a consolidated data set for the training and test data files
* Merge the two sets into a complete data set
* Extract the data columns we are interested in:
  * Subject
  * Activity
  * All columns that contain means
  * All columns that contain standard deviation
* Subset and reduce the data to averages for each Subject and Activity
* Reorder by Subject
* Replace the numerical values for Activity with the text versions
* Write the resulting data set to a file

Output from the script will be places in the file *Mean-and-StdDev-by-Sub-and-Act.txt* in the data directory

### Constants used:

* testDataFile - The test data set from the volunteers
* testLabelFile - The column labels for the test data
* testSubjectFile - The subjects for each ow of data in the test data file
* trainDataFile - The training data set from the volunteers
* trainLabelFile - The column labels for the training data
* trainSubjectFilee - The subjects for each ow of data in the training data file
* activityLabelFile - The activity descriptions for the activity numbers in the data sets
* featureFile - The list of all the data points in each row
* outputFile - The final tidy dataset created by the program

### Internal Variables:
* activityLabels - factor with the activity labels
* features - The column headers for the complete set of data points in the data set
* XtestData - The testing data set
* XtestLabels - The Activity labels for the test data
* XtestSubject - The subject numbers for the test data
* XtrainData - The training data set
* XtrainLabels - The Activity labels for the train data
* XtrainSubject - The subjec numbers for the train data
* XfullData - The full data set constructed from XTestData and XtrainData
* XMeanAndStdDevData - Subset of XfullData with just the columns we need
* XMeanAndStdDevAve - Reduced data set after subsetting and calculating the means individual subject and activity columns

## Data Set

The data set comes from a study on human activity recognition using smartphones, a full description can be found here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

As the zip file of the data contains descriptions of each data file in the set, I will not be duplicating it here. The final output file for this project contains 81 columns and 180 rows. A portion of the documentation is reproduced belowto provide an overview.

### Each record provides:

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

### Data License

The data set also comes with a license condition, specifically that the use of the dataset in publications must be acknowledged by referencing the following publication

> Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones
> using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012).
> Vitoria-Gasteiz, Spain. Dec 2012
