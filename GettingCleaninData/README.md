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


#### Example Run Against Tidy Dataset



```{r}
summary(cars)
```

You can also embed plots, for example:

```{r fig.width=7, fig.height=6}
plot(tidy_data$Subject[1:30],tidy_data[tidy_data[,1]=="WALKING",3],xlab="Subject",ylab="Acceleration, ft/sec^2",main="Subjects' Mean Body Acceleration (X)")
```

