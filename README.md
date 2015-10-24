# GetCleanDataProject
Course project for the Coursera course "Getting and Cleaning Data"

The runanalysis.R file in this Repo is used to process data from the UCI HAR Dataset.

Setup Environmnt: The data must be extracted into the same folder as the script (i.e. the folder "UCI HAR Dataset" should be in the same folder as the script). The script requires the dplyr dataset, but will install the package if it is not already available.

Process:
1. Load the test and training data sets into R, from the X_test.txt and X_train.txt files
2. Load the corresponding activity and subject codes into R from the y_test.txt, y_train.txt, subject_test.txt, and subject_train.txt files
3. combine the test and training data into a single data set
4. label the columns of the new data set using the names from the features.txt file
5. remove all columns that do not include data related to the mean or standard deviation of a metric (i.e. including "mean()" or "std()" in the column name, since we are not interested in other metrics.
6. Add the activity and subject codes from step 2 into the data set, and add activity labels from the activity_labels.txt file
7. compute the mean of each variable, grouped by activity and subject
8. write the resulting dataset to the file UCI_HAR_means.txt
