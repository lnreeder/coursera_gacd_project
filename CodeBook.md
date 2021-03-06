Study Design
============

The dataset was generated by modifying the UCI HAR dataset as described in the Coursera Getting and Cleaning Data course project instructions.  See README.md and the run_analysis.R script for specific details.

Merging test and training data
------------------------------
The assignment is not clear on how to merge the test and training dataset.  However, both sets use unique participant lists, so it isn't possible to "join" on participants.  Instead, I merged the testing data with the training data to create one data frame with a set of test rows and a set of training rows.

The resulting dataset still has the same number and type of columns.

I don't indicate which rows are test and which are training in the resulting dataframe, since it is not important for the assignment.

Choosing standard deviation and average columns 
-----------------------------------------------
Although the dataset had several sources of mean and deviation measurements, I chose to use the "pure" mean and standard deviation variables, indicated by the strings mean() and stdev() in the variable names.


Code Book
=========

* Subject

  Subject performing the activity.  

* Activity
 
  Type of activity being performed.

* tBodyAcc-mean-X-mean
* tBodyAcc-mean-Y-mean
* tBodyAcc-mean-Z-mean
* tBodyAcc-std-X-mean
* tBodyAcc-std-Y-mean
* tBodyAcc-std-Z-mean
* tGravityAcc-mean-X-mean
* tGravityAcc-mean-Y-mean
* tGravityAcc-mean-Z-mean
* tGravityAcc-std-X-mean
* tGravityAcc-std-Y-mean
* tGravityAcc-std-Z-mean
* tBodyAccJerk-mean-X-mean
* tBodyAccJerk-mean-Y-mean
* tBodyAccJerk-mean-Z-mean
* tBodyAccJerk-std-X-mean
* tBodyAccJerk-std-Y-mean
* tBodyAccJerk-std-Z-mean
* tBodyGyro-mean-X-mean
* tBodyGyro-mean-Y-mean
* tBodyGyro-mean-Z-mean
* tBodyGyro-std-X-mean
* tBodyGyro-std-Y-mean
* tBodyGyro-std-Z-mean
* tBodyGyroJerk-mean-X-mean
* tBodyGyroJerk-mean-Y-mean
* tBodyGyroJerk-mean-Z-mean
* tBodyGyroJerk-std-X-mean
* tBodyGyroJerk-std-Y-mean
* tBodyGyroJerk-std-Z-mean
* tBodyAccMag-mean-mean
* tBodyAccMag-std-mean
* tGravityAccMag-mean-mean
* tGravityAccMag-std-mean
* tBodyAccJerkMag-mean-mean
* tBodyAccJerkMag-std-mean
* tBodyGyroMag-mean-mean
* tBodyGyroMag-std-mean
* tBodyGyroJerkMag-mean-mean
* tBodyGyroJerkMag-std-mean
* fBodyAcc-mean-X-mean
* fBodyAcc-mean-Y-mean
* fBodyAcc-mean-Z-mean
* fBodyAcc-std-X-mean
* fBodyAcc-std-Y-mean
* fBodyAcc-std-Z-mean
* fBodyAccJerk-mean-X-mean
* fBodyAccJerk-mean-Y-mean
* fBodyAccJerk-mean-Z-mean
* fBodyAccJerk-std-X-mean
* fBodyAccJerk-std-Y-mean
* fBodyAccJerk-std-Z-mean
* fBodyGyro-mean-X-mean
* fBodyGyro-mean-Y-mean
* fBodyGyro-mean-Z-mean
* fBodyGyro-std-X-mean
* fBodyGyro-std-Y-mean
* fBodyGyro-std-Z-mean
* fBodyAccMag-mean-mean
* fBodyAccMag-std-mean
* fBodyBodyAccJerkMag-mean-mean
* fBodyBodyAccJerkMag-std-mean
* fBodyBodyGyroMag-mean-mean
* fBodyBodyGyroMag-std-mean
* fBodyBodyGyroJerkMag-mean-mean
* fBodyBodyGyroJerkMag-std-mean

   The tBody* and fBody* variables are measurements from the UCI Har dataset which have been averaged for a given activity and subject.  See the file features_info.txt in the UCI HAR Dataset for the meaning and units for each of these variables prior to the averaging.
 

Instruction List
================
See README.md for instructions to regenerate the dataset.

