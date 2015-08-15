library(dplyr)

# download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "")

xtrain <- read.table("UCI HAR Dataset//train//X_train.txt", stringsAsFactors = FALSE)
ytrain <- read.table("UCI HAR Dataset//train//y_train.txt", stringsAsFactors = FALSE)
subtrain <- read.table("UCI HAR Dataset//train//subject_train.txt", stringsAsFactors = FALSE)
train <- cbind(group = "train", subtrain, ytrain, xtrain)


xtest <- read.table("UCI HAR Dataset//test/X_test.txt", stringsAsFactors = FALSE)
ytest <- read.table("UCI HAR Dataset//test/y_test.txt", stringsAsFactors = FALSE)
subtest <- read.table("UCI HAR Dataset//test/subject_test.txt", stringsAsFactors = FALSE)
test <- cbind(group = "test", subtest, ytest, xtest)

analysis <- rbind(train, test)  # create single data set from both groups

labels <- read.table("UCI HAR Dataset//features.txt", stringsAsFactors = FALSE)
labels <- labels[,2]  # select column containing variable names only
names(analysis) <- c("group", "subject", "activity", labels)

# substitute readable activity names rather than numbers (from file "activity_labels.txt")
analysis$activity <- gsub("1", "WALKING", analysis$activity)
analysis$activity <- gsub("2", "WALKING_UPSTAIRS", analysis$activity)
analysis$activity <- gsub("3", "WALKING_DOWNSTAIRS", analysis$activity)
analysis$activity <- gsub("4", "SITTING", analysis$activity)
analysis$activity <- gsub("5", "STANDING", analysis$activity)
analysis$activity <- gsub("6", "LAYING", analysis$activity)

analysis <- analysis[ ,!duplicated(names(analysis))]  # remove duplicated column names
# select only variables containing mean and standard deviation data
means_n_stds <- analysis[ ,c(1:3, grep("std|mean", names(analysis)))]

grouped <- group_by(means_n_stds, subject, activity)
summarised <- summarise_each(grouped, funs(mean))

write.table(summarised, "tidy.txt", row.names = FALSE)