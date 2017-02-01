# gettingandcleaningdata-coursera
Repository of coursework for the Coursera 'Getting and Cleaning Data' course.

# About
This repository contains the files required by the final project of the Getting and Cleaning Data course on coursera. There are three files:

1. This readme.md
2. code-book.md - A code book containg details of the data set created
3. run_analysis.R - The script that creates a tidy data set from the original data

# Original data
Data source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of data source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# Goals
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

# Using the script

The run_analysis.R script assumes that the "UCI HAR Dataset" folder downloaded from the above source is present in the working directory. The only package reqired for the script to run is DPLYR, which is loaded at the start of the script.

The script contains comments explaining the steps used to complete the required goals.

The data created by the script is saved to the file "TidyData.txt" in the working directory. 

# Overview of script

* Step 1 - Merge the training and the test sets to create one data set.
This step loads the data found in the data source folder. This includes the training and test data for the features, subjects and activities. The training and test data for each of these data sets is then merged using rbind, and the column names are optomised to prevent duplicates. Finally, the three data sets are merged using cbind to create the final data set. The script cleans unused variables.

* Step 2 - Extract only the measurements on the mean and standard deviation for each measurement.
Using the DPLYR select function, we find columns that contain 'mean' or 'std' in their name and preserve only these columns, along with the subject and activity data

* Step 3 - Use descriptive activity names to name the activities in the data set
We read in the activity labels data from the original data source folder, then use the DPLYR mutate function to match activity labels to the coded integer in the original 'Activity' column.

* Step 4 - Appropriately label the data set with descriptive variable names
This step uses a series of RegEx substitutions to clean up the column names and make them more readable.

* Step 5 - Create a second, independent tidy data set with the average of each variable for each activity and each subject
We gather the data to create a narrow, tall data set. We then use group_by and summarise to find the mean of each group of subject, activity and variable. Finally we spread the data to create a proper tidy data set. There are 30 subject performing 6 activities, leading to 180 rows.
