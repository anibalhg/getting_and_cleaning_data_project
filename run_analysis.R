runAnalysis <- function () {

	# 1. Merges the training and the test sets to create one data set.

	# Reading data from files
	features <- read.table('./features.txt', header <- FALSE) 
	activityLabels <- read.table('./activity_labels.txt', header <- FALSE)
	subjectTrain <- read.table('./train/subject_train.txt', header <- FALSE)
	xTrain <- read.table('./train/x_train.txt', header <- FALSE)
	yTrain <- read.table('./train/y_train.txt', header <- FALSE)

	# Setting column names
	colnames(activityLabels) <- c('activityId', 'activityName')
	colnames(subjectTrain)  <- "subjectId"
	colnames(xTrain)        <- features[,2]
	colnames(yTrain)        <- "activityId"

	# Merging training data
	trainingData <- cbind(yTrain, subjectTrain, xTrain)

	# Reading test data
	subjectTest <- read.table('./test/subject_test.txt', header <- FALSE)
	xTest <- read.table('./test/x_test.txt', header <- FALSE)
	yTest <- read.table('./test/y_test.txt', header <- FALSE)

	# Setting column names
	colnames(subjectTest) <- "subjectId"
	colnames(xTest) <- features[,2]
	colnames(yTest) <- "activityId"

	# Merging test data
	testData <- cbind(yTest, subjectTest, xTest)

	# Merging train and test data
	tData <- rbind(trainingData, testData)

	# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

	# Selecting columns where TRUE is for id, mean and std dev columns
	colNames  <- colnames(tData)
	usefulCols <- (grepl("activity..", colNames) | grepl("subject..", colNames) | grepl("-mean..", colNames) & !grepl("-meanFreq..", colNames) & !grepl("mean..-", colNames) | grepl("-std..", colNames) & !grepl("-std()..-", colNames))

	# Selecting only the useful data
	fData <- tData[usefulCols == TRUE]

	# 3. Use descriptive activity names to name the activities in the data set

	# Merging the fData set with the acitivityLabels table to include descriptive activity names
	fData <- merge(fData, activityLabels, by = 'activityId', all.x = TRUE)
	colNames <- colnames(fData)

	# 4. Appropriately label the data set with descriptive activity names

	# Cleaning names
	for (i in 1:length(colNames)) {
	  colNames[i] <- gsub("\\()", "", colNames[i])
	  colNames[i] <- gsub("-std$", "StdDev", colNames[i])
	  colNames[i] <- gsub("-mean", "Mean", colNames[i])
	  colNames[i] <- gsub("^(t)", "time", colNames[i])
	  colNames[i] <- gsub("^(f)", "freq", colNames[i])
	  colNames[i] <- gsub("([Gg]ravity)", "Gravity", colNames[i])
	  colNames[i] <- gsub("([Bb]ody[Bb]ody|[Bb]ody)", "Body", colNames[i])
	  colNames[i] <- gsub("[Gg]yro", "Gyro", colNames[i])
	  colNames[i] <- gsub("AccMag", "AccMagnitude", colNames[i])
	  colNames[i] <- gsub("([Bb]odyaccjerkmag)", "BodyAccJerkMagnitude", colNames[i])
	  colNames[i] <- gsub("JerkMag", "JerkMagnitude", colNames[i])
	  colNames[i] <- gsub("GyroMag", "GyroMagnitude", colNames[i])
	}
	colnames(fData) <- colNames

	# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

	fDataNoName <- fData[,names(fData) != 'activityName']

	# Calculating mean by activity and subject
	tidyData <- aggregate(fDataNoName[ ,names(fDataNoName) != c('activityId','subjectId')], by = list(activityId = fDataNoName$activityId, subjectId = fDataNoName$subjectId), mean)
	tidyData <- merge(tidyData, activityLabels, by = 'activityId', all.x = TRUE)


	# Creating file
	write.table(tidyData, './tidyData.txt', row.names = FALSE, sep='\t')
}