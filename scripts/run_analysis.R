
library(dplyr)

## LOAD DATA ##

# file load details

# train
train_subjects <- read.table("data/UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("data/UCI HAR Dataset/train/X_train.txt", colClasses=rep("numeric", 561), nrows=7352)
y_train <- read.table("data/UCI HAR Dataset/train/y_train.txt", colClasses=rep("integer"), nrows=7352)

# test
test_subjects <- read.table("data/UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("data/UCI HAR Dataset/test/X_test.txt", colClasses=rep("numeric", 561), nrows=2947)
y_test <- read.table("data/UCI HAR Dataset/test/y_test.txt", colClasses=rep("integer"), nrows=2947)

# metadata
activity_labels <- read.table("data/UCI HAR Dataset/activity_labels.txt")
features_text <- read.table("data/UCI HAR Dataset/features.txt")


## STEPS 1 & 2 ##

## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement.



#filter only the mean and standard deviation for each measurement
relevant.features <- grep("mean|std", features_text[,2])

x_train <- x_train[,relevant.features] 
x_test <- x_test[,relevant.features] 

#column bind the data + labels for train and test, respectively
train_set <- cbind(train_subjects, x_train, y_train)
test_set <- cbind(test_subjects, x_test, y_test)

merged <- rbind(train_set, test_set)


## STEPS 3 & 4 ##

## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names


#add descriptive variable names
colnames(merged) <- c("Subject", as.character(features_text[relevant.features,2]), "Activity")

#replace integer labels with descriptive activity names
merged$Activity = factor(merged$Activity, levels=as.integer(activity_labels[,1]), labels=as.character(activity_labels[,2]))

## STEP 5 ## 
## From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject.



