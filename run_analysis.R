setwd("e:/coursera/Work/Data-R/getdata%2Fprojectfiles%2FUCI HAR Dataset/UCI HAR Dataset")
library(plyr)
library(data.table)
subject_Train = read.table('./train/subject_train.txt',header=FALSE)
x_Train = read.table('./train/x_train.txt',header=FALSE)
y_Train = read.table('./train/y_train.txt',header=FALSE)
subject_Test = read.table('./test/subject_test.txt',header=FALSE)
x_Test = read.table('./test/x_test.txt',header=FALSE)
y_Test = read.table('./test/y_test.txt',header=FALSE)
##Merging the train and test data sets
x_Data <- rbind(x_Train, x_Test)
y_Data <- rbind(y_Train, y_Test)
subject_Data <- rbind(subject_Train, subject_Test)
x_Data_mean_std <- x_Data[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(x_Data_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2] 
y_Data[, 1] <- read.table("activity_labels.txt")[y_Data[, 1], 2]
names(y_Data) <- "Activity"
names(subject_Data)<-"Subject"
single_Data <- cbind(x_Data_mean_std, y_Data, subject_Data)
# Defining descriptive names for all variables.

names(singleData) <- make.names(names(singleData))
names(singleData) <- gsub('Acc',"Acceleration",names(singleData))
names(singleData) <- gsub('GyroJerk',"AngularAcceleration",names(singleData))
names(singleData) <- gsub('Gyro',"AngularSpeed",names(singleData))
names(singleData) <- gsub('Mag',"Magnitude",names(singleData))
names(singleData) <- gsub('^t',"TimeDomain.",names(singleData))
names(singleData) <- gsub('^f',"FrequencyDomain.",names(singleData))
names(singleData) <- gsub('\\.mean',".Mean",names(singleData))
names(singleData) <- gsub('\\.std',".StandardDeviation",names(singleData))
names(singleData) <- gsub('Freq\\.',"Frequency.",names(singleData))
names(singleData) <- gsub('Freq$',"Frequency",names(singleData))
mean_data<-aggregate(. ~Subject + Activity, singleDataSet, mean)
mean_data<-mean_data[order(mean_data$Subject,mean_data$Activity),]