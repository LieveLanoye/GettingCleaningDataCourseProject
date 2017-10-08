## scripts of Getting and Cleaning Data Course Project

## Step 1 : read the date from the original files and merges the training and the test sets to create one data set.
  
  #read data from the needed files, for description of the parameters, cfr the code book
    features <- read.table("./UCI HAR Dataset/features.txt", as.is=TRUE)
    activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", as.is=TRUE)

    data_train <- read.table("./UCI HAR Dataset/train/X_train.txt", as.is=TRUE)
    labels_train <- read.table("./UCI HAR Dataset/train/y_train.txt", as.is=TRUE)
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", as.is=TRUE)
    
    data_test <- read.table("./UCI HAR Dataset/test/X_test.txt", as.is=TRUE)
    labels_test <- read.table("./UCI HAR Dataset/test/y_test.txt", as.is=TRUE)
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", as.is=TRUE)
  
  #last check on the dimensions before merging into a unified set
    dim(data_train)
    dim(labels_train)
    dim(subject_train)
    dim(data_test)
    dim(labels_test)
    dim(subject_test)
  
  #merging into a dataset, first columns are subject and activity, followed by measured data
    test_train_subj_label_data <- rbind(
      cbind(subject_test, labels_test, data_test),
      cbind(subject_train, labels_train, data_train)
    )


## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement
  
  # get column names in place. I use "mean_" in front of the first two columns so they would survive the filtering using grepl later-on. I need to replace the names later-on anyhow
    colname_intermediate <- c("mean_subject", "mean_activity_label", features$V2)
    colnames(test_train_subj_label_data) <- colname_intermediate
  
  # check which column names have either "mean" or "std" in the name and subset the dataframe to those
    test_train_mean_std_columns <- colname_intermediate[which(grepl("(mean)|(std)", colnames(test_train_subj_label_data)))]
    test_train_subj_label_data_mean_std <- test_train_subj_label_data[ , test_train_mean_std_columns]

## Step 4 : Appropriately labels the data set with descriptive variable names.
  #I take this first to stop the labelling on the "mean" hack
    
    colname <- colnames(test_train_subj_label_data_mean_std)
    
    #revert the "mean"-hack in the first columns  
    colname <- gsub("mean_subject", "subject", colname)
    colname <- gsub("mean_activity_label", "activityLabel", colname)
    
    #extend the names so the meaning is clear
    colname <- gsub("Acc", "Accelerometer", colname)
    colname <- gsub("^f", "frequency", colname)
    colname <- gsub("Gyro", "Gyroscope", colname)
    colname <- gsub("Mag", "Magnitude", colname)
    colname <- gsub("^t", "time", colname)
    
    #Assuming BodyBody is supposed to be Body in the last cases
    colname <- gsub("BodyBody", "Body", colname)    
    
    colnames(test_train_subj_label_data_mean_std) <- colname
  
    
## Step 3 : Uses descriptive activity names to name the activities in the data set
  # extract the original column
    test_train_subj_label_data_mean_std$activityLabel <- factor(
      test_train_subj_label_data_mean_std$activityLabel,
      levels = activity_labels$V1,
      labels = activity_labels$V2
    )

## Step 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # create .csv file from tidy data
    write.table(test_train_subj_label_data_mean_std, "tidy_data.txt", row.names=FALSE, quote=FALSE)
    
