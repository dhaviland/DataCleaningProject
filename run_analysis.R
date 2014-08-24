#run_analysis.R
#Creation: 08/24/2014
#Author: XYZ

#This script processes a set of data files to extract a summary means of
#data set vaiables based on a subject id and activity. It assumes the 
#following data sets are present in the local working director.
#
#       y_test.txt
#       subject_test.txt
#       x_test.txt
#       y_train.txt
#       subject_train.txt
#       X_train.txt
#       activity_labels.txt
#       features.txt
#
#
#The output of this script is the following text file saved in the
#local working directory
#
#      dataSummary.txt
#
#For a more complete description of the processing done, consult the README.md
# file. For more info describing the data inputs and the results produced by
#this script, Check the project codebook included in this repository.
#
#      Accelerometer Project Codebook        
#
#
#
#Start by loading the input dataset
testActivityData<-read.table("./y_test.txt")
testSubjectData<-read.table("./subject_test.txt")
testData<-read.table("./x_test.txt")
#collect training data
trainingActivityData<-read.table("./y_train.txt")
trainingSubjectData<-read.table("./subject_train.txt")
trainingData<-read.table("./X_train.txt")
#get activity labels list
filename<-"./activity_labels.txt"
con<-file(filename)
activityLegend<-readLines(con)
close(con)   
#get variable names list
filename<-"./features.txt"
con<-file(filename)
variableNames<-readLines(con)
close(con)
#
#merge (subject,activity,data) from test sets
mergedTestData <-cbind(testSubjectData,testActivityData,testData)
#merge (subject,activity,data) from training sets
mergedTrainingData <-cbind(trainingSubjectData,trainingActivityData,trainingData)
#merge combined training and test sets
mergedData<-rbind(mergedTrainingData,mergedTestData)
#select columns which are a mean or standard deviation by their names
columnsToSelect<-grepl("mean|std",variableNames)
#now add the subject id and acitivty code to column selections
columnsToSelect2<-c(TRUE,TRUE,columnsToSelect)
#use this to select only deired columns of the merged data sets
desiredData<-mergedData[,columnsToSelect2]

#build variable names for selected columns from variable names file
#get data column names
selectedColumnNames<-variableNames[grepl("mean|std",variableNames)]
#remove numbers
selectedColumnNames<-gsub("[0-9]| ","",selectedColumnNames)
#remove "()"
selectedColumnNames<-gsub("[()]","",selectedColumnNames)
#remove "-"
selectedColumnNames<-gsub("-","",selectedColumnNames)
#convert to lowercase
selectedColumnNames<-tolower(selectedColumnNames)
#finally, add names for the subject id column and subject activity
finalnames<-c("id","activity",selectedColumnNames)
#set table column variable names
names(desiredData)<-finalnames
#convert activity codes to activity names
desiredData$activity[desiredData$activity=="1"]<-"walking"
desiredData$activity[desiredData$activity=="2"]<-"walking upstairs"
desiredData$activity[desiredData$activity=="3"]<-"walking downstairs"
desiredData$activity[desiredData$activity=="4"]<-"sitting"
desiredData$activity[desiredData$activity=="5"]<-"standing"
desiredData$activity[desiredData$activity=="6"]<-"laying"
#convert the activity column values to factors
desiredData[,2]<-as.factor(desiredData[,2])

#now find means of variables within data grouped by "id" and "activity"
dataSummary<-aggregate(desiredData[,3:81],by=list(desiredData$id,desiredData$activity),FUN=mean)
# fixup column names
names(dataSummary)<-finalnames

#write the data set
write.table(dataSummary,file="./dataSummary.txt",row.names=FALSE)
