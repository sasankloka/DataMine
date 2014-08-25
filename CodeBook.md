Getting and Cleaning Data Course Project CodeBook
=================================================

This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
* The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* The run_analysis.R  script performs the following steps to clean the data using analyzeMobileData function:
1. Read ./train/X_train.txt, ./train/y_train.txt,./train/subject_train.txt,./test/X_test.txt,./test/y_test.txt,./test/subject_test.txt and features.txt from the folders and store them in x_train,y_train,sub_train…etc data frame variables respectively.
2. Label the column names for x_train,x_test data frames with respective names from features data frames
3. Label the column names for subject_t* and y_t* to Subject and Activity
4. Prepare Test sets by combining the columns which have *mean*|*SD* + Subject + Activity of all the data frames based on *_test
5. Prepare Train set by combining all the columns which have *mean* + Subject + Activity of all the data frames based on *_train.
6. Merge the Test and Train sets by combing all the rows for data sets into Tidy data set.
7. Finally, aggregate the Tidy data set with group by Subject and Activity into Second Tidy data set
8. Dump Second Tidy data set into a file name which is provided as parameter of analyzeMobileData function.


Further reference: 
analyzeMobileData will take two parameter: dir which needs home path where features.txt file located, fname which is q file name for Second Tidy Data set which will be stored in homepath

Step 1 will read the files based on the fixed file format method with length of 16 x 561 for x_train and x_test variables .

Step 4 and Step 5 will clean up the raw data and pick only Mean columns with respective Subject and Activity data.


