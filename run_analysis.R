#set the correct Working Directory
setwd("../c3pa")

# 1. Merge the training and the test sets to create one data set.

#Get test data

# get X_test.txt data
x_test <- read.delim("./UCI_HAR_Dataset/test/X_test.txt", header = F, sep = "")

# get y_test.txt
y_test <- read.delim("./UCI_HAR_Dataset/test/y_test.txt", header = F, sep = "")

  
# get subject test data
subject_testData <- read.delim("./UCI_HAR_Dataset/test/subject_test.txt", header = F, sep = "")

# get testdata, clipping x_test and y_test together
testData <- cbind(x_test, y_test, subject_testData)


# get X_train.txt data
x_train <- read.delim("./UCI_HAR_Dataset/train/X_train.txt", header = F, sep = "")

# get y_train.txt
y_train <- read.delim("./UCI_HAR_Dataset/train/y_train.txt", header = F, sep = "")

# get subject test data
subject_trainData <- read.delim("./UCI_HAR_Dataset/train/subject_train.txt", header = F, sep = "")

# get train data, clipping x_test and y_test
trainData <- cbind(x_train, y_train, subject_trainData)



#clip trainData and testData together to create the resulting test+train data set 
testAndTrainData <- rbind(testData, trainData)

#2. Extract only the measurements on the mean and standard
# deviation for each measurement. 
# get the columns that have measurements on the mean and standard deviation 
# for each measurement, based on the /UCI_HAR_Dataset/features.txt file. 

# To select the appropriate column names, the function getMeanandStdColNames
# uses regular expressions. 

features <- read.table("./UCI_HAR_Dataset/features.txt", colClasses = c("integer", "character"))
getMeanandStdColNames <- function(features ){
  
  # get a data frame with the col number and var name, from the features.txt file
  
  
  #get the number of rows of the features
  l <- nrow(features)
  
  #create an empty vector to hold the results
  col <- vector(mode = "integer")
  
  #loop
  for (i in 1:l){
    #if there is a regular expression match, the result != -1
    # we're looking for "mean*" and "std*" patterns
    if (regexec("mean*", features[i,2], ignore.case = T) != -1 | regexec("std*", features[i,2], ignore.case = T) != -1 )
      
      #append to the col vector the col number of features
      col <- append(col, features[i,1])
  } 
  

  
  #return a vector with all the var names that have "mean*" or "std*"
  return(col)
}


#Invoke the getMeanandStdColNames() function and get the numbers of the columns
# of interest
col <- getMeanandStdColNames(features)



#Add the column number 562 to the col vector, corresponding 
# to the activity numbers
col <- append(col, c(562, 563))

#meanAndStdData stores the mean and std deviation
# data of the whole data set. 

testAndTrainData <- testAndTrainData[,col]

# 4. put a label to all columns
names(testAndTrainData) <- features[col,2]


# 3. Put descriptive activity names to activities
#  This function returns a data frame with the propper Activity labels
# based on the activity numbers
addActivityLabels <- function(dataset){
  
  
  activityLabel <- vector(mode="character", length=nrow(dataset)-1)
  
  activityLabelsCol <- data.frame(activityLabel, stringsAsFactors = F)
  
  rows <- nrow(dataset)
  
  for (i in 1:rows){
    if (dataset[i,87] == 6)
      activityLabelsCol[i,1] <- "LAYING"
    if (dataset[i,87] == 5)
      activityLabelsCol[i,1] <- "STANDING"
    if (dataset[i,87] == 4)
      activityLabelsCol[i,1] <- "SITTING"
    if (dataset[i,87] == 3)
      activityLabelsCol[i,1] <- "WALKING_DOWNSTAIRS"
    if (dataset[i, 87] == 2)
      activityLabelsCol[i,1] <- "WALKING_UPSTAIRS"
    if (dataset[i,87] == 1)
      activityLabelsCol[i,1] <- "WALKING"
  }
  

  
  return(activityLabelsCol)
}

# invoke the testAndTrainData function and store into a temp var "o"
o <- addActivityLabels(testAndTrainData)

# clip together the "o" data frame and the data set
testAndTrainData <- cbind(testAndTrainData, o)

#set labels
# set correct labels to activities and subject columns
colnames(testAndTrainData)[c(87,88)] <- c("Activities", "Subject")


#5. create a tidy independent data set with the average of each variable for
#  each activity and each subject

averagePerActivityAndSubject <- ddply(testAndTrainData, c("Subject", "Activities"),  function(x){
  
  #create an empty data frame with 86 cols (86 is the number of variables)
  df <- as.data.frame(matrix(ncol=86))
  
  length <- 86
  
  #loop for every x col
  for (i in 1:length){
    #set the col name
    colnames(df)[i] <- paste("Average Of", colnames(x)[i], sep = " ")
    
    #fill the resulting data frame
    df[1, i] = mean(x[,i])
  }
  #return the resulting  data frame
  df
  
  
})
write.table(averagePerActivityAndSubject, row.names = F, file = "./averagePerActivityAndSubject.txt" )
