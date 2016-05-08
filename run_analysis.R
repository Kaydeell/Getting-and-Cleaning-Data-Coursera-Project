#load packages to be used
library(dplyr)
library(reshape2)

#set the working directory, download the dataset and unzip it
setwd("C:/Users/Kari/Documents")

file <- "dataset.zip"

if (!file.exists(file)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, file, mode = "wb")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(file) 
}

###1.Merge the training and the test sets to create one data set.

#read features and activity files and change activity column names
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
colnames(activitylabels) = c("ActivityID", "Activity")
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#read train dataset and rename columns
trainset <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
trainlabels <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = "ActivityID")
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectID")

#read test dataset and rename columns
testset <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
testlabels <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = "ActivityID")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectID")

#merge by columns train dataset and test datasets separately
traindata <- cbind(trainset,trainlabels,trainsubjects)
testdata <- cbind(testset,testlabels,testsubjects)

#merge train and test datasets into one
datasets <- rbind(traindata,testdata)

###2.Extract only the measurements on the mean and standard deviation for each measurement.

#subset measurements on mean and standard deviation, making sure to keep the Columns SubjectID and ActivityID
mergeddata <- datasets[grepl("[Mm]ean|[Ss]td|SubjectID|ActivityID", names(datasets))]


### 3. Use descriptive activity names to name the activities in the data set.
#merge the subset with the activitylabels to get descriptive activity names
data <- merge(mergeddata, activitylabels, by = "ActivityID")

### 4.Appropriately label the data set with descriptive variable names.
#Change column names of the data set
datanames <- colnames(data)

datanames <- gsub("\\.", "", datanames)
datanames<- gsub("mean","Mean",datanames)
datanames <-  gsub("^(t)","Time",datanames)
datanames<- gsub("std","StDeviation",datanames)
datanames <-  gsub("^(f)","Freq",datanames)
datanames <- gsub("angle","Angle",datanames)
datanames <- gsub("gravity","Gravity",datanames)
datanames <- gsub("Acc","Accel",datanames)

colnames(data) = datanames


### 5. From the data set in step 4, creates a second, independent tidy data set
###  with the average of each variable for each activity and each subject.

#Remove ActivityId column
data <- select(data, -ActivityID)

#Convert in factor Activity and SubjectId to use in melt function
data$Activity <- factor(data$Activity)
data$SubjectId <- factor(data$SubjectID)

#Melt the data and create new data frame with the average of each variable for each activity and each subject.
melted <- melt(data, id = c("SubjectId", "Activity"))
tidydata <- ddply(melted, .(SubjectId, Activity, variable), summarize, mean = mean(value))

#Write a table with the tidy data.
write.table(tidydata, "tidy.txt", row.names = FALSE, quote = FALSE)
