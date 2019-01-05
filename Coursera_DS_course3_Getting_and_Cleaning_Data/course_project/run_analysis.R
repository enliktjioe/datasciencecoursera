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

library(data.table)
library(dplyr)



# Read traning data
df_training_subject <- fread("./course_project/UCI HAR Dataset/train/subject_train.txt")
df_training_set <- fread("./course_project/UCI HAR Dataset/train/X_train.txt")
df_training_label <- fread("./course_project/UCI HAR Dataset/train/y_train.txt")

# Read test data
df_test_subject <- fread("./course_project/UCI HAR Dataset/test/subject_test.txt")
df_test_set <- fread("./course_project/UCI HAR Dataset/test/X_test.txt")
df_test_label <- fread("./course_project/UCI HAR Dataset/test/y_test.txt")

# Read features
features <- read.table("./course_project/UCI HAR Dataset/features.txt", as.is = TRUE)

# Read activity labels
activity_labels <- fread("./course_project/UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activityId", "activityLabel")


## Task 1 - Merges the training and the test sets to create one data set
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





