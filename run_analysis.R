install.packages("reshape2")
library(reshape2)

# reading subject and activity data from train and test folders 
trainY <- read.table("./Dataset/train/y_train.txt")
trainSub <- read.table("./Dataset/train/subject_train.txt")
testY <- read.table("./Dataset/test/y_test.txt")
testSub <- read.table("./Dataset/test/subject_test.txt")

# combining into one datframe
ySub <- rbind(cbind(trainSub, trainY), cbind(testSub, testY))

# reading the data for the different features and merging training and testing data
trainX <- read.table("./Dataset/train/X_train.txt")
testX <- read.table("./Dataset/test/X_test.txt")
X <- rbind(trainX, testX)

# reading in the names of the different features
features <- read.table("./Dataset/features.txt")

# creating filters for names that contain 'mean()' or 'std()'
avg <- sapply(features[,2], grepl, pattern = ".*mean\\(\\).*")
sd <- sapply(features[,2], grepl, pattern = ".*std\\(\\).*")

# selectig the features based on filter
selectedFeatures <- features[avg | sd, ]

# retaining only selected features
selectedX <- X[,t(selectedFeatures[,1])]

# combining subject and activity data with the features data
data <- cbind(ySub, selectedX)

# capitalizing, removing punctuation from the names of selected features
colNames <- lapply(selectedFeatures[,2], sub, pattern = "std\\(", replacement = "Std")
colNames <- lapply(colNames, sub, pattern = "mean\\(", replacement = "Mean")
colNames <- sapply(colNames, gsub, pattern = "[[:punct:]]", replacement = "")

# assigning the column names from the previous frame to the dataframe
names(data) <- c("subject", "activityId", colNames)

# loading the activity names
activity <- read.table("./Dataset/activity_labels.txt")
names(activity) <- c("id", "activityName")

# adding a column ActivityName to every row in 'data' by merging on ActivityId
dataWithActivityNames <- merge(data, activity, by.x = "activityId", by.y = "id")

# removing ActivityId: temp contains the 66 selected features, subject and activity name for every row
temp <- dataWithActivityNames[,-1]

# step 5 in assignment: calculating the mean of each variable grouped my subject and activity name
moltenData <- melt(temp, id = c("subject", "activityName"))
tidyData <- dcast(moltenData, subject + activityName ~ variable, mean)

# changing the names so they reflect the fact that these are the average values of the features
names(tidyData)[3:68] <- paste("avg", names(tidyData)[3:68], sep = "")

# tidyData.txt contains the tidy data set
write.table(tidyData, file = "tidyData.txt")