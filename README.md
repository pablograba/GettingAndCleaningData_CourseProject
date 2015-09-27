# GettingAndCleaningData_CourseProject
This theCoursers'a  GettingAndCleaningData CourseProject Repo.

===========================================
Coursera Getting and Cleanning data course. 
Course Project Script 

Pablo Graterol
sept 2015
===========================================
The run_analysis script does the following:
- sets the correct Working Directory

- Merges the training and the test sets to create one data set.
  - getting the  test and train data, cliping together the x_test and y_test data and then getting the subject test data.

-  Extracts only the measurements on the mean and standard deviation for each measurement. 
-  gets the columns that have measurements on the mean and standard deviation for each measurement, based on the /UCI_HAR_Dataset/features.txt file. 

-  To select the appropriate column names, the function getMeanandStdColNames
 uses regular expressions. 

- Puts descriptive activity names to activities

- Creates a tidy independent data set with the average of each variable for
each activity and each subject

