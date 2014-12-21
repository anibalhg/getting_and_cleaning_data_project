Getting and Cleaning Data Project

Description

Additional information about the variables, data and transformations used in the course project for the Johns Hopkins Getting and Cleaning Data course.

Source Data

A full description of the data used in this project can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The source data for this project can be found here.

Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Attribute Information

For each record in the dataset it is provided:

Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
Triaxial Angular velocity from the gyroscope.
A 561-feature vector with time and frequency domain variables.
Its activity label.
An identifier of the subject who carried out the experiment.
Section 1. Merge the training and the test sets to create one data set.

After setting the source directory for the files, read into tables the data located in

features.txt
activity_labels.txt
subject_train.txt
x_train.txt
y_train.txt
subject_test.txt
x_test.txt
y_test.txt

1. Merges the training and the test sets to create one data set.
 Reading data from files
 Setting train column names
 Merging training data
 Reading test data
 Setting test column names
 Merging test data
 Merging train and test data
2. Extracts only the measurements on the mean and standard deviation for each measurement
 Selecting columns where TRUE is for id, mean and std dev columns
 Selecting only the useful data
3. Use descriptive activity names to name the activities in the data set
 Merging the fData set with the acitivityLabels table to include descriptive activity names
4. Appropriately label the data set with descriptive activity names
 Cleaning names
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
 Calculating mean by activity and subject
 Creating file
 
Variables:

features 			Contains the data of the file features.txt
activityLabels		Contains the data of the file activity_labels.txt
subjectTrain 		Contains the data of the file subject_train.txt
xTrain 				Contains the data of the file x_train.txt
yTrain 				Contains the data of the file y_train.txt
trainingData		Contains the training merged data
subjectTest			Contains the data of the file subject_test.txt
xTest				Contains the data of the file x_test.txt
yTest				Contains the data of the file y_test.txt
testData			Contains the test merged data
tData				Contains the traning and test merged data
colNames			Contains the columns names
usefulCols			A logical vector that contains the useful columns for mean and standar deviation
fData				Data set with activities data, mean and std dev
fDataNoName			Like fData without activities names
tidyData			The final data with mean by activity and subject
