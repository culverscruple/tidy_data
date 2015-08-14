# tidy_data
run_analysis.R uses read.table to read in 6 seperate data sets provided in the UCI HAR zip: X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt.

all datasets relating to the training condition are combined with cbind and a new variable added called 'group' which serves to identify these data as relating to the training condition. Having this column allows us to keep the data in a wide, tidy format when we create our single data set from both groups. The same procedure is followed with the test data, following which both sets are combined into a single dataset ("analysis") using rbind.

The activity label data is read in from the file "features.txt" and subsetted to select only the variable containing the variable names. This vector is combined with the labels "group", "subject" and "activity" and applied to the analysis dataset as readable column names.

gsub is then employed to substitute the numeric factors (denoting the type of activity performed) for the readable descriptive names contained in the file "activity_labels.txt".

duplicate columns are removed with the "duplicated" function in preparation for the creation of the "means_n_stds" data set, which contains only those variables which contain a mean or standard deviation value. the grep function is used to identify these.

this new dataset is then grouped by the subject and activity variables (using the group_by function from the dplyr package) and the means of every variable for each group calculated using the summarise_each function in dplyr. This summary data is stored in the summarised data table and exported to a text file "tidy.txt" using write.table.
