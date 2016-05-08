# Getting-and-Cleaning-Data-Coursera-Project

## Goal of the project

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 
The goal is to prepare tidy data that can be used for later analysis. 

## Information about the project

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . 
Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. 
The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.
A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Expectations of the project
You goal is to create one R script called run_analysis.R that does the following.

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity 
and each subject.

## How the project is carried out
The Repo contains a script called run_analysis.R that fullfils the expectations of the project by:
* Setting the working directory and downloading the file. In order to reproduce this experiment, you should set your correct
working directory.
* Loading the files from the UCI HAR Dataset.
* Merging the test data set by combining the columns of the files X_test, Y_test and subject_test, with the appropriate column names.
The same is done for the training data set.
* Merging the resulting training and test data sets into one.
* Extracting the measurements of mean and standard deviation in the data obtained in the previous step. Special attention is put
into not removing necessary files in the process.
* Merging the resulting data with the information from the file activity_labels to obtain descriptive activity names.
* Relabeling column names to obtain descriptive variable names.
* Removing unnecesary columns and converting "Activity" and "subjectId" into factors to be able to use the melt function, 
required to create the independent tidy data set required by the project.
* Creating a new data frame by melting the data and summarizing the information in order to retrieve the average of each variable 
for each activity and each subject.
* Creating a text file with the new tidy data set.

## Information about this Repository
This Repository contains:
* The run_analysis.R script designed to tidy the raw data provided.
* A codebook that describes the variables, the data, and any transformations or work that I performed to clean up the data.
* A Readme.md file which describes the scripts and their connection with the project.
* A tidy.txt file with the resulting tidy data set.
