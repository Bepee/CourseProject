##
## See associated Readme.md file
##
  

  ## Step 1a: combine available test data sets

    setwd("C:\\Users\\IBM_ADMIN\\Documents\\data\\R-projects\\Course 3\\Course Project\\Data\\UCI HAR Dataset\\test")
    subject_test <- read.table("subject_test.txt")
    x_test <- read.table("x_test.txt")
    y_test <- read.table("y_test.txt")
    test <- cbind(subject_test,y_test,x_test)

  ## Step 1b: combine available training data sets

    setwd("C:\\Users\\IBM_ADMIN\\Documents\\data\\R-projects\\Course 3\\Course Project\\Data\\UCI HAR Dataset\\train")
    subject_train <- read.table("subject_train.txt")
    x_train <- read.table("x_train.txt")
    y_train <- read.table("y_train.txt")
    train <- cbind(subject_train,y_train,x_train)

  ## Step 1c: merge the resulting training and test data sets

    table <- rbind(train,test)

  ## Step 2a: load the dataset with feature labels

    setwd("C:\\Users\\IBM_ADMIN\\Documents\\data\\R-projects\\Course 3\\Course Project\\Data\\UCI HAR Dataset")
    labels <- read.table("features.txt")

  ## Step 2b: select the candidate and activity code (first two columns)

    table2 <- table[,c(1,2)]
    colnames(table2) <- c("Subject","Action")

  ## Step 2c: loop through the labels and select those columns from table that contain
  ##          either mean() or std() features

    message("Selecting mean() features:")
    message()

    i <- 1
    for (n in 1:561) {
      str <- "mean()"
      if (grepl(str,labels[n,2])) {
        message(labels[n,1]," - ",labels[n,2])
        col <- labels[n,1]+2
        table2 <- cbind(table2,table[,col])
        colnames(table2)[2+i] <- as.character(labels[n,2])
        i <- i + 1
      }
    }
    
    message()
    message("Selecting std() features")
    message()

    for (n in 1:561) {
      str <- "std()"
      if (grepl(str,labels[n,2])) {
        message(labels[n,1]," - ",labels[n,2])
        col <- labels[n,1]+2
        table2 <- cbind(table2,table[,col])
        colnames(table2)[2+i] <- as.character(labels[n,2])
        i <- i + 1
      }
    }
    
  ## Step 3: add description action names
  ##         use the table "activity_labels.txt"
  ##         use inner join like merging
  ##         drop the Action column, now represented by Action_label
    
    al <- read.table("activity_labels.txt")
    colnames(al) <- c("Action","Action_label")
    table2 <- merge(table2,al,by = "Action")
    table2 <- table2[,-1]
    
  ## Step 4: Apply mean to all columns
  ##         in groups defined by Subject and Action_label
  ##         Make sure Subject is a factor, split requires it
  ##         When splitting at more than one level...
  ##         interactions may create empty levels => drop these
    
    table2$Subject <- factor(table2$Subject)
    s <- split(table2,list(table2$Subject,table2$Action_label),drop = TRUE)
    
  ##         Apply colMeans to the feature columns
    
    t <- sapply(s, function(x) colMeans(x[, c(2:80)]))
    
  ## Step 5: Write the resulting matrix to a csv output file
    
    write.table(t,file="outfile.csv",sep=",",row.names=FALSE)
  
    
    
