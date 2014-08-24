# Code Book for the Getting and Cleaning Data Course Project

This is the description document for the course project. 

## R script run_analysis.R

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

## Code execution

This is a short output from a program run

```
$ ls
$ curl -O https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 59.6M  100 59.6M    0     0   762k      0  0:01:20  0:01:20 --:--:--  847k
$ git clone https://github.com/scott5/GettingAndCleaningData.git
Cloning into 'GettingAndCleaningData'...
remote: Counting objects: 42, done.
remote: Compressing objects: 100% (38/38), done.
remote: Total 42 (delta 11), reused 0 (delta 0)
Unpacking objects: 100% (42/42), done.
Checking connectivity... done.
$ cp GettingAndCleaningData/run_analysis.R .
$ ls
GettingAndCleaningData
getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
run_analysis.R
$ unzip getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Archive:  getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  inflating: UCI HAR Dataset/activity_labels.txt  
  inflating: UCI HAR Dataset/features.txt  
  inflating: UCI HAR Dataset/features_info.txt  
  inflating: UCI HAR Dataset/README.txt  
   creating: UCI HAR Dataset/test/
   creating: UCI HAR Dataset/test/Inertial Signals/
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt  
  inflating: UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt  
  inflating: UCI HAR Dataset/test/subject_test.txt  
  inflating: UCI HAR Dataset/test/X_test.txt  
  inflating: UCI HAR Dataset/test/y_test.txt  
   creating: UCI HAR Dataset/train/
   creating: UCI HAR Dataset/train/Inertial Signals/
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt  
  inflating: UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt  
  inflating: UCI HAR Dataset/train/subject_train.txt  
  inflating: UCI HAR Dataset/train/X_train.txt  
  inflating: UCI HAR Dataset/train/y_train.txt  
$ mv UCI\ HAR\ Dataset/ data
$ ls
GettingAndCleaningData
data
getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
run_analysis.R
$ ls data
README.txt		features.txt		test
activity_labels.txt	features_info.txt	train
$ ls data/train
Inertial Signals	X_train.txt		subject_train.txt	y_train.txt
$ ls data/test
Inertial Signals	X_test.txt		subject_test.txt	y_test.txt
$ Rscript run_analysis.R 
$ ls
GettingAndCleaningData
data
getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
run_analysis.R
$ ls data
Mean-and-StdDev-by-Sub-and-Act.txt	features_info.txt
README.txt				test
activity_labels.txt			train
features.txt
$ wc -l data/Mean-and-StdDev-by-Sub-and-Act.txt 
     181 data/Mean-and-StdDev-by-Sub-and-Act.txt
$ head -10 data/Mean-and-StdDev-by-Sub-and-Act.txt | awk '{ print $1 " " $2 " " $3 " " $4 }'
"Subject" "Activity" "tBodyAcc.mean...X" "tBodyAcc.mean...Y"
1 "WALKING" 0.277330758736842 -0.0173838185273684
1 "WALKING_UPSTAIRS" 0.255461689622641 -0.0239531492643396
1 "WALKING_DOWNSTAIRS" 0.289188320408163 -0.00991850461020408
1 "SITTING" 0.261237565425532 -0.00130828765170213
1 "STANDING" 0.278917629056604 -0.0161375901037736
1 "LAYING" 0.22159824394 -0.0405139534294
2 "WALKING" 0.276426586440678 -0.0185949199145763
2 "WALKING_UPSTAIRS" 0.247164790395833 -0.0214121132045833
2 "WALKING_DOWNSTAIRS" 0.27761534806383 -0.0226614158361702
$
```
The output file has a header line as can be seen from above, so subtracting that, we get 180 rows of data. We have 30 subjects and 6 tasks, so there should be 180 rows of results providing the Subject, Activity and the averages of the 79 standard deviation and mean columns from the original data sets.

## Input Data Set

The input data set comes from a study on human activity recognition using smartphones, a full description can be found here:
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

## Output Data Set

The output data set contains the following columns:
```
 [1] "Subject"                         "Activity"                       
 [3] "tBodyAcc.mean...X"               "tBodyAcc.mean...Y"              
 [5] "tBodyAcc.mean...Z"               "tBodyAcc.std...X"               
 [7] "tBodyAcc.std...Y"                "tBodyAcc.std...Z"               
 [9] "tGravityAcc.mean...X"            "tGravityAcc.mean...Y"           
[11] "tGravityAcc.mean...Z"            "tGravityAcc.std...X"            
[13] "tGravityAcc.std...Y"             "tGravityAcc.std...Z"            
[15] "tBodyAccJerk.mean...X"           "tBodyAccJerk.mean...Y"          
[17] "tBodyAccJerk.mean...Z"           "tBodyAccJerk.std...X"           
[19] "tBodyAccJerk.std...Y"            "tBodyAccJerk.std...Z"           
[21] "tBodyGyro.mean...X"              "tBodyGyro.mean...Y"             
[23] "tBodyGyro.mean...Z"              "tBodyGyro.std...X"              
[25] "tBodyGyro.std...Y"               "tBodyGyro.std...Z"              
[27] "tBodyGyroJerk.mean...X"          "tBodyGyroJerk.mean...Y"         
[29] "tBodyGyroJerk.mean...Z"          "tBodyGyroJerk.std...X"          
[31] "tBodyGyroJerk.std...Y"           "tBodyGyroJerk.std...Z"          
[33] "tBodyAccMag.mean.."              "tBodyAccMag.std.."              
[35] "tGravityAccMag.mean.."           "tGravityAccMag.std.."           
[37] "tBodyAccJerkMag.mean.."          "tBodyAccJerkMag.std.."          
[39] "tBodyGyroMag.mean.."             "tBodyGyroMag.std.."             
[41] "tBodyGyroJerkMag.mean.."         "tBodyGyroJerkMag.std.."         
[43] "fBodyAcc.mean...X"               "fBodyAcc.mean...Y"              
[45] "fBodyAcc.mean...Z"               "fBodyAcc.std...X"               
[47] "fBodyAcc.std...Y"                "fBodyAcc.std...Z"               
[49] "fBodyAcc.meanFreq...X"           "fBodyAcc.meanFreq...Y"          
[51] "fBodyAcc.meanFreq...Z"           "fBodyAccJerk.mean...X"          
[53] "fBodyAccJerk.mean...Y"           "fBodyAccJerk.mean...Z"          
[55] "fBodyAccJerk.std...X"            "fBodyAccJerk.std...Y"           
[57] "fBodyAccJerk.std...Z"            "fBodyAccJerk.meanFreq...X"      
[59] "fBodyAccJerk.meanFreq...Y"       "fBodyAccJerk.meanFreq...Z"      
[61] "fBodyGyro.mean...X"              "fBodyGyro.mean...Y"             
[63] "fBodyGyro.mean...Z"              "fBodyGyro.std...X"              
[65] "fBodyGyro.std...Y"               "fBodyGyro.std...Z"              
[67] "fBodyGyro.meanFreq...X"          "fBodyGyro.meanFreq...Y"         
[69] "fBodyGyro.meanFreq...Z"          "fBodyAccMag.mean.."             
[71] "fBodyAccMag.std.."               "fBodyAccMag.meanFreq.."         
[73] "fBodyBodyAccJerkMag.mean.."      "fBodyBodyAccJerkMag.std.."      
[75] "fBodyBodyAccJerkMag.meanFreq.."  "fBodyBodyGyroMag.mean.."        
[77] "fBodyBodyGyroMag.std.."          "fBodyBodyGyroMag.meanFreq.."    
[79] "fBodyBodyGyroJerkMag.mean.."     "fBodyBodyGyroJerkMag.std.."     
[81] "fBodyBodyGyroJerkMag.meanFreq.."
```
