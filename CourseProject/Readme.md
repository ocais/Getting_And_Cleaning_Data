
#Getting and Cleaning Data: Course Project Readme

##R Code: run_analysis.R

##General Description:  
* This project is to demonstrate how to collect, work with, and clean a data set.
 
* The goal is to prepare tidy data that can be used for later analysis. 

* The data used in this project is a from wearable computing platform.

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones “”



* The script data for the project is taken from the link below: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



##Script “run_analysis.R” Steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Usage:

1. Down the “getdata-projectfiles-UCI HAR Dataset.zip” from the link above.
2. Extract the ‘UCI HAR Dataset” folder to the folder than contains the run_analyis.r script.
3. Run the run_analyis.r script.
4. The script will create a “TidyDataSet.txt” output file.

##Output:

* A description of the script output file is included in this repository in the “CodeBook.md” file.
