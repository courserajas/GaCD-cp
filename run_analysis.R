###############################################################################
#
# Script: run_analysis.R
#
# Description:
#    1. Merges the training and the test sets to create one data set.
#    2. Extracts only the measurements on the mean and standard deviation for 
#       each measurement. 
#    3. Uses descriptive activity names to name the activities in the data set
#    4. Appropriately labels the data set with descriptive variable names. 
#    5. From the data set in step 4, creates a second, independent tidy data 
#       set with the average of each variable for each activity and each subject.
#
# Input:
#   This script takes following files as an input. Files are read automatically
#   i.e. there is no need to specify them separately but ensure that they are
#   in working directory. See README.txt of belowmentioned zip file for 
#   description of each file
#
#   X_test.txt
#   y_test.txt
#   subject_test.txt
#   X_train.txt
#   y_train.txt
#   subject_train.txt
#   features.txt
#   activity_labels.txt
#
# Output:
#
#
# Input data for the script can be aquired from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# After extracting the zip file, place following files into working directory 
# of this script:
#
#   X_test.txt
#   y_test.txt
#   subject_test.txt
#   X_train.txt
#   y_train.txt
#   subject_train.txt
#   features.txt
#   activity_labels.txt
#
###############################################################################

# input files
file_x_test <- "X_test.txt"
file_y_test <- "y_test.txt"
file_subject_test <- "subject_test.txt"
file_x_train <- "X_train.txt"
file_y_train <- "y_train.txt"
file_subject_train <- "subject_train.txt"
file_features <- "features.txt"
file_activities <- "activity_labels.txt"

# read feature names
features <- read.table(file_features, header=FALSE)

# read test and training data and bind them together
data <- read.table(file_x_test, header=FALSE)
data <- rbind(data, read.table(file_x_train, header=FALSE))

# set column names of data according features
colnames(data) <- features[,2]

# drop all columns except ones having data of mean or standard deviation
# NOTE: ignoring "Mean" in column name as those column do not represent
#       mean value but angle values
keep <- grep("mean|std", colnames(data))
data <- data[keep]

# read activity labels
activities <- read.table(file_activities, header=FALSE)

# read test and training activity information and bind them together
act_data <- read.table(file_y_test, header=FALSE)
act_data <- rbind(act_data, read.table(file_y_train, header=FALSE))

# traverse through training activity information and add a corresponding 
# activity name as a new column. Use activity label data for lookup
for ( i in 1:nrow(act_data) ) {
  act_data[i,2] <- activities[act_data[i,1],2]
}

# add corresponding activity information to the left of each row
data <- cbind(activity = act_data[,2], data)

# read test and training subject (person) information and bind them together
sub_data <- read.table(file_subject_test, header=FALSE)
sub_data <- rbind(sub_data, read.table(file_subject_train, header=FALSE))

# add corresponding subject information to the left of each row
data <- cbind(subject = sub_data[,1], data)

# Store data into file
write.table(data, "std_mean_data.txt", quote=FALSE, row.names=FALSE)

# create an empty data frame for tidy data
tidydata <- data.frame()

# loop through every subject
for ( subject in 1:30 ) {
  # loop through every activity for a particular subject
  for ( act in 1:6 ) {
    # get a name of an activity to be used in following subset
    actLabel <- activities[act, "V2"]
    
    # get a data for one subject and for one activity
    subActData <- subset(data, data$subject == 1 & data$act == actLabel)
    
    # calculate an average for each column excluding first and second column
    # as they are subject and activity columns
    means <- colMeans(subActData[,3:ncol(subActData)])
    
    # add a row having subject, its activity and respective averages into
    # tidydata data frame.
    row <- cbind(subject, actLabel, t(means))
    tidydata <- rbind(tidydata, row[1,])
  }
}

colnames(tidydata) <- colnames(data)

# Store data into file
write.table(data, "tidy_mean_data.txt", quote=FALSE, row.names=FALSE)
