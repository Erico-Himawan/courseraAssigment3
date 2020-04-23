My "run_analysis.R" script does the following:

1. Download the dataset
Dataset was downloaded from the URL:https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and extracted into a folder named: UCI HAR Dataset

2. Assigning each data from txt file to variables
- features <- features.txt
- activities <- activity_labels.txt
- subject_test <- subject_test.txt
- x_test <- X_test.txt
- y_test <- y_test.txt
- subject_train <- subject_train.txt
- x_train <- X_train.txt
- y_train <- y_train.txt

3. It then merge the training and test sets to create one data set
Using rbind() :
- X is created by merging x_train and x_test
- Y is created by merging y_train and y_test
- Subject is created by merging subject_train and subject_test
Using cbind() :
- merged_DF is created by merging Subject, X, and Y

4. Extracting only the measurements of mean and standard deviations for each measurement
- tidy_DF is created by subsetting merged_DF, selecting only columns: subject, code, and the measurements mean & standard deviation

5. Replacing code activity to its descriptive value
- The activity code column in the tidy_DF is replaced by its description from activities variable obtained from step 2

6. Appropriately label the data set with descriptive variable name

7. Create independent tidy dataset with average of each variable for each activity and each subject then export it to finalData.txt file