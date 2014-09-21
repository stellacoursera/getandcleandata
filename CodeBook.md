---
title: "Code Book"
author: "stella coursera"
date: "Sunday, September 21, 2014"
output: html_document
---

This is the code book to describe the data sets and the transformation from the source dataset to tidy dataset.

The requirement of the data transformation is from [Coursera Course:Getting and Cleaning Data](https://class.coursera.org/getdata-007). For more details about this project, please reference to the coursera webpage.

## Source Data Set
The source data set is the **Human Activity Recognition Using Smartphones Dataset
Version 1.0**

> _This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited._

**Description and Variables**

* _features.txt_ : List of all features used on the feature vector.
* _activity labels.txt_ : Links the class labels with their activity name.
* Test data located in _test_ folder
* Train data located in _train_ folder
* For each folder:

  + _X_ file : Data set for each subject with A 561-feature vector. The subject is the one who carried out the experiment.
  + _Y_ file : The activity class for each observation in _X_ file


**Find full descripion [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)**

## Tidy data set after transformation
The tidy dataset include both train data and test data from the source data sets

**Variables**

*  _**'Subject'**_ : The one who carried out the experiment
*  _**'ActivityName'**_ : The activity name the subject performed
*  _**'Variable**_: The features of the measuresments, only include the mean and std features
*  _**'Average'**_ ： The Average measuresments for each variable for each activity and each subject

## Transformation
The transformation follows these steps:

1. Load features.txt to prepare a features Vector

2. Load activity labels.txt to prepare a dataset includes activity code and activity name

3. Load and standardize the data for both train and test
  + Read measurements file (x file) and bind the column names with features Vector
  + Read activity file (y file) and match with the activity label dataset to get the activity name
  + Read subject file into the subject dataset
  + merge the mesurements, activity and subject datasets together
  

 
4. Merge the train data set and test data set prepared in the last step together

5. Extracts mean and std measurements from the merged data set

6. Convert the measurements from the column data to line data, after this step, for each observation, it would inlcudes: 

 + _Subject_
 + _ActivityName_
 + _Viarable_ : the feature name
 + _Value_ : the measurement of the feature 

7. Generate the new dataset with the average of each variable for each activity and each subject.


