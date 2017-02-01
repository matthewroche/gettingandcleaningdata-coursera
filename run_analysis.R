library("dplyr")
##
## Start with "UCI HAR Dataset" folder in working directory
##
###################################################################################################################
## Merge training and test data sets
###################################################################################################################
dataTrain <- tbl_df(read.table("UCI HAR Dataset/train/X_train.txt"))
dataTest <- tbl_df(read.table("UCI HAR Dataset/test/X_test.txt"))
dataMerge <- rbind(dataTrain, dataTest)
rm(dataTrain, dataTest)

subjectTest <- tbl_df(read.table("UCI HAR Dataset/test/subject_test.txt"))
subjectTrain <- tbl_df(read.table("UCI HAR Dataset/train/subject_train.txt"))
subjectMerge <- rbind(subjectTrain, subjectTest)
subjectMerge <- rename(subjectMerge, Subject = V1)
rm(subjectTrain, subjectTest)

activityTest <- tbl_df(read.table("UCI HAR Dataset/test/y_test.txt"))
activityTrain <- tbl_df(read.table("UCI HAR Dataset/train/y_train.txt"))
activityMerge <- rbind(activityTrain, activityTest)
activityMerge <- rename(activityMerge, Activity = V1)
rm(activityTrain, activityTest)

## Get feature names, make valid and apply to data columns
features <- read.table("UCI HAR Dataset/features.txt")
features$V2 <- make.names(features$V2, unique = T)
colnames(dataMerge) <- features$V2
rm(features)

## Final combination of columns
finalData <- cbind(dataMerge, activityMerge, subjectMerge)
rm(dataMerge, activityMerge, subjectMerge)

###################################################################################################################
## Extract only the measurements on the mean and standard deviation for each measurement
###################################################################################################################

meanStdData <- select(finalData, contains("mean"), contains("std"), Subject, Activity)
rm(finalData)

###################################################################################################################
## Use descriptive activity names to name the activities in the data set
###################################################################################################################

activityTable <- read.table("UCI HAR Dataset/activity_labels.txt")
meanStdData <- mutate(meanStdData, Activity = activityTable[Activity,2])
rm(activityTable)

###################################################################################################################
## Appropriately label the data set with descriptive variable names
###################################################################################################################

colnames(meanStdData) <- gsub("^t", "Time.", names(meanStdData))
colnames(meanStdData) <- gsub("^f", "FDS.", names(meanStdData))
colnames(meanStdData) <- gsub("^angle", "Angle", names(meanStdData))
colnames(meanStdData) <- gsub("mean", "Mean.", names(meanStdData))
colnames(meanStdData) <- gsub("std", "SD.", names(meanStdData))
colnames(meanStdData) <- gsub("BodyBody", "Body", names(meanStdData))
## Remove unecessary double dots
colnames(meanStdData) <- gsub("\\.\\.+", ".", names(meanStdData))
colnames(meanStdData) <- gsub("\\.$", "", names(meanStdData))
## Some specific changes for the angle column names
colnames(meanStdData) <- gsub("tBody", "Time.Body", names(meanStdData))
colnames(meanStdData) <- gsub("\\.*(?<!\\.)Mean", ".Mean", names(meanStdData), perl = T)

###################################################################################################################
## Create a second, independent tidy data set with the average of each variable for each activity and each subject
###################################################################################################################

newData <- gather(meanStdData, key = Subject, value = Activity)
colnames(newData) <- c("Subject", "Activity", "Variable", "Value")
newData <- group_by(newData, Subject, Activity, Variable)
newData <- summarise(newData, Mean = mean(Value))
newData <- spread(newData, key = Variable, value = Mean)

# Save new table
write.table(newData, "TidyData.txt", row.name=FALSE)