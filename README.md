Tidy Data
========

Contains the code for transforming the UCI HAR data set into a tidy data set 

This folder contains run_analysis.R which takes the UCI HAR data set and transforms it into a tidy data set
To run run_analysis.R it is very IMPORTANT to do the following steps
<ol>
1. Download the data set from the website to the working directory and RENAME it as "Dataset". This "Dataset" should contain the folders test, train and files activity_labels, features etc. </ol>
<ol>2. Download run_analysis.R to the working directory.</ol>
<ol>3. Now if you run_analysis.R it will generate tidyData.txt which is the same text file I have uploaded as answer to the first question in the project
</ol>
run_analysis.R does the following
+ Installs and loads the reshape2 package- for use in Step 5. If you already have this package comment out the installation(line 1) and /or loading(line 2)
+ It loads the subject data from subject_test and subject_train, the activity data from y_test and y_train and the features data from X_test and X_train
+ It merges the subject and activity data
+ It retrieves the features that contains mean() or std() - since we are asked to extract only the mean and standard deviations for each measurement I assumed that these are the features that contain mean() or std(). 
+ It filters the features data to only retain the above mentioned features(Step 2)
+ Now it merges the features data with subject and activity data.At this point we have 10299 observations with 68 variables (66 features, subject and activity id)(Step 1)
+ The next step assigns proper column names to the different variables. The formatting i did was to remove any punctuation symbol (parentheses, hyphens etc). I also capitalized the 's' in 'std' and 'm' in 'mean' for the different mean and std measurements. The variable names are in camel case (Step 4)
+ After this the activity names are merged to the data set (Step 3) using the activity id and we have the data set after the 4 steps are done.
+ As a next step, the script melts the data set (after removing activity id) using the subject and activity name as ids and recasts it into a data frame performing the mean function on all variables. (Step 5).
+ The variables are renamed to reflect the fact that they are now the average values of the measurements
+ The script writes the data frame from the above step to a text file in the working directory.

Please note that I used the Windows OS and there is a chance that the paths for working directory etc may slightly differ in another OS (forward slash vs backward slash etc.)
