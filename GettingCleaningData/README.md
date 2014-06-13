Getting and Cleaning Data Peer Assessment April 2014
========================================================

This is a student's submission for the 'Tidy Data' Peer Assessment
assignment in Coursera's _Getting and Cleaning Data_ , April 2014.

The first section describes the student's approach and decisions made
while processing the **UCI HAR** dataset. Second section contains
discussion of the R script run_analysis.R. 


Approach
--------------------------------------------------------

### Feature Selection
We were asked to select columns that contained _mean_ and _standard
deviation (std)_.  These can be obtained by grepping the column labels
for _mean_ anbd _std_ respectively __or__ by reading the files
_meanFeatures.txt_ and _stdFeatures.txt_ from the UC HAR directory. The files contain the ordinals
and column labels for 33 columns each, and complement each other.

Both methods give the same number of columns for standard deviation (33),
but grep and case-insensitive grep return more columns for mean.  Examination
of the additional columns indicated they were not related to the 33
columns in the two text files (_meanFeatures.txt_ and _stdFeatures.txt_).

Thus, I chose the columns from the two *.txt files included with the
dataset distribution. Using 33 columns for mean, 33 additional columns
for standard deviation and 2 columns for Subject and Activity gives
us 68 columns of data to extract from the raw data and process.

### Merging Test and Train Datasets
There is discussion in the forums about how to merge the train and test
datasets. Some students believe the test set contains additional subjects,
others believe the test set represents additional data for the
30 subjects in the training set.

It is important to distinguish between regression (prediction) analysis
and classification. The purpose of regression type analysis is to predict
the response of hitherto unseen data, thus using new subjects for test
would be appropriate and expected.

However, the problem presented to us is a classification problem. These
problems do not require new subjects for classification; they require
additional data to test the ability of the classifier to correctly
classify hitherto unseen data for the same subjects.

An example might be helpful. Consider optical character recognition (OCR)
for the digits 0 to 9.  OCR classifiers are trained on many examples of
the handwritten digits.  These classifiers are then tested against
previously _unseen samples_ of the same ten digits to determine their accuracy.

This is the situation we have with this dataset. Thus I regarded the
test data as additional, previously unseen data for the *same* subjects in the training
set.



Script
--------------------------------------------------------
The script **run_Analysis.R** is self-contained once the working
directory is set and the required libraries - reshape2 and knitr - are
made available to the R runtime.

The script processes the dataset as follows:

#### Initialization
* loads the required libraries
* reads and stores the mean and std column labels (feature names) and ordinals from text files in the working directory
* reads the activity labels and ordinals which will be used to translate numeric
activity identifiers to reader-friendly activity names, e.g. activity
identifier **1** will be converted to **Walking** later on.

#### Process Test Data
* read data from test directory into __raw_test__
* extract columns from same and store in __test__
* reads subject and activity identifiers from their text files, save in __test_subjects__
and __test_activities__
* binds subject and activity columns to __test__ and sets the column
names for all 68 columns
* change activity identifiers to reader-friendly labels
* delete __raw_test__ to re-claim used memory.

#### Process Train Data
Processing train data is the same as for test data except for the dataset
and variable names.

* read data from train directory into __raw_train__
* extract columns from same and store in __train__
* reads subject and activity identifiers from their text files, save in __train_subjects__
and __train_activities__
* binds subject and activity columns to __train__ and sets the column
names for all 68 columns
* change activity identifiers to reader-friendly labels
* delete __raw_train__ to re-claim used memory.

#### Combine Files
* processed test and train datasets are combined with a simple row bind
and stored in variable __final__.
* save __final__ to local disk as a _csv_ file for later use and to allow
import into other software such as Excel, MATLAB et al. *Always give the user choices!*

#### Tidy Dataset
* run __final__ through _melt_ and save results in __final_melt__. 
* specify _Activity_ and  _Subject_ columns as the _id_ columns
* cast __final_melt__ using _dcast_ and specifying 
_mean_ as the function argumnet, save results in __tidy_data__.
* __tidy_data__ is saved to local disk as a _csv_ for later use or import into other
software such as Excel, MATLAB et al.

#### Example Using Tidy Dataset

Obtain quantiles of the "Mean X Body Acceleration" values
for all 30 subjects while 'WALKING':     
```
quantile(tidy_data[tidy_data[,1]=="WALKING",3])
```
Using this, one can determine if there is enough variance in this
measurement to be useful for classification purposes.

This code generates a plot of the same data:
```
plot(tidy_data$Subject[1:30],tidy_data[tidy_data[,1]=="WALKING",3],xlab="Subject",ylab="Acceleration, ft/sec^2",main="Subjects' Mean Body Acceleration (X)")
```

Closure
--------------------------------------------------------
A similar html version of this file can be found in this repository or using
this link: https://github.com/tqsclass/coursera/blob/master/GettingCleaninData/run_Analysis.html
You may need the latest version of _git_ to see it displayed as _html_, however.

It presents the script and comments inline more neatly than this
Markdown format.  I used code blocks at the very end of the file, but
didn't use them throughout this document because, to my eye, it
hindered readability.



