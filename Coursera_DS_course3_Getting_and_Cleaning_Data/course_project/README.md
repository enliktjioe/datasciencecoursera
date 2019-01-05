# Coursera - Getting and Cleaning Data - course project
The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

All datasets come from: (Samsung Galaxy SII on waist)
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description about dataset available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


This repository contains the following files:

- `README.md`, this file, which provides an overview of the data set and how it was created.
- `tidy_data.txt`, which contains the data set.
- `Code_Book.md`, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
- `run_analysis.R`, the R script that was used to create the data set (see the [Creating the data set](#creating-data-set) section below) 


## How to create a tidy data set
R script `run_analysis.R` can be used to create the data set. It retrieves the source data set and transforms it to produce the final data set by implementing the following steps (see the Code book for details, as well as the comments in the script itself):

- Download data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
- Extract .zip file and put on same directory with `run_analysis.R`
- Read data.
- Merge the training and the test sets to create one merged data set.
- Extract only the measurements on the mean and standard deviation for each measurement.
- Use descriptive activity names to name the activities in the data set.
- Appropriately label the data set with descriptive variable names.
- Create a second, independent tidy set with the average of each variable for each activity and each subject.
- using write.table() using row.name=FALSE, write the data set to the `tidy_data.txt` file

The `tidy_data.txt` in this repository was created by running the `run_analysis.R` script using RStudio v1.1.463 with R v3.5.1 on Mac OSX 10.11.6
This script requires the `dplyr` package (v0.7.8 was used).