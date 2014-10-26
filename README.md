GettingAndCleaningData
======================

This repo contains the code for "Getting and Cleaning Data" Course Project

run_analysis.R is the script used to process data collected from the accelerometers from the Samsung Galaxy S smartphone.
The data is taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and full description of the data is available at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

R package reqiured - dplyr
The script performs the following processing:

1. Merge the training and the test sets to create data set x, y and subject
Refer to features.txt and features_info.txt from the original data set for details on variables in x

2. Extract x_mean_ord_std from x -- measurements on the mean and standard deviation for each measurement. 
Only column names containing explicit function names mean() or std() have been included,
ie. column names such as ***Mean and mean***() have not been included

3. Use labels from activity_labels.txt to name the activities in y and combine with subject and x_mean_or_std

4. Label the data set with descriptive variable names taken from features.txt

5. From the data set in step 4, create avg_data containing the average of each variable for each activity and each subject.

6. Create file avg_data.txt, which can be read using the command 
avg_data <- read.table("avg_data.txt", header = TRUE)
