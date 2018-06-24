

rm(list=ls(all=TRUE))


library(stringr)
library(plyr)
library(dplyr)


x_train <- read.table("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/train/X_train.txt")

y_train <- read.table("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/train/y_train.txt")

colnames(y_train)[1] <- "Activity ID"


SubjectNumber_Train <- read.delim("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/train/subject_train.txt" , header = FALSE)
colnames(SubjectNumber_Train)[1] <- "SubjectID"


x_test <- read.table("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/test/X_test.txt")

y_test <- read.table("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/test/y_test.txt")

colnames(y_test)[1] <- "Activity ID"

SubjectNumber_Test <- read.delim("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/test/subject_test.txt" , header = FALSE)

colnames(SubjectNumber_Test)[1] <- "SubjectID"



train <- cbind(x_train , y_train , SubjectNumber_Train)

test <- cbind(x_test , y_test , SubjectNumber_Test)



CombinedSet <- rbind(train , test)


ColNames <- read.delim("C:/Data Science/John Hopkins - Coursera/Getting and Cleaning Data/features.txt" , sep = " " , header = FALSE)



          for ( i in 1:(ncol(CombinedSet)-2))
          
          {
                   
            colnames(CombinedSet)[i] <- as.character(ColNames[i,2])  

          }


ColumnNames <- colnames(CombinedSet)


MeanColumns <- which(str_detect( ColumnNames , "mean"))

stdColumns <- which(str_detect(ColumnNames , "std"))

ActivityID <- which(str_detect(ColumnNames , "Activity"))

SubjectID <- which(str_detect(ColumnNames , "Subject"))


RequiredColumns <- c(MeanColumns , stdColumns , ActivityID , SubjectID)

RequiredColumns <- sort(as.numeric(RequiredColumns))


FilteredDataSet <- CombinedSet[ , RequiredColumns]


activityLabels = read.table('activity_labels.txt')

colnames(activityLabels)[1] <- "Activity ID"

colnames(activityLabels)[2] <- "Activity Name"



FilteredDataSet <- merge(FilteredDataSet,activityLabels,by='Activity ID',all.x=TRUE)


output <- aggregate(. ~SubjectID + `Activity Name`, FilteredDataSet, mean)

write.table(output, "output.txt", row.name=FALSE)

  