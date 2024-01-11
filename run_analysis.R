library(dplyr)
library(tidyr)
# Importing data ####
## Import the training set ####
x.train<-read.table("UCI HAR Dataset/train/X_train.txt",header=F,sep = "")
## Import the test set ####
x.test<-read.table("UCI HAR Dataset/test/X_test.txt",header=F,sep = "")
# 1. Merging the training and the test sets to create one data set.####
x.merged<-rbind(x.train,x.test)

# 2. Extracting only the measurements on the mean and standard deviation for each measurement. ####
x.merged%>%
  summarise(across(V1:V561,mean))
x.merged%>%
  summarise(across(V1:V561,sd))

# 3. Using descriptive activity names to name the activities in the data set ####
## Import feature names ####
feature.names<-read.table("UCI HAR Dataset/features.txt",header=F,sep = "")
colnames(feature.names)<-c("feature.id","feature")
# We need to add X, Y, Z to features like fBodyAcc-bandsEnergy()
# extract non-unique rows
non.unique.rows<-feature.names%>%
  group_by(feature)%>%
  filter(n()>1)%>% # take non-unique features (those with x, y, z)
  arrange(feature)%>%
  mutate(axis=c("X","Y","Z"))%>% # add a column called axis
  unite("feature",feature:axis) # concatenate columns
# Join with the dataframe
feature.names<-feature.names%>%
  group_by(feature)%>%
  filter(n()==1)%>%
  bind_rows(non.unique.rows)%>%
  arrange(feature.id)

feature.names<-as.character(feature.names$feature)
head(feature.names)

## Import the training labels ####
y.train<-read.table("UCI HAR Dataset/train/y_train.txt",header = F)
## Import the test labels ####
y.test<-read.table("UCI HAR Dataset/test/y_test.txt",header = F)
## Merge them ####
y.merged<-rbind(y.train,y.test)
colnames(y.merged)<-"id"
## Import six activity labels ####
activity.labels<-read.table("UCI HAR Dataset/activity_labels.txt",header=F,sep = "")
colnames(activity.labels)<-c("id","activity_name")
## Create a data frame of activity labels ####
activity.labels<-y.merged%>%
  right_join(activity.labels,by="id")

## Name the activities in the data set ####
x.named<-cbind(activity.labels$activity_name,x.merged)

# 4. Label the data set with descriptive variable names.####
# Don't forget that we have activity.labels before the 561 variables
colnames(x.named)<-c("activity_name",feature.names)
head(x.named)

# 5. From the data set in step 4, create a second, independent tidy data set with ####
# the average of each variable for each activity and each subject. ####
## Add subject names ####
subject.train<-read.table("UCI HAR Dataset/train/subject_train.txt",header = F)
subject.test<-read.table("UCI HAR Dataset/test/subject_test.txt",header = F)
subject.merged<-rbind(subject.train,subject.test)
colnames(subject.merged)<-"subject.id"
x.named<-cbind(subject.merged,x.named)
tidy.data<-x.named%>%
  pivot_longer(cols=-c(subject.id,activity_name),
               names_to = "feature",
               values_to = "value")%>%
  group_by(subject.id,activity_name,feature)%>%
  summarise(mean.value=mean(value))
# Convert into wide format and order columns according to the original dataframe
tidy.data.wide<-tidy.data%>%
  pivot_wider(names_from = feature,
              values_from = mean.value)
tidy.data.wide<-tidy.data.wide[colnames(x.named)]
