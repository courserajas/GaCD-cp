# GaCD-cp
courserajas' Coursera Getting and Cleaning Data course project

## User guide

Script: run_analysis.R

### Description:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Input:
This script takes following files as an input. Files are read automatically i.e. there is no need to specify them separately but ensure that they are in working directory. See README.txt of belowmentioned zip file for description of each file

* X_test.txt
* y_test.txt
* subject_test.txt
* X_train.txt
* y_train.txt
* subject_train.txt
* features.txt
* activity_labels.txt

Input data for the script can be acquired from here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

After extracting the zip file, place following files into working directory
of this script:

* X_test.txt
* y_test.txt
* subject_test.txt
* X_train.txt
* y_train.txt
* subject_train.txt
* features.txt
* activity_labels.txt

### Output:

run_analysis.R generates two files into working directory. They are:
* std_mean_data.txt
* tidy_mean_data.txt

see codebook.md for description of the files


