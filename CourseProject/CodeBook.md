




# General Input Data Description

* The script data for the project is taken from the link below: 
		
		https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
		
From "UCI HAR Dataset\readme", we can deduce the following:

* The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years.
* Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* The measurements were taken with the subjects wearing a smartphone (Samsung Galaxy S II) on the waist.
* The dataset was captured using its embedded accelerometer and gyroscope, it captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
* The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
* From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 
* A Subject - An identifier of the subject or person who carried out the experiment.



## UCI HAR Dataset Folder

Description of data contained in the "UCI HAR Dataset" folder:

* README.txt
* activity_labels.txt : Description of activity id & activity description e.g. 1 WALKING 2 WALKING_UPSTAIRS
* features_info.txt: Shows information about the variables used on the feature vector.
* features.txt: List of all features. Label name for each measurement e.g. tBodyAcc-mean()-X
* train/X_train.txt: Training set. Measurements that correspond to feature labels.
* train/y_train.txt: Training labels. List of activities corresponding to measurements.
* test/X_test.txt: Test set. Measurements that correspond to feature labels
* test/y_test.txt: Test labels. List of activities corresponding to measurements.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.

* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.


##Script “run_analysis.R” Variables:
* features 			contains data from "UCI HAR Dataset/features.txt", header = FALSE)
* activity_labels 	contains data from "UCI HAR Dataset/activity_labels.txt", header = FALSE)
* xtest 			contains data from "UCI HAR Dataset/test/X_test.txt" file.
* ytest 			contains data from "UCI HAR Dataset/test/y_test.txt" file.
* subject_test 		contains data from "UCI HAR Dataset/test/subject_test.txt" file.
* xtrain  			contains data from "UCI HAR Dataset/train/X_train.txt" file.
* ytrain 			contains from from "UCI HAR Dataset/train/y_train.txt" file.
* subject_train 	contains data from "UCI HAR Dataset/train/subject_train.txt" file.
* xtotal			Total data from xtest & xtrain with activity description instead of activity id. 
					Correct columns names for each measurement. Most column names from features variable.
* xstats			Subset of xtotal. Contains only mean and standard deviation for each measurement.
* aggdata			Independent tidy data set with the average of each variable for each activity and each subject.


##Script “run_analysis.R” Steps:

1. Merges the training and the test sets to create one data set.

		* Uses "xtotal <- rbind(xtest,xtrain)" to merge both data sets.
		
2. Extracts only the measurements on the mean and standard deviation for each measurement.

		The following code is used to extract only field names that contain mean or standard deviation.
		*	toMatch <- c("mean", "std")
		*   matches <- unique (grep(paste(toMatch,collapse="|"), features$V2, value=TRUE))
		The filed list,matches, is then used in the following code to extract the desired fields:
		xstats <- xtotal[,matches]
		
3. Uses descriptive activity names to name the activities in the data set

			used the following code for this task:
			xtest$Activity <- activity_labels[ytest$activity_label_id, 2]
			xtrain$Activity <- activity_labels[ytrain$activity_label_id, 2]

	Also was test column describe was it test or train data.
			
4. Appropriately labels the data set with descriptive variable names. 

		The gosub function was used to replace field name text with easier to read text.e.g.
			colnames(xstats) <- gsub('[-()]', '', colnames(xstats))
			colnames(xstats) <- gsub('mean', 'Mean', colnames(xstats))
			colnames(xstats) <- gsub('std', 'StdDev', colnames(xstats))
			
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
		Used the aggregate fucntion for this purpose as follows:
		aggdata <-aggregate(xstats, by=list("Activity(Group)"= Activity,"Subject(Group)"=Subject), FUN=mean, na.rm=TRUE)




