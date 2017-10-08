## Step 1 : read the date from the original files and merges the training and the test sets to create one data set.
    features = data frame with names of each column of data in data_train and data_test
    activity_labels = the 6 labels of activity - mapping between number and name
    
    data_train = measured data in training set
    labels_train = activity labels in training set
    subject_train = reference to subject in training set
    
    data_test = measured data in test set
    labels_test = activity labels in test set
    subject_test = reference to subject in test set  
  
    test_train_subj_label_data = merged data set, top is test data, bottom is training data. First column is subject, second is activity label, followed by measured data


## Step 2 : Extracts only the measurements on the mean and standard deviation for each measurement
  
    colname_intermediate = intermediate list of column names
    test_train_mean_std_columns = column names with "mean" or "std" in it
    test_train_subj_label_data_mean_std = subset of the data frame with, from the measured data, only mean or std deviation data

## Step 4 : Appropriately labels the data set with descriptive variable names.
    colname = intermediate storage of column names during replacement and clean up
     
## Step 3 : Uses descriptive activity names to name the activities in the data set
    no new measures, just factorizing activity label

## Step 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    tidy_data.csv = output of the script, the tidy data file
    
