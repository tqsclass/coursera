## Coursera Getting & Cleaning Data Peer Assessment
##
## Requirements:
##  The working directory must be set to a directory that contains an
##  unzipped copy of 'UCI HAR Dataset'.  When set properly, the
##  directory will have two folders ('test' and 'train') and six *.txt
##  files with names like 'features.txt'.
##
##  This is an example from the author's Apple machine:
     setwd("~/Developer/data_science/R/Getting and Cleaning Data/UCI HAR Dataset")
##
##  Two libraries are required in your R environment:  'reshape2'
##   and 'knitr'


#### Step 0  Initialize R and Set Useful Global Data
##

## Load Required Libraries
library(reshape2)
library(knitr)

## Read column labels (e.g. feature names) for the datasets.
mean_columns <- read.table("meanFeatures.txt", sep="")
std_columns <- read.table("stdFeatures.txt", sep="")
column_numbers <- c(mean_columns[,1],std_columns[,1])
activity_labels <- read.table("activity_labels.txt",sep="")
names(activity_labels) <- c("Ordinal","Label")


#### Step 1  Process Test Data
##
##   read data file and extract columns we are interested in

raw_test <- read.table("./test/X_test.txt",sep="")
test <- raw_test[,column_numbers]

## add columns for activity and subject
test_subjects <- read.table("./test/subject_test.txt",sep="")
test_activities <- read.table("./test/y_test.txt",sep="")
test <-cbind(test_subjects,test_activities,test)
names(test) <- c("Subject","Activity",as.character(mean_columns[,2]),as.character(std_columns[,2]));

## convert activity ordinals to labels for readability, e.g. 1="WALKING"
test[,2] <- as.factor(test[,2])
levels(test[,2]) <- activity_labels[,2]

## clean up
rm(raw_test)


#### Step 2  Process Training Data
##
##   read data file and extract columns we are interested in
raw_train <- read.table("./train/X_train.txt",sep="")
train <- raw_train[,column_numbers]

## add columns for activity and subject
train_subjects <- read.table("./train/subject_train.txt",sep="")
train_activities <- read.table("./train/y_train.txt",sep="")
train <-cbind(train_subjects,train_activities,train)
names(train) <- c("Subject","Activity",as.character(mean_columns[,2]),as.character(std_columns[,2]));

## convert activity ordinals to labels for readability, e.g. 1="WALKING"
train[,2] <- as.factor(train[,2])
levels(train[,2]) <- activity_labels[,2]

## clean up
rm(raw_train)


#### Step 3 Join Files
##
##   Join both data sets and write the final working data set to disk
##   to save our results so far.

final <- rbind(train,test)
write.table(final,"final.csv",sep=", ",row.names=FALSE)


#### Step 4 Tidy Dataset
##

final_melt <- melt(final,id=c("Subject","Activity"));
tidy_data <- dcast(final_melt, Activity +Subject ~ variable,mean)
write.table(tidy_data,"tidy_data.csv",sep="' ",row.names=FALSE)

##  Here is an example of what you can do with this dataset. This line
##  gives us the quantiles of the "Mean X Body Acceleration" values
##  for all 30 subjects while 'walking':     
quantile(tidy_data[tidy_data[,1]=="WALKING",3])
##  It can help you determine if there is enough variance in this
##  measurement to be useful for classification purposes.

#### #### #### The End! #### #### ####

##  Archival Code
##  everything below here is old code used during initial development
##  saved simply for archival purposes

## alternate  (same result for std; mean has 13 additional columns)
# features <- read.table("features.txt",sep="")
# features <- features[,-1]
# mean_columns <- grep("mean",features, ignore.case=FALSE)
# std_columns <- grep("std",features, ignore.case=FALSE)

# convert activity ordinals to labels for readability
# u1 <- test[,2] == 1
# u2 <- test[,2] == 2
# u3 <- test[,2] == 3
# u4 <- test[,2] == 4
# u5 <- test[,2] == 5
# u6 <- test[,2] == 6
# 
# test[u1,2] <- as.factor(activity_labels[1,"Label"])  # coerce col from integer to character
# test[u2,2] <- as.factor(activity_labels[2,"Label"])
# test[u3,2] <- as.factor(activity_labels[3,"Label"])
# test[u4,2] <- as.factor(activity_labels[4,"Label"])
# test[u5,2] <- as.factor(activity_labels[5,"Label"])
# test[u6,2] <- as.factor(activity_labels[6,"Label"])

#sapply(final[,3:length(final)],mean)

