# SECTION I. PREPARATORY STEPS
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

# SECTION 1. MERGE TRAINING AND TEST SETS TO CREATE ONE DATA SET
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

# SECTION 2. EXTRACT ONLY MEASUREMENTS ON THE MEAN AND STANDARD
# DEVIATION FOR EACH MEASUREMENT

f.data <- m.data[,c(grep("(*mean*)|(*std*)", names(m.data)), 562, 563)]

# SECTION 3. USE DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES
# IN THE DATA SET
names(f.data)[names(f.data)=='V1'] <- 'activity'
names(f.data)[names(f.data)=='V1.1'] <- 'subject'

act <- activity_labels[f.data$activity,]
f.data <- data.frame(f.data, act$V2)
f.data <- f.data[,!(names(f.data) %in% "activity")]

# SECTION 4. APPROPRIATELY LABEL THE DATA SET WITH DESCRIPTIVE NAMES
names(f.data)[names(f.data)=='act.V2'] <- 'activity'
curr_names <- names(f.data)
new_names <- gsub("\\.", "", curr_names)
new_names <- gsub("^t", "time", new_names)
new_names <- gsub("^f", "freq", new_names)
names(f.data) <- new_names

# SECTION 5. CREATE A SECOND, INDEPENDENT TIDY DATA SET WITH THE AVERAGE
# OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
tidy <- group_by(f.data, subject, activity)
tidy.final <- summarize_each(tidy, funs(mean))
