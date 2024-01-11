# This is the code book for the Getting and Cleaning Data Course Project

The run_analysis.R script uses the following variables:

* x.train is the training set from "UCI HAR Dataset/train/X_train.txt"
* x.test is the test set from "UCI HAR Dataset/train/X_train.txt"
* x.merged is the merged training and test sets
* feature.names is the vector of features from "UCI HAR Dataset/features.txt".
It is modified by concatenating "x", "y", or "z" to features that were originally
recorded with three axis labels. The axis labels were lost when calculating
variables in the dataset
* non.unique.rows is the table of features that are supposed to have "x", "y", 
or "z". This table was used to modify feature.names
* y.train is the vector of training labels from "UCI HAR Dataset/train/y_train.txt"
* y.test is the vector of test labels from "UCI HAR Dataset/test/y_test.txt"
* y.merged is the merged vector of training and test labels
* activity.labels is the vector of activity labels from 
"UCI HAR Dataset/activity_labels.txt"
* x.named is the x.merged dataset with activity.labels vector as the activity_name column 
* subject.train is the vector of training set subject names from
"UCI HAR Dataset/train/subject_train.txt"
* subject.test is the vector of test set subject names
from  "UCI HAR Dataset/test/subject_test.txt"
* subject.merged is merged subject.train and subject.test
* tidy.data is the tidy data set with the average of each variable for
each activity and each subject.
* tidy.data.wide is tidy.data in a wide format

The summaries that were calculated in run_analysis.R:
* mean and standard deviation for each feature: mean() and sd() with summarise()
from dplyr on "x.merged". It uses across() to calculate these statistics for each column
* average of each variable for each activity and each subject:
mean() with summarise() on tidy.data grouped by "subject.id", "activity_name",
and "feature" columns 
