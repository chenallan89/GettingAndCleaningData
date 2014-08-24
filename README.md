# Getting and Cleaning Data Course Project

This repository is the course project repo for the Coursera "Getting and Cleaning Data" course from August 2014

## Background & Requirements

From the project description, the purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. Required submissions are:

1. A tidy data set as described below
2. A link to a Github repository with the script for performing the analysis
3. A code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md

In addition, there is also a README.md (this file) in the repo with the script which explains how the script works. As there is no supporting scripots, no interconnect flow description is necessary.  


## R Script Objectives

The repo contains one R script called run_analysis.R that performs the following functions: 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. The data set is to be written as a txt file created with write.table() using row.name=FALSE 


## The Script

The script, run_analysis.R manages the required objectives by first checking for the required files in the *data* directory, aborting with anappropriate message if they are not present. Once the files have been detected, it loads the training data into a data frame and the test data into an additional one.


## Procedure

Before you start, you will need to download the data set and extract it to a working directory. In my case the working directory is *~/cousera/datascience/project*. I renamed the "UCI HAR Dataset" directory to "data" for simplicity sake.

As this was all performed on an Apple Mac, the following commands may not be exactly the same for other platforms. They should work equally well for a linux/bsd/solaris box, but probably not for a windows box.

Clone the repo to the working directory and from the command line execute the script 
  $ Rscript run_analysis.R
  
Once the command line comes back, you should have the tidied data set written to the data directory called Mean-and-StdDev-by-Sub-and-Act.txt. You can perform a quick visual check with the following command:
  $ head ./data/Mean-and-StdDev-by-Sub-and-Act.txt
  
Given that there are 6 activities and 30 subjects, the resulting file should have 180 rows of data
  $ wc -l ./data/Mean-and-StdDev-by-Sub-and-Act.txt



## The Data Set

The data used for this project was obtained from the University of California Irvine. The data URL is:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

This data set represents data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the following URL:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

A detailed description of the data set in in the [CodeBook](./CodeBook.md) associated with this project. The only portions we are concerned with for the scope of this project are:

* './data/features_info.txt': Shows information about the variables used on the feature vector.
* './data/features.txt': List of all features.
* './data/activity_labels.txt': Links the class labels with their activity name.
* './data/train/X_train.txt': Training set.
* './data/train/y_train.txt': Training labels.
* './data/test/X_test.txt': Test set.
* './data/test/y_test.txt': Test labels.
