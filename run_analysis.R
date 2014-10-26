dataset_dir <- "./getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/"

x_train <- read.table(paste(dataset_dir, "train/X_train.txt", sep=""))
y_train <- read.table(paste(dataset_dir, "train/y_train.txt", sep=""))
subject_train <- read.table(paste(dataset_dir, "train/subject_train.txt", sep=""))

x_test <- read.table(paste(dataset_dir, "test/X_test.txt", sep=""))
y_test <- read.table(paste(dataset_dir, "test/y_test.txt", sep=""))
subject_test <- read.table(paste(dataset_dir, "test/subject_test.txt", sep=""))

# Merge training and test sets
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Extract only the measurements on the mean and standard deviation for each measurement
# Include only column names containing explicit function names mean() or std()
# ie. column names such as ***Mean and mean***() are not included
features <- read.table(paste(dataset_dir, "features.txt", sep=""), stringsAsFactors = FALSE)
features_idx <- grep("mean[(][)]|std[(][)]", x = features$V2)
x_mean_or_std <- x[ ,features_idx]

# Name the activities in the data set using labels from activity_labels.txt
# and combine with subject and mean or std measurements
activity_labels <- read.table(paste(dataset_dir, "activity_labels.txt", sep=""))
data <- cbind(subject, activity_labels[y[,], 2], x_mean_or_std)

# Label the data set with variable names taken from features.txt
features_colnames <- features[features_idx, "V2"]
colnames(data) <- c("Subject", "Activity", features_colnames)

# From the data set in step 4, create a second, independent tidy data set 
# with the average of each variable for each activity and each subject
library(dplyr)
by_subject_activity <- data %>% group_by(Subject, Activity)
avg_data <- by_subject_activity %>% summarise_each(funs(mean))

# Create files for avg_data and code book
write.table(avg_data, file="avg_data.txt", row.names=FALSE)
write.table(colnames(data), file="codebook.txt", quote=FALSE)
