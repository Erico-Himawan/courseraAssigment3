#loading required package

library(dplyr)

#setting file name
fileName <- "Coursera_Assigment3.zip"

#Downloading archive if none exist
if (!file.exists(fileName))
  {
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, fileName, method="curl")
  }  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}

#importing data from txt files

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code") 

#1. Merge the training and the test sets to create one data set

X <- rbind(x_train,x_test)
Y <- rbind(y_train,y_test)
Subject <- rbind(subject_train,subject_test)
merged_DF <- cbind(Subject,X,Y)

#2. Extracts only the measurements on meand and standard deviations for each measurement
tidy_DF <- merged_DF %>% select(subject,code,contains("mean"),contains("std"))

#3. Use descriptive activity names to name the activities in the data set
tidy_DF$code <- activities[tidy_DF$code, 2]

#4. Appropriately labels the data set with descriptive variable names
names(tidy_DF)[2] = "Activity"
names(tidy_DF) <- gsub("Acc","Accelerometer", names(tidy_DF))
names(tidy_DF) <- gsub("Gyro", "Gyroscope", names(tidy_DF))
names(tidy_DF) <- gsub("BodyBody", "Body", names(tidy_DF))
names(tidy_DF) <- gsub("Mag", "Magnitude", names(tidy_DF))
names(tidy_DF) <- gsub("^t", "Time", names(tidy_DF))
names(tidy_DF) <- gsub("^f", "Frequency", names(tidy_DF))
names(tidy_DF) <- gsub("tBody", "TimeBody", names(tidy_DF))
names(tidy_DF) <- gsub("-mean()", "Mean", names(tidy_DF), ignore.case = TRUE)
names(tidy_DF) <- gsub("-std()", "STD", names(tidy_DF), ignore.case = TRUE)
names(tidy_DF) <- gsub("-freq()", "Frequency", names(tidy_DF), ignore.case = TRUE)
names(tidy_DF) <- gsub("angle", "Angle", names(tidy_DF))
names(tidy_DF) <- gsub("gravity", "Gravity", names(tidy_DF))

finalData <- tidy_DF %>%
  group_by(subject, Activity) %>%
  summarise_all(funs(mean))
write.table(finalData, "finalData.txt", row.names = FALSE)
