
# 1. Create Data Table from files - Train  & Test File Sets

# Read list of all features e.g.tBodyAcc-mean()-X, etc.
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
# Read list of all activity labels e.g.WALKING
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Read Test Measurements
xtest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
ytest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Read Train Measurements
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)

colnames(subject_test)  <- "subject"
colnames(subject_train)  <- "subject"


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
toMatch <- c("mean", "std")
matches <- unique (grep(paste(toMatch,collapse="|"), features$V2, value=TRUE))
colnames(xtest)  <- features$V2 
colnames(ytest)  <- "activity_label_id"
colnames(xtrain)  <- features$V2
colnames(ytrain)  <- "activity_label_id"


# 3. Uses descriptive activity names to name the activities in the data set
xtest$Activity <- activity_labels[ytest$activity_label_id, 2]
xtest$Subject <- subject_test$subject
xtest$Type <- "test"

xtrain$Activity <- activity_labels[ytrain$activity_label_id, 2]
xtrain$Subject <- subject_train$subject
xtrain$Type <- "train"

matches <- append(matches,"Activity")
matches <- append(matches,"Subject")
matches <- append(matches,"Type")



xtotal <- rbind(xtest,xtrain)
xstats <- xtotal[,matches]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(xstats) <- gsub('[-()]', '', colnames(xstats))
colnames(xstats) <- gsub('mean', 'Mean', colnames(xstats))
colnames(xstats) <- gsub('std', 'StdDev', colnames(xstats))
colnames(xstats) <- gsub('BodyBody', 'Body', colnames(xstats))
colnames(xstats) <- gsub('Mag', 'Magnitude', colnames(xstats))
#Readme - vector of features was obtained by calculating variables from the time and frequency domain 
colnames(xstats) <- gsub("^(t)","time",colnames(xstats))
colnames(xstats) <- gsub("^(f)","freq",colnames(xstats))


# .5 Creates an independent tidy data set with the average of each variable for each activity and each subject
#attach(xstats)
aggdata <-aggregate(xstats, by=list("Activity(Group)"= Activity,"Subject(Group)"=Subject), FUN=mean, na.rm=TRUE)
#detach(xstats)

# Remove unused columns fater running aggregrate
aggdata$Activity <- NULL
aggdata$Subject <- NULL
aggdata$Type <- NULL


# Write tidy data set
write.table(aggdata, file = "TidyDataSet.txt",row.names=FALSE, na="",col.names=TRUE, sep="\t")




