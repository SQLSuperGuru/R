# Install
install.packages("tm")  # for text mining
install.packages("SnowballC") # for text stemming
install.packages("syuzhet") # for sentiment analysis
install.packages("ggplot2") # for plotting graphs

# Load
library("tm")
library("SnowballC")
library("syuzhet")
library("ggplot2")

# Read the text file from local machine , choose file interactively
# filePath = "C:\Demos\AcmeCorp_EmpSurvey_CleanedPreparedData.txt"
text <- readLines(file.choose())

# head(text,10) - just to see top 10 lines

# run nrc sentiment analysis to return data frame with each row classified as one of the following
# emotions, rather than a score : 
# anger, anticipation, disgust, fear, joy, sadness, surprise, trust 
# and if the sentiment is positive or negative
d<-get_nrc_sentiment(text)

# head(d,10) - just to see top 10 lines
head (d,10)

#transpose
td<-data.frame(t(d))

# head(d,10) - just to see top 10 lines
head (td,10)

td_new <- data.frame(rowSums(td[2:253]))
#The function rowSums computes column sums across rows for each level of a grouping variable.

#Transformation and  cleaning
names(td_new)[1] <- "count"
td_new <- cbind("sentiment" = rownames(td_new), td_new)
rownames(td_new) <- NULL
td_new2<-td_new[1:8,]

#Visualisation
qplot(sentiment, data=td_new2, weight=count, geom="bar",fill=sentiment)+ggtitle("Email sentiments")




