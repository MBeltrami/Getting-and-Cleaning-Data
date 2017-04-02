## Coursera - Data Science Specialization
### Course 3 - Getting and Cleaning Data
#### Peer-graded Assignment

        ## This script is used to transform the data provided for this assignment into a tidy data set.
        ## Each column represents only one variable and each row corresponds to an observation.
        ## Also we will not have duplicated columns and the names of the columns are self-explanatory.

# Libraries

        library(dplyr)
        library(data.table)

# Change WD
        
        # Used to set the folder in which the data should be downloaded

        # setwd("/Users/avlaplicativos/Google Drive/Coursera/Data Science/Getting and cleaning Data")

# Download data

        # download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./data.zip", method = "curl")

# Unzip file

        # unzip("./data.zip")

# Read files

        activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("activitylabel", "activityname"))
        
        features_name <- read.table("./UCI HAR Dataset/features.txt", col.names = c("featurenumber", "featurename"))

        # Train data

        train_time_freq_variables <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = as.character(features_name$featurename))
        
        train_activity_label <- read.table("./UCI HAR Dataset/train/Y_train.txt", col.names = "activitylabel")
        
        train_subject_identifier <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

        # Test data
        
        test_time_freq_variables <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = as.character(features_name$featurename))
        
        test_activity_label <- read.table("./UCI HAR Dataset/test/Y_test.txt", col.names = "activitylabel")
        
        test_subject_identifier <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
        
# Merge data
        
        time_freq_variables <- rbind(train_time_freq_variables, test_time_freq_variables)
        
        activity_label <- rbind(train_activity_label, test_activity_label)
        
        subject_identifier <- rbind(train_subject_identifier, test_subject_identifier)

## We will only need the mean and standard deviation from measures, so we are going to filter the columns we need
        
# Filtering data
        
        # Select the columns related to the mean and standard deviation

        columns_to_select <- features_name$featurenumber[(features_name$featurename %like% "mean" | features_name$featurename %like%  "std") & !(features_name$featurename %like%  "Jerk" | features_name$featurename %like%  "Mag"  | features_name$featurename %like%  "Freq")]
        
        time_freq_variables <- time_freq_variables[,columns_to_select]
        
## Now that our data is filtered, we are going to add two columns to our time_freq_variables data frame: one with the subject identifer and another one with the activity label.
        
        ## add activity name to the activity_label data set
        
        # Train data
        
        activity_label <- activity_label %>% inner_join(activity_labels)
        
        time_freq_variables$activityname <- activity_label$activityname
        
        time_freq_variables$subject <- subject_identifier$subject
        
        time_freq_variables <- time_freq_variables %>% select(subject, activityname, 1:(ncol(time_freq_variables)-2))
        
## Organizing the column names so they are easy to understand
        
        names(time_freq_variables)[3:length(names(time_freq_variables))] <- sub("std", "stddeviation",sub("stimed", "std", sub("gyro", "angularvelocity", sub("acc", "acceleration", sub("f", "frequency", sub("t", "time", gsub("\\.","",tolower(names(time_freq_variables)[3:length(names(time_freq_variables))]))))))))
        
## Now we have a tidy data set: each column represents only one variable and each row corresponds to an observation. Also we do not have duplicated columns and the names of the columns are self-explanatory.
        
# For the second part, we will create a second data set with the average of each variable for each subject and each activity
        
        data_set <- time_freq_variables %>% group_by(subject, activityname) %>% summarise_all(mean)
        
# Finally, we will write a txt file with our new tidy data set
        
        write.table(data_set, file = "./TidyDataSet.txt", row.names = FALSE)
        