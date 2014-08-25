funtion analyzeMobileData(dir="/Users/Loka/Bigdata/Course/UCI HAR Dataset",fName="tidy_set2_by_sub_act.txt")
{
  setwd(dir)

  #Function to replace Activity number with activity value which is used in Apply function
  fw<- function(x){ switch(x, "1"= "WALKING", "2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"="LAYING") }
  
  
# Load all the files into data.frame varilable from train and test folders into respected variables,
features<-read.table("features.txt")

x_train<-read.fwf("./train/X_train.txt",widths=rep(16,561)) 
y_train<-read.table("./train/y_train.txt") 
sub_train<-read.table("./train/subject_train.txt")

x_test<-read.fwf("./test/X_test.txt",widths=rep(16,561)) 
y_test<-read.table("./test/y_test.txt") 
sub_test<-read.table("./test/subject_test.txt")

#Label the column names using the features list.
colnames(x_train)<-features[,2]
colnames(x_test)<-features[,2]


#Label the column names to Subject and Activity
colnames(sub_train)<-c("Subject")
colnames(y_train)<-c("Activity")
colnames(y_test)<-c("Activity")
colnames(sub_test)<-c("Subject")


# Using Apply change the Activity value to descriptive activity names.
y_train<-apply(y_train,1,fw)
y_test<-apply(y_train,1,fw)

#Prepare Training and Test Sets with joining Subject and Activities
train_set<-cbind(sub_train,y_train,x_train[,grep("MEAN|STD",toupper(colnames(x_train)))])
test_set<-cbind(sub_test,y_test,x_test[,grep("MEAN|STD",toupper(colnames(x_test)))])


#Merge the training and the test sets to create one tidy data set.
tidy_set<-rbind(test_set,train_set)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
tidy_set2<-aggregate(tidy_set[,3:55],by=list(groupBySubject=tidy_set$Subject,groupByActivity=tidy_set$Activity),FUN=mean )

# Write the second tidy data set to given file name.
write.table(tidy_set2,file=fname,row.names=FALSE)
