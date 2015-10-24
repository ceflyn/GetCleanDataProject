#ensure that dplyr package is istalled and loaded
if(!("dplyr" %in% installed.packages()[,"Package"])) {
  install.packages("dplyr")
}
require(dplyr)

#load data and labels
features<- read.table("UCI HAR Dataset/features.txt", header=F)

test<- read.table("UCI HAR Dataset/test/X_test.txt", header=F)
test_acts<- read.table("UCI HAR Dataset/test/y_test.txt", header=F)
test_subjs<- read.table("UCI HAR Dataset/test/subject_test.txt", header=F)
  
train<-read.table("UCI HAR Dataset/train/X_train.txt", header=F)
train_acts<- read.table("UCI HAR Dataset/train/y_train.txt", header=F)
train_subjs<- read.table("UCI HAR Dataset/train/subject_train.txt", header=F)

#combine test and training data into one data frame
all_data<-rbind(test,train)
names(all_data)<-features[,2]

#filter to only columns with means or standard deviations
include_cols<-grepl("mean()",names(all_data)) | grepl("std()",names(all_data))
metrics<-all_data[,include_cols]

#add activity and subject labels to the data set
all_acts<-rbind(test_acts,train_acts)
all_subjs<-rbind(test_subjs,train_subjs)
metrics$actvy.cd<-all_acts[,1]
metrics$subj.cd<-all_subjs[,1]

act_lbls<- read.table("UCI HAR Dataset/activity_labels.txt",col.names = c('actvy.cd','actvy'))
lbl_metrics<-merge(metrics,act_lbls)

#compute means of each variable grouped by subject and activity, then write to file
means<-aggregate(lbl_metrics[,2:80], list(lbl_metrics$actvy.cd,lbl_metrics$actvy,lbl_metrics$subj.cd),mean)
means<-rename(means, actvy.cd=Group.1, actvy.nm=Group.2, subject.cd=Group.3)

write.table(means, file="UCI_HAR_means.txt", row.names = F)
