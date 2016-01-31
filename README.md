# gettingandcleaningdata
Getting and Cleaning  Data course project

The run_analysis.R script contains the complete logic required to complete this assignment.

The run_analysis.R script is broken into 6 sections: Section I, a preparatory step, and Sections 1-5 corresponding to the different numbered tasks detailed in the assignment description.

Section I loads the data files from the working directorys and loads the required packages (dplyr).

Section 1 contains the logic required to merge the training and test steps. First the *_test files are concatenated, then the *_train files are concatenated, and finally those two data frames are merged into one larger set.

Section 2 contains the logic required to extract only those variables that relate to means or standard deviations (determined by whether the variable name contains "mean" or "std").

Section 3 contains the logic required to replace the activity numbers with descriptive names from activity_labels.txt. First, it updates the variable names for "activity" and "subject", and then it adds a column containing the descriptive activity names and drops the numeric activity values.

Section 4 contains the logic required to label the data set variables with descriptive names. In this case, periods were removed, variables starting with "m" were instead started with "mean", and variables starting with "f" were instead started with "freq" (for frequency).

Section 5 contains the logic required to extract a tidy data set containing the average of each variable by activity and subject. First the larger data set is grouped by activity and subject, and then that data set is summarized using the mean() function.