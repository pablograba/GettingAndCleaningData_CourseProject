---
title: "CodeBook"
output: html_document
---



- Data set averagePerActivityAndSubject: is the tidy and independent data set containing data set with the average of each variable for each activity and each subject.
 Description of variables:

  - Subject:  id of the subject
  - Activities: id of the activity . 
  - "Average of " X, where X is the name of the variables gotten from the testAndTrainData data set.  

- Data set testAndTrainData: is the data set gotten from the raw data provided.
 Description of variables: 

 - Activities: id of the activity.
 - Subject: id of the Subject
 - activityLabel: the label of the Activity
 - rest of the variables: match the names of variables gotten from features.txt, related to the mean and std deviation of the measures. Examples: 
 -  "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y"
