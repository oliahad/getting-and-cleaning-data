##  Peer Assessments/Getting and Cleaning Data Course Project
##  Data Science Specialization, Johns Hopkins University (Coursera.org)
##  The purpose of this project is to demonstrate our ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

##  One of the most exciting areas in all of data science right now is wearable computing.
##  Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.



##  TASKS
##  1. Merges the training and the test sets to create one data set
##  2. Extracts only the measurements on the mean and standard deviation for each measurement
##  3. Uses descriptive activity names to name the activities in the data set
##  4. Appropriately labels the data set with descriptive variable names
##  5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject



##  PREPARATION
##  Set working directory and install/load "plyr" library

setwd("C:/OliA/Getting and Cleaning Data, Johns Hopkins University (coursera.org)/Course Project/UCI HAR Dataset")
getwd()

install.packages("plyr")
library(plyr)



##  TASK-1 Merges the training and the test sets to create one data set

xTrain = read.table("train/X_train.txt")
yTrain = read.table("train/y_train.txt")
subjectTrain = read.table("train/subject_train.txt")

xTest = read.table("test/X_test.txt")
yTest = read.table("test/y_test.txt")
subjectTest = read.table("test/subject_test.txt")

xData = rbind(xTrain, xTest)
yData = rbind(yTrain, yTest)

mergedData = rbind(subjectTrain, subjectTest)



##  TASK-2. Extracts only the measurements on the mean and standard deviation for each measurement

features = read.table("features.txt")

extractMeanSDFeatures = grep("-(mean|std)\\(\\)", features[, 2])
xData = xData[, extractMeanSDFeatures]
names(xData) = features[extractMeanSDFeatures, 2]



##  TASK-3. Uses descriptive activity names to name the activities in the data set

activities = read.table("activity_labels.txt")

yData[, 1] = activities[yData[, 1], 2]
names(yData) = "activity"



##  TASK-4. Appropriately labels the data set with descriptive variable names

names(mergedData) = "subject"
outputData = cbind(xData, yData, mergedData)



##  TASK-5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

tidyAveragesData = ddply(outputData, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidyAveragesData, "tidy_averages_data.txt", row.name=FALSE)



##  Check and review data
##  22 Mar 2015