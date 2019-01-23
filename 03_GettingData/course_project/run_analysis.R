## Getting and Cleaning Data Course Project
#
## OVERVIEW
# The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. 
# The goal is to prepare tidy data that can be used for later analysis.
# 
# All datasets come from: (Samsung Galaxy SII on waist)
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
# 
# A full description about dataset available here:
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

library(dplyr)

# Read traning data
df_training_subject <- read.table("./course_project/UCI HAR Dataset/train/subject_train.txt")
df_training_set <- read.table("./course_project/UCI HAR Dataset/train/X_train.txt")
df_training_label <- read.table("./course_project/UCI HAR Dataset/train/y_train.txt")

# Read test data
df_test_subject <- read.table("./course_project/UCI HAR Dataset/test/subject_test.txt")
df_test_set <- read.table("./course_project/UCI HAR Dataset/test/X_test.txt")
df_test_label <- read.table("./course_project/UCI HAR Dataset/test/y_test.txt")

# Read features
features <- read.table("./course_project/UCI HAR Dataset/features.txt", as.is = TRUE)

# Read activity labels
activity_labels <- read.table("./course_project/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activityId", "activityLabel")


## Task 1
## Merges the training and the test sets to create one data set
# concatenate individual data tables to make single data table
humanActivity <- rbind(
  cbind(df_training_subject, df_training_set, df_training_label),
  cbind(df_test_subject, df_test_set, df_test_label)
)

# remove individual data tables to save memory
rm(df_training_subject, df_training_set, df_training_label,
    df_test_subject, df_test_set, df_test_label)

# assign column names
colnames(humanActivity) <- c("subject", features[,2], "activity")

## Task 2
## Extracts only the measurements on the mean and standard deviation 
## for each measurement

# determine columns of data set to keep based on column name...
columnsToKeep <- grepl("subject|activity|mean|std", colnames(humanActivity))

# ... and keep data in these columns only
humanActivity <- humanActivity[, columnsToKeep]
humanActivity

## Task 3
## Uses descriptive activity names to name the activities in the data set

# replace activity values with named factor levels
humanActivity$activity <- factor(humanActivity$activity,
                                  levels = activity_labels[, 1], 
                                  labels = activity_labels[, 2])
humanActivity$activity


## Task 4
## Appropriately labels the data set with descriptive variable names

# get column names
humanActivityCols <- colnames(humanActivity)

# remove special characters ( ) -
humanActivityCols <- gsub("[\\(\\)-]", "", humanActivityCols)

# expand abbreviations and clean up names
humanActivityCols <- gsub("^f", "frequencyDomain", humanActivityCols)
humanActivityCols <- gsub("^t", "timeDomain", humanActivityCols)
humanActivityCols <- gsub("Acc", "Accelerometer", humanActivityCols)
humanActivityCols <- gsub("Gyro", "Gyroscope", humanActivityCols)
humanActivityCols <- gsub("Mag", "Magnitude", humanActivityCols)
humanActivityCols <- gsub("Freq", "Frequency", humanActivityCols)
humanActivityCols <- gsub("mean", "Mean", humanActivityCols)
humanActivityCols <- gsub("std", "StandardDeviation", humanActivityCols)

# fix typo
humanActivityCols <- gsub("BodyBody", "Body", humanActivityCols)

# use new labels as column names
colnames(humanActivity) <- humanActivityCols
colnames(humanActivity)


## Task 5
## From the data set in step 4, creates a second, independent tidy data set
## with the average of each variable for each activity and each subject.

# group by subject and activity and summarise using mean
humanActivityMeans <- humanActivity %>%
                        group_by(subject, activity) %>%
                        summarise_all(funs(mean))

# output to file "tidy_data.txt"
write.table(humanActivityMeans, "./course_project/tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
