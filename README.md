#Getting and Cleaning Data Assignment

	The R script run_analysis is used to transform the provided data into a tidy data set. A code book is provided with information about columns contents.

	In order to the script to work as it is, the data should be already dowloaded and unzipped in the working directory. If necessary, one can uncomment the command lines at the beggining of the code so it will set the working directory, download the data and unzip it to the working direcory.

    The process to transform the data into a tidy data set are the following:

    	1 - read all files
    	2 - merge the train and test data into a unique data frame for each file (variables, activity labels and subject identifiers)
    	3 - filter the resulting data frame  by selecting only the columns that corresponds either to the mean or to the standard deviation of measures
    	4 - transform the activity label data frame so the activities are identified by their names instead of number
    	5 - merge all data frames into a unique data frame containing all of the information
    	6 - rename the columns so they are self-explanatory and easy to use
    	7 - group the data frame by subject and activity and summarise all of the remaining columns using the mean function, so the columns'contets are the average of each variable for each subject and activity.

    The R script is rich in commented lines, so understanding each step is easy.