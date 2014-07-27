#Source code for  Coursera "Getting and Cleaning Data" course project
#Author:  Larry Reeder
#
#Code for the most part follows Google's R style guidelines. 
#See https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml

#dependencies
library(plyr);
library(reshape2);

# create working directory
tmpdir <- "tmp";
working.dir <- file.path(".", tmpdir);
dir.create(working.dir, showWarnings = FALSE)

#extract package 
unzip("0Dataset.zip", exdir=working.dir);

#1. Merges the training and the test sets to create one data set.

#load labels
dataset.dir <- file.path(working.dir, "UCI HAR Dataset");
labels.file <- file.path(dataset.dir, "activity_labels.txt");
labels <- read.table(labels.file, stringsAsFactors=FALSE);


test.dir <- file.path(dataset.dir, "test");

xtest.file <- file.path(test.dir, "X_test.txt");
ytest.file <- file.path(test.dir, "y_test.txt");

test.measures <- read.table(xtest.file, stringsAsFactors=FALSE);
test.labels <- read.table(ytest.file, stringsAsFactors=FALSE);
test.measures$Activity <- test.labels$V1;

train.dir <- file.path(dataset.dir, "train");
xtrain.file <- file.path(train.dir, "X_train.txt");
ytrain.file <- file.path(train.dir, "y_train.txt");

#read training data and append labels to it
train.measures <- read.table(xtrain.file, stringsAsFactors=FALSE);
train.labels <- read.table(ytrain.file, stringsAsFactors=FALSE);
train.measures$Activity <- train.labels$V1;


#append train to test
test.and.train.measures <- rbind(test.measures, train.measures);


#2. Extracts only the measurements on the mean and standard deviation for each measurement.

features.file <- file.path(dataset.dir, "features.txt");
features <- read.table(features.file, stringsAsFactors=FALSE);

#vector of indices for features that are the mean
mean.idx <- grep(".*mean\\(\\).*", features$V2);
#vector of indices for features that are the stddev
std.idx <- grep(".*std\\(\\).*", features$V2);
#appendand sort to get stddev AND mean indices
std.or.mean.idx <- sort(append(mean.idx, std.idx));

#add Activity column (very last one) since we will need that one too
std.or.mean.and.activity.idx <- append(std.or.mean.idx, ncol(test.and.train.measures))

std.or.mean.measures <- test.and.train.measures[std.or.mean.and.activity.idx];


#3. Use descriptive activity names to name the activities in the data set
measure.activities <- data.frame(std.or.mean.measures$Activity);
colnames(measure.activities) <- c("V1");


#standard merge function reorders the rows, with no way to prevent it
#label.string <- merge(labels, measure.activities, sort=FALSE,by.x="V1", by.y="V1");
#instead use plyr's join function
label.string <- join(measure.activities, labels, by="V1");
std.or.mean.measures$Activity <- label.string$V2;

#4. Appropriately labels the data set with descriptive variable names.

#get the std/mean names from the full features list and
#reset the data frame names
std.or.mean.features <- features[std.or.mean.idx,2];
#add activity column
descriptive.variables <- append(std.or.mean.features, c("Activity"))
colnames(std.or.mean.measures) <- descriptive.variables;


##WRITE IT OUT
dataset1 <- file.path(working.dir, "dataset1.csv");
write.csv(std.or.mean.measures, row.names=FALSE, file = dataset1)

#5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

subject.test.file <- file.path(test.dir, "subject_test.txt");
subject.test <- read.table(subject.test.file, stringsAsFactors=FALSE);

subject.train.file <- file.path(train.dir, "subject_train.txt");
subject.train <- read.table(subject.train.file, stringsAsFactors=FALSE);

#build subject in order that data was appended - test first, then train
subjects <- rbind(subject.test, subject.train);
#add subject to our dataset
std.or.mean.measures$Subject <- subjects$V1;

#http://stackoverflow.com/questions/9723208/aggregate-multiple-variables-simultaneously was helpful here

#Use reshape2 functions to average the subject and activity over multiple 
#variables
measures.melted <- melt(std.or.mean.measures, id=c("Subject","Activity"), measured=std.or.mean.measures)
tidy.set <- dcast(measures.melted, Subject + Activity ~ variable, mean)

#write out tidy dataset
tidy.set.file <- file.path(working.dir, "tidyset.csv");
write.csv(tidy.set, row.names=FALSE, file = tidy.set.file)
