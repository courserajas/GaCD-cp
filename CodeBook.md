# Codebook

## Introduction

`run_analysis.R` does following. See README.md for detailed description of use.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here is a more detailed description on what the script does:
Steps 1 - 4 as described above:
* Read test (`X_test.txt`) and training (`X_train.txt`) data and merges them
* Read feature names from `features.txt` and give column names to merged data from it
* Drop all columns except ones having data of mean or standard deviation. NOTE: ignoring "Mean" in column name as those column do not represent mean value but angle values.
* Read test (`y_test.txt`) and training (`y_train.txt`) activity information and bind them together 
* Traverse through training activity information and add a corresponding activity name (read from `activity_labels.txt`)as a new column.
* Read test (`subject_test.txt`) and training (`subject_train.txt`) subject (person) information and bind them together
* Add corresponding subject information to the left of each row in merged data
* Store data into file `std_mean_data.txt`
Step 5 as described above
* Calculate average of each variable for each subject and each activity and write results to file `tidy_mean_data.txt`

## Variables

`std_mean_data.txt`
* subject: a number identifying the subject (person) of measurement.
* activity: describes as a text the activity the subject has taken.
* tXXXXXXX: a number indicating the value of given sensor. Exact description of each of these variables can be found from `feature_infor.txt`, which is in archive containing the input data (`https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip`)

`tidy_mean_data.txt`
* subject: a number identifying the subject (person) of measurement.
* activity: describes as a text the activity the subject has taken.
* tXXXXXXX: a number indicating the average of each measurement for a subject for specific activity. Labeling is the same as in `std_mean_data.txt`
