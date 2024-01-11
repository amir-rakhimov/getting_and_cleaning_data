# README file for the Getting and Cleaning Data Course Project
The project repo contains the following files and directories:
* UCI HAR dataset: directory with all the data used in the project
* CodeBook.md: the code book
* run_analysis.R: the R script that analyses the data

The run_analysis.R performs the following operations:
1. Merges the training and the test sets to create one data set.  
It uses the rbind() function for merging

2. Extracts only the measurements on the mean and standard deviation for each measurement.   
It uses dplyr summarise() with mean() and sd(). The operation is done column-wise
using across(V1:V561) which corresponds to column indices

3. Uses descriptive activity names to name the activities in the data set  
It extracts features that originally contained "x", "y", and "z" in their name,
adds these axis labels to make feature names unique, then inserts 
into the original vector of features. This is important for renaming the 
columns of the final data frame

4. Appropriately labels the data set with descriptive variable names.   
It adds the columns with subject IDs and activity names to the merged
data set (from step 1).  
Then, it renames features with labels from step 3.

5. From the data set in step 4, creates a second, independent tidy data set
with the average of each variable for each activity and each subject.  
It converts the data set into a long format with pivot_longer(), 
and computes mean value using summarise(mean()), grouping by subject ID, 
activity name, and feature label.  
Finally, it converts the tidy data set into a wide format with pivot_wider()