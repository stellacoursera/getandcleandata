## This script is used the create a tidy data from the 
## Samsung Glaxy S smarthone collected data.
## The tidy set should match these requirement:
##  1.Merges the training and the test sets to create one data set.
##  2.Extracts only the measurements on the mean and standard deviation for each measurement. 
##  3.Uses descriptive activity names to name the activities in the data set
##  4.Appropriately labels the data set with descriptive variable names. 
##  5.creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##CONSTANTS
# folder and file
FOLDER <- "./data/UCI HAR Dataset/"
ACTIVITY_FILE <- paste(FOLDER,"activity_labels.txt",sep="")
FEATURE_FILE <- paste(FOLDER,"features.txt",sep="")
DATA_FILE <- "X"
ACT_DATA_FILE <- "y"
SUBJECT_FILE <- "subject"
TIDY_FILE <- "./data/tidy_data.txt"
# column names
SUBJECT_COL_NAME <- "Subject"
ACT_CODE_COL_NAME <- "ActivityCode"
ACT_NAME_COL_NAME <- "ActivityName"
ACT_COL_NAMES <- c(ACT_CODE_COL_NAME,ACT_NAME_COL_NAME)


##Prepare features which would be the column names
## return a features vector
prepareFeature <- function(){
  fData<- read.table(FEATURE_FILE,head = FALSE, sep=""
                         ,stringsAsFactors=FALSE,fill=TRUE)
  fData[,2]
}

##Prepare activity label
## return a activity datasets
prepareActivity <- function(){
  aData<- read.table(ACTIVITY_FILE,head = FALSE, sep=""
                     ,stringsAsFactors=FALSE,fill=TRUE
                     ,col.names=ACT_COL_NAMES)
}

##Load the indicated data to the dataset
##  - features: a vector include the data column names
##  - activity: a dataset include the activity id and name
##  - type: test or train
load <- function (features,activity,type){
 
  #load data file
  dataFile <- paste(FOLDER,type,"/",DATA_FILE,"_",type,".txt",sep="")
  data <- read.table(dataFile,head = FALSE, sep="",stringsAsFactors=FALSE,
                      fill=TRUE)
  names(data) <- features
  
  #load subject file
  sbjFile <- paste(FOLDER,type,"/",SUBJECT_FILE,"_",type,".txt",sep="")
  sjb <- read.table(sbjFile,head = FALSE, sep="",stringsAsFactors=FALSE,
                     fill=TRUE,col.names=SUBJECT_COL_NAME)
  
  #load activity file and replace with the Activity Name
  actFile <- paste(FOLDER,type,"/",ACT_DATA_FILE,"_",type,".txt",sep="")
  act <- read.table(actFile,head = FALSE, sep="",stringsAsFactors=FALSE,
                    fill=TRUE,col.names=ACT_CODE_COL_NAME)
  
  act <- 
    left_join(act,activity,by=ACT_CODE_COL_NAME) %>%
    select(ActivityName) 
    
  
  #combine the subject,activity and data
  data<-cbind(sjb,act,data)

}

##main function to run the analysis
main <- function(){ 
  
  # load related R package  
  require(plyr)
  require(dplyr)
  require(tidyr)
  
  # load prepare features and activity table
  message("Preparing factor table : features and activity...")
  features <- prepareFeature()  
  activity <- prepareActivity()

  # load test file
  message("Load source data : test...")
  testData <- load(features,activity,"test")

  
  # load train file  
  message("Load source data : train...")
  trainData <- load(features,activity,"train")

  
  # merge data
  message("Merge the 2 dataset : test and train...")
  allData <- rbind(trainData,testData)
  
  # extracts only measurements on the mean and std for each measurement
  message("Extract measurements: mean and std...")
  selectData <- 
    allData %>% 
    select(Subject,ActivityName,matches(".*(mean|std).*"),ignore.case = FALSE) %>%
    select(-contains("angle"))
  

  # create a new tidy data  sets 
  message("create the new tidy dataset...")
  tidyData <-
    selectData %>%
    gather("Variable","Value",-(Subject:ActivityName)) %>%
    ddply(c(SUBJECT_COL_NAME,ACT_NAME_COL_NAME,"Variable")
          ,summarize,Average=mean(Value))
  
  # write the new tidy data sets to the file
  message(paste("write the new tidy dataset to the",TIDY_FILE))
  write.table(tidyData,TIDY_FILE,row.names = FALSE)
}