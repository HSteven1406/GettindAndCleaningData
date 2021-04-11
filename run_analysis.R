library(dplyr)

### Preparing the dir and downloading
if(!dir.exists('./data')){
  dir.create('./data')
}
old.dir <- getwd()
setwd('./data')
url <-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if(!file.exists('Dataset.zip')){
  download.file(url,destfile='Dataset.zip')
  unzip('./Dataset.zip')
  }



### Creates the merged dataset
test_data_file <- './UCI HAR Dataset/test/X_test.txt'
train_data_file <- './UCI HAR Dataset/train/X_train.txt'


test_data <- read.table(test_data_file)
train_data <- read.table(train_data_file)
total_data <- rbind(train_data,test_data) ####Merged data


### Finds the columns whit mean or std in their names
features_file <-'./UCI HAR Dataset/features.txt'
features <- read.table(features_file)
Cols_to_keep <- grep('mean|std', features[,2])

### Extracts the columns from total_data and add names 
Data_to_keep <- total_data[,Cols_to_keep]
Colnames <- features[Cols_to_keep,2]
names(Data_to_keep) <- Colnames

### Constructs table with each label, add their respective names, binds this table with Data_to_keep
test_label_file <- './UCI HAR Dataset/test/y_test.txt'
train_label_file <- './UCI HAR Dataset/train/y_train.txt'
test_label <- read.table(test_label_file)
train_label <- read.table(train_label_file)

total_label <- rbind(train_label,test_label)
names(total_label) <- 'activity_labels'

    ### Use a for loop to change values of total_label
activity_label_file <- './UCI HAR Dataset/activity_labels.txt'
activity_labels <- read.table(activity_label_file)

for(i in 1 : length(activity_labels[,2])){
  total_label[total_label==i] <- activity_labels[i,2]
}

Data_to_keep <- cbind(Data_to_keep,total_label)

###Creates the Subject Table and adding it to total_data
temp <- Data_to_keep
train_subject_file <- './UCI HAR Dataset/train/subject_train.txt'
test_subject_file <- './UCI HAR Dataset/test/subject_test.txt'
test_subject <- read.table(test_subject_file)
train_subject <- read.table(train_subject_file)
total_subject <- rbind(train_subject,test_subject)
names(total_subject) <- 'subject'
temp <- cbind(temp,total_subject)


### Gives a new data set with average of each variable by activity by subject
averages = temp %>% group_by(activity_labels,subject) %>% summarise_all(mean)


setwd(old.dir)