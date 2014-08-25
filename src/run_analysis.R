funtion analyzeMobileData(dir="/Users/Loka/Bigdata/Course/UCI HAR Dataset",fName="tidy_set2_by_sub_act.txt")
{
  setwd(dir)

  #Function to replace Activity number with activity value which is used in Apply function
  fw<- function(x){ switch(x, "1"= "WALKING", "2"="WALKING_UPSTAIRS","3"="WALKING_DOWNSTAIRS","4"="SITTING","5"="STANDING","6"="LAYING") }
  
  
  # Load all the files into data.fram varilable
features<-read.table("features.txt")

x_train<-read.fwf("./train/X_train.txt",widths=rep(16,561)) 
colnames(x_train)<-features[,2]
y_train<-read.table("./train/y_train.txt") 
colnames(y_train)<-c("Activity")
y_train<-apply(y_train,1,fw)
sub_train<-read.table("./train/subject_train.txt")
colnames(sub_train)<-c("Subject")
#train_set<-cbind(sub_train,y_train,x_train)

train_set<-cbind(sub_train,y_train,x_train[,grep("MEAN",toupper(colnames(x_train)))])

x_test<-read.fwf("./test/X_test.txt",widths=rep(16,561)) 
colnames(x_test)<-features[,2]
y_test<-read.table("./test/y_test.txt") 
colnames(y_test)<-c("Activity")
y_test<-apply(y_train,1,fw)
sub_test<-read.table("./test/subject_test.txt")
colnames(sub_test)<-c("Subject")

test_set<-cbind(sub_test,y_test,x_test[,grep("MEAN",toupper(colnames(x_test)))])

#test_set<-cbind(sub_test,y_test,x_test)

tidy_set<-rbind(test_set,train_set)


tidy_set2<-aggregate(tidy_set[,3:55],by=list(groupBySubject=tidy_set$Subject,groupByActivity=tidy_set$Activity),FUN=mean )

write.table(tidy_set2,file=fname,row.names=FALSE)

lst<-grep("MEAN",toupper(features[,2]))

lst<-grep("MEAN",toupper(colnames(tidy_set)))

tidy_set2<-aggregate(cbind(grep("MEAN",toupper(tidy_set[,2])))~Subject+Activity, tidy_set, mean)

x_merge<-rbind(x_test,x_train)
flist<-read.table("./features.txt")
colnames(x_merge)<-flist[,2]


head(apply(bgx_train,1,mean),1)
head(apply(bgx_train,1,sd),1)
head(cbind(sub_train,apply(bgx_train,1,sd),),2000)
xf<-cbind(sub_train,apply(bgx_train,1,sd),apply(bgx_train,1,mean))
colnames(xf)<-c("SubjectNo","bgx_train_msd","bgx_train_mean")




