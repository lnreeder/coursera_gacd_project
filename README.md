Course project for Coursera Getting and Cleaning Data
=====================================================

This is the instructions list for regenerating the tidy dataset 
required by the "Getting and Cleaning Data" course project.


Dependencies
------------
The script does not download the data.  You need to download it yourself and 
save it into a file called 0Dataset.zip.  

The scripts use the plyr package for the "join" function, which provides easy 
dataset merging without reordering rows.  Make sure you have plyr installed 
already if you don't have it by typing `install.packages("plyr")` in R.

The scripts also use the reshape2 package for dcast and melt functions.  If 
you don't have it installed, you can install with `install.packages("reshape2")`.

Generating the tidy data set
----------------------------

1. Download dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and rename to Dataset.zip
1. Place the base dataset Dataset.zip in a working folder.
2. Start R (Mac/Linux users, start R in the working folder), and then type 
`source("run_analysis.R")`
3. The script will create a working directory called "tmp", unzip the dataset 
file into it, and perform analysis.
4. The script saves two datasets in the working directory "tmp".  The first first dataset 
4. The script saves two datasets in the working directory "tmp".  The first 
dataset is the merged dataset with only mean and std measurements, as well as
activities as defined by steps 1-4 of the project.  The second dataset is the
tidy dataset called  defined by step 5 of the project.  This dataset is called `tidyset.csv', and can be loaded in a spreadsheet or in R with `read.csv("tidyset.csv")`.




