This is a script to modify the data found in [this](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) file. It can be run by placing the run_analysis.R file in the root directory and executing it in R.


run_analysis.R
===========================
The script loads in all existing data and joins it. It then extracts the mean and standard-deviation columns and adds an activity and subject column. Finally, it groups the data by activity and subject, then summarizes it by averaging over the activity and subject respectively.

The final table is printed to the "final_summary.txt" file.
