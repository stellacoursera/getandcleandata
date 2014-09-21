---
title: "README"
author: "stella coursera"
date: "Sunday, September 21, 2014"
output: html_document
---

This is document describe the code structure and how the code running.

In this project there is only one code file: run_analysis.R

### The source code includes these parts:

1. _**CONTANTS**_ : Define the constants which would be used all over the codes such like file folder and file name etc

2. _**Prepare functions**_ : There 2 functions _prepareFeature_ and _prepareActivity_ to load factor data from the file

3. _**Data loading function**_ Load data from the train or test folder, perform the basic merge and transformation

4. _**Main function**_ Run the whole analysis follow the steps in CodeBook and output the result file i

### How to re-perform the analysis process?

1. Create sub-folder "data" in the folder the source code located.

2. Unzip the source data file downloaded from the web, and don't change anything

3. Load the source and run the function:

```{r}
main()
```