# Getting and Cleaning Data - Course Project

## Explanation of Script used to get and clearn Samsung Human Activity Recognition Files

Step 1a: In a first step the available test data is combined column-wise by using cbind()
This results in a file containing the following information:
 
* First column: the number of the human subject who participated in the test
* Next columns: all the different features obtained during the test
* Last column: the human activity code (e.g. 1 for "sitting") associated with the activity

Step 1b: In a second step the training data is combined in the same way as above.

Step 1c: The two data sets (training and test) are then appended to each other using rbind()

Step 2a: There is a data set with feature labels called "features.txt", which we load to be able
to automatically select certain feature columns in subsequent steps.

step 2b: We now create a new data frame called table2. We first select the only two columns that
do not correspond with features as such: 

* First column = Subject
* Second column = Action

Step 2c: now loop through the labels and select those columns from the table that contain either
mean() or std(), in order to select only mean and standard deviation features. 

Step 3: The action is still only specified in terms of a code. There is a file called 
"activity_labels.txt" which contains a readable label for each activity code. We load this file into
a table (al) and merge it with the main data table (table2) (using an inner join like operation).
We also drop the column that contains the action numbers.

Step 4: It is now time to calculate the mean values for all the selected feature columns. This can 
be accomplished by means of the split/sapply pattern. Split is applied to a combination of the two
columns 'Subject' and 'Action_label'. We need to apply the factor() function to turn these values
into factors. 

Step 5: Write the results to a text file or a csv file.


