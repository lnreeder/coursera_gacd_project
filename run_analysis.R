library(plyr);

# create working directory
 tmpdir <- "tmp";
 working_dir <- file.path(".", tmpdir);
 dir.create(working_dir, showWarnings = FALSE)

#extract package 
 unzip("0Dataset.zip", exdir=working_dir);

#1. Merges the training and the test sets to create one data set.


#load labels
dataset_dir <- file.path(working_dir, "UCI HAR Dataset");
labels_file <- file.path(dataset_dir, "activity_labels.txt");
labels <- read.table(labels_file, stringsAsFactors=FALSE);


test_dir <- file.path(dataset_dir, "test");

xtest_file <- file.path(test_dir, "X_test.txt");
ytest_file <- file.path(test_dir, "y_test.txt");

test_measures <- read.table(xtest_file, stringsAsFactors=FALSE);
test_labels <- read.table(ytest_file, stringsAsFactors=FALSE);
test_measures$Activity <- test_labels$V1;

train_dir <- file.path(dataset_dir, "train");
xtrain_file <- file.path(train_dir, "X_train.txt");
ytrain_file <- file.path(train_dir, "y_train.txt");

#read training data and append labels to it
train_measures <- read.table(xtrain_file, stringsAsFactors=FALSE);
train_labels <- read.table(ytrain_file, stringsAsFactors=FALSE);
train_measures$Activity <- train_labels$V1;


#append train to test
test_and_train_measures <- rbind(test_measures, train_measures);


#2. Extracts only the measurements on the mean and standard deviation for each measurement.

features_file <- file.path(dataset_dir, "features.txt");
features <- read.table(features_file, stringsAsFactors=FALSE);

#vector of indices for features that are the mean
mean_idx <- grep(".*mean().*", features$V2);
#vector of indices for features that are the stddev
std_idx <- grep(".*std().*", features$V2);
#appendand sort to get stddev AND mean indices
std_or_mean_idx <- sort(append(mean_idx, std_idx));

#add Activity column (very last one) since we will need that one too
std_or_mean_and_activity_idx <- append(std_or_mean_idx, ncol(test_and_train_measures))

std_or_mean_measures <- test_and_train_measures[std_or_mean_and_activity_idx];


#3. Use descriptive activity names to name the activities in the data set
measure_activities <- data.frame(std_or_mean_measures$Activity);
colnames(measure_activities) <- c("V1");


#standard merge function reorders the rows, with no way to prevent it
#label_string <- merge(labels, measure_activities, sort=FALSE,by.x="V1", by.y="V1");
#instead use plyr's join function
label_string <- join(measure_activities, labels by="V1");
std_or_mean_measures$Activity <- label_string$V2;

#4. Appropriately labels the data set with descriptive variable names.

#get the std/mean names from the full features list and
#reset the data frame names
descriptive_variables <- features[std_or_mean_idx,2];
descriptive_variables <- append(descriptive_variables, c("Activity"))
colnames(std_or_mean_measures) <- descriptive_variables;


##WRITE IT OUT
dataset1 <- file.path(working_dir, "dataset1.csv");
write.csv(std_or_mean_measures, row.names=FALSE, file = dataset1)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subject_test_file <- file.path(test_dir, "subject_test.txt");
subject_test <- read.table(subject_test_file, stringsAsFactors=FALSE);

subject_train_file <- file.path(train_dir, "subject_train.txt");
subject_train <- read.table(subject_train_file, stringsAsFactors=FALSE);

#build subject in order that data was appended - test first, then train
subjects <- rbind(subject_test, subject_train);
std_or_mean_measures$Subject <- subjects;



