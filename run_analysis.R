require(dplyr)

## Get the training and test data read into R
test <- read.table("test/X_test.txt", header = FALSE)
train <- read.table("train/X_train.txt", header = FALSE)

ytrain <- read.table("train/y_train.txt", header = FALSE,
                     stringsAsFactors = FALSE)
ytest <- read.table("test/y_test.txt", header = FALSE,
                    stringsAsFactors = FALSE)

subtrain <- read.table("train/subject_train.txt", header = FALSE,
                       stringsAsFactors = FALSE)
subtest <- read.table("test/subject_test.txt", header = FALSE,
                      stringsAsFactors = FALSE)


## Now we have both dfs, let's add the rows from 'test' to the 
##  bottom of the 'train' df
final <- rbind(train, test)
final_y <- rbind(ytrain, ytest)
final_sub <- rbind(subtrain, subtest)

## Now we have to get only the mean and std for each measurement.
##  To do this, we need to check the features and get the columns
##  for which we have either mean() or std() in the name
features <- read.table("features.txt", header = FALSE,
                       stringsAsFactors = FALSE)

selectcols <- grep("mean\\(\\)|std\\(\\)", features$V2)  # Regex the means and stds

## Now cut the df cols out that we want, according to selectcols
final <- final[,selectcols]

## Let's get the activity names and apply them to the rows
activitylabels <- read.table("activity_labels.txt", header = FALSE,
                             stringsAsFactors = FALSE)

## This one is tricky, we can go through the whole final_y list, and get the
##  correct activity name by converting the activity number into a row
##  in the activitylables df
activitylist <- sapply(final_y, function(x){activitylabels[x, 2]})

final <- cbind(final, activitylist)  # Add a column in the df for activity

final <- cbind(final, final_sub)  # Add another column for subject


## Let's pull the names from the features list and apply them to the columns
colnamesfeatures <- features$V2[selectcols]
colnames(final) <- c(colnamesfeatures, "Activity", "Subject")

## Now we are in a position to make a new data set, and summarize it as 
##  required by question 5.
final_summary <- as_tibble(final)
final_summary <- group_by(final_summary, Activity, Subject)

final_summary <- summarize_all(final_summary, mean)
write.table(final_summary, "final_summary.txt", row.names = FALSE)
## And we are done!
