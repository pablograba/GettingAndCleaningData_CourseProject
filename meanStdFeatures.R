ddply(t1, c("Subject", "Activities"),  function(x){
  
  #create an empty data frame with 86 cols (86 is the number of variables)
  df <- as.data.frame(matrix(ncol=86))
  
  length <- 86
  #loop for every x col
  for (i in 1:length){
    #set the col name
    colnames(df)[i] <- paste("Mean Of", colnames(x)[i], sep = " ")
    
    #fill the resulting data frame
    df[1, i] = mean(x[,i])
  }
  #return the resulting data frame
  df
  
  
})