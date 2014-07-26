# create working directory
 tmpdir <- "tmp";
 working_dir <- file.path(".", tmpdir);
 dir.create(working_dir, showWarnings = FALSE)

# 
 unzip("0Dataset.zip", exdir=working_dir);
 setwd(working_dir)

#1. Merges the training and the test sets to create one data set.

#REMOVEME
working_dir  <- "tmp";

#load labels
dataset_dir <- file.path(working_dir, "UCI HAR Dataset");
labels_file <- file.path(dataset_dir, "activity_labels.txt");
labels <- read.table(labels_file, stringsAsFactors=FALSE);


test_dir <- file.path(dataset_dir, "test");
train_dir <- file.path(dataset_dir, "train");

xtest_file <- file.path(test_dir, "X_test.txt");
ytest_file <- file.path(test_dir, "y_test.txt");

test_measures <- read.table(xtest_file, stringsAsFactors=FALSE);
test_labels <- read.table(ytest_file, stringsAsFactors=FALSE);
test_label_string <- merge(labels, test_labels, by.x="V1", by.y="V1");

test_measures$Activity <- label_string$V2;


#2. Extracts only the measurements on the mean and standard deviation for each measurement.


#3. Uses descriptive activity names to name the activities in the data set

features_file <- file.path(dataset_dir, "features.txt");
features <- read.table(features_file, stringsAsFactors=FALSE);

#4. Appropriately labels the data set with descriptive variable names.
#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

