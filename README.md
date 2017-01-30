# Getting_and_Cleaning_Data_Course_Project

This dataset provides a summarization of a subset of signal measurements from the original Human Activity Recognition Using Smartphones Dataset Version 1.0.  Test and Train data were merged and the average of the mean and standard deviation for each measurement were included in the new dataset. The original dataset is found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The new dataset consists of the following files:
* ‘ReadMe.md’ – this file that describes how things fit together and the work performed to clean up the data
*	‘UCI_HAR_Mean_and_Std_Averages.csv’– the merged dataset with averages of the mean and standard deviation of each measurement.
  NOTE: to read the file use read.table()
* ‘CodeBook.md’ – describes the variables, the data, units of measurement 

The script run_analysis.R was used to create the new dataset.
*	Training and test data from the original dataset were merged together into a single tidy dataset. 
*	Only measurements on the mean and standard deviation for each measurement were included in the new dataset. Specifically, only those measurements that include “mean()” or “std()” in the feature column name.
*	The activity names were included in the dataset as opposed to an activity ID. For example: the activityName in the dataset specifies “Walking” vs. “1”.
*	Data column names were cleaned up for the sake of readability. For example: “tBodyAcc-mean()-X” was changed to “timeBodyAcceleratorMeanX”
  +	Special characters were removed:   .  -  (  ) 
  +	The prefix ‘t’ was expanded to “time” - time domain signals
  +	The prefix ‘f’ was expanded to “freq” - frequency domain signals
  +	“Acc" was expanded to "Accelerometer",
  +	“mean” was changed to “Mean”
  +	“std” was changed to “Std”
*	The tidy dataset shows the average of each variable for each activity and each subject.

Note: by merging the Training and Test data into a single dataset, the group that the subject was associated with (Test or Train) was lost. This dataset does not include the group since it is not required for the analysis. 
