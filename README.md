DataCleaningProject
===================

Data Getting and Cleaning course project repository

BLAH - location of original dataset and name of read.me and info file

##The script run_analysis.R processes a set of data files to extract a summary of
##means of data set vaiables based on a subject id and activity. It assumes the 
##following data sets are present in the local working director.

       y_test.txt
       subject_test.txt
       x_test.txt
       y_train.txt
       subject_train.txt
       X_train.txt
       activity_labels.txt
       features.txt


The output of this script is the following text file saved in the
local working directory

      dataSummary.txt

For more info describing the data inputs and the results produced by
this script, Check the project codebook included in this repository.

      Accelerometer Project Codebook        


The script "run_analysis.R" processes the data as follows:

    1)loads the input datasets, variable names, and activity legend
       y_test.txt
       subject_test.txt
       x_test.txt
       y_train.tx
       subject_train.txt
       X_train.txt
       activity_labels.txt
       features.txt"

    2) merge (subject,activity,data) from test sets
    3) merge (subject,activity,data) from training sets
    4) merge combined training and test sets
    5) from table created in step 4, select the "id" and "activity" 
        columns,as well as columns which are a mean or standard deviation
    6) clean up and add variable names to table created in step 5
    7) convert activity codes to activity names
    8) group the variables based on id and activity and calculate the means
    9) write the result to a file

