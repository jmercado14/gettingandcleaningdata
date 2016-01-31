# load files
x_test <- read.table("X_test.txt")
x_train <- read.table("X_train.txt")
y_test <- read.table("y_test.txt")
y_train <- read.table("y_train.txt")
subject_test <- read.table("subject_test.txt")
subject_train <- read.table("subject_train.txt")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

# load packages
library(dplyr)

# merge test sets into one test table
names(x_test) <- features$V2
test <- data.frame(x_test, y_test, subject_test)
test$observation.type <- rep("test", 2947)

# merge train sets into one train table
names(x_train) <- features$V2
train <- data.frame(x_train, y_train, subject_train)
train$observation.type <- rep("train", 7352)

# merge train and test sets into one table
m.data <- rbind(test, train)

# extract only the measurements on the mean and
# standard deviation for each measurement
f.data <- m.data[,c(grep("(*mean*)|(*std*)", names(m.data)), 562, 563, 564)]

# Use descriptive activity names to name the activities in the data set
names(f.data)[names(f.data)=='V1'] <- 'activity'
names(f.data)[names(f.data)=='V1.1'] <- 'subject'

act <- activity_labels[f.data$activity,]
f.data <- data.frame(f.data, act$V2)
f.data <- f.data[,!(names(f.data) %in% "activity")]

# appropriately label the data set with descriptive names
names(f.data)[names(f.data)=='act.V2'] <- 'activity'
curr_names <- names(f.data)
new_names <- gsub("\\.", "", curr_names)
new_names <- gsub("^t", "time", new_names)
new_names <- gsub("^f", "frew", new_names)
names(f.data) <- new_names

# create a second, independent tidy data set with the average
# of each variable for each activity and each subject
tidy <- summarize_each(f.data, mean(), subject, activity)