---
title: "CodeBook"
output: pdf_document
---


## run_analysis.R

### File names
* test_data_file : test data
* train_data_file : training data
* features_file : file containing names for the different variables
* test_label_file : test label data
* train_label_file : training label data
* activity_label_file : data to link each labels with their activity name
* train_subject_file : file linking each row of train_data to the id of the corresponding subject
* test_subject_file : file linking each row of test_data to the id of the corresponding subject

### Tables
* total_data : table containing all test data and training data
* features : table containing the name of each variable
* Cols_to_keep : give the index of the columns with 'mean' or 'std' in their name
* Data_to_keep : table containing all test data and training data for the mean's and std's columns
* Colnames : give the name of each variable of Data_to_keep accordingly to features.txt (in ./UCI HAR Dataset)
* total_label : table containing the label of each row of Data_to_keep (walking, walking upstairs...)
* total_subject : table containing subject's id linked to each row of Data_to_keep
* averages : table containing average of each variable by activity by subject

### Transformations

* merged test data and training data in a table named total_data
* found columns with mean or std in their names by using grep function on features table
* extracted these columns from total_data in a new table named Data_to_keep
* constructed the total_label table
* added the unique row of this table at Data_to_keep and stored it in Data_to_keep.
* created a copy of Data_to_keep and added it the unique row of total_subject (named it temp)
* created the tables averages using chained function group_by and summarise_all to apply mean on each variable of temp group by activity and by subject.

