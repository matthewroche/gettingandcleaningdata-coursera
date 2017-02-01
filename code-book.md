# Code Book for run_analysis.R

This code book details the data created by the run_analysis.R script. See readme.md for details of how to run this script and an overview of its steps. The code book modifies and updates the details found within the original data set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

# Overview of data

The data set contains 180 rows and 88 columns. The data is structured in a 'tidy data' format. See here for details: ftp://cran.r-project.org/pub/R/web/packages/tidyr/vignettes/tidy-data.html

For each subject and activity there are 86 features. These features contain the mean and standard deviation for a series of readings whilst each subject is performing each activity. Details of the meanings for each column name are found below.

# Details of data collection

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

# Columns

* Subject
An integer (1 to 30) identifying the subject from whom the readings originated.

* Activity
A string identifying the activity performed by the subject when the readings were taken.

* Columns 3:88
These columns contain the feature details. Each column name contains details of how the feature was calculated. 
  * Angle: 
  * Time: 
  * Mean: 
  * FDS: 
  * SD: 
  * X / Y / Z: 
