#load libraries
library(dplyr)
library(tidyr)
library(ggplot2)
library(tidyverse)
library(scales)

#Import data files, report some basic stats
Users <- read.csv("~/Practicum/UsersUsage.csv")
summary(Users)

Reports <- read.csv("~/Practicum/ReportsUsage.csv")
summary(Reports)

Training <- read.csv("~/Practicum/Training.csv")
summary(Training)
#result: 46 do not have a location
#result: 358 do not have a UserId
#result: 37 do not have a provider
#result: 34 have a first day of course in the year 9999
#result: 46 do not have a rank

Create <- read.csv("~/Practicum/Create2.csv", header=TRUE, stringsAsFactors = FALSE)

#convert UserID to character field in all original files
Users %>% mutate_if(is.factor, as.character) -> Users
Reports %>% mutate_if(is.factor, as.character) -> Reports
Training %>% mutate_if(is.factor, as.character) -> Training
Create %>% mutate_if(is.factor, as.character) -> Create

#Clean data - convert all character fields to all capital letters
Users <- data.frame(lapply(Users, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))

Reports <- data.frame(lapply(Reports, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))

Training <- data.frame(lapply(Training, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))

Create <- data.frame(lapply(Create, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
}))

#Convert dates, change column names to be simpler
Users$LastDate <- as.Date(Users$Last.Used.Date, format = "%d/%m/%Y")
Reports$LastDate <- as.Date(Reports$Last.Used.Date, format = "%d/%m/%Y")
Training$CourseDate <- as.Date(Training$First.Day.of.Course, format = "%d %b %Y")
Create$UserRequestDate <- as.Date(Create$User.Request.Date, format = "%m/%d/%Y")
Create$TTDate <- as.Date(Create$Date.TT.Completed, format = "%m/%d/%Y")

#Change field names for simplicity
Users$CreateRevise <- Users$Create.or.Revise.Count
Users$RefreshView <- Users$Refresh.or.View.Count

#Calculate some summary statistics for User data
sum(Users$Create.or.Revise.Count, na.rm = TRUE)
# 11189
sum(Users$Refresh.or.View.Count, na.rm = TRUE)
# 139767

max(Users$Create.or.Revise.Count, na.rm = TRUE)
# 1373
max(Users$Refresh.or.View.Count, na.rm = TRUE)
# 6463

#tidy data by activity
tidyusers <-gather(Users, "Activity", "Count", 6:7)

#plot number of people who are creating and revising reports vs. refreshing and viewing reports over time, by last date tehy accessed the system. This would be more useful if we had the date of EACH access to the system. Or if we could graph the first and last. Or frequency. 
ggplot(tidyusers, aes(x = LastDate, y = Count)) + geom_point(aes(color = Activity)) + scale_color_manual(name = "Activity", labels = c("Create or Revise", "Refresh or View"), values = c("gray45", "magenta1")) + labs(x="Last Access Date, 2018-2019")+ scale_x_date(breaks = date_breaks("months"), labels = date_format("%b"))

#463 users have only done one of Create/Review or Refresh/View

#the number of times an individual from each L1 accessed each report
#Would be more helpful if we knew rank
L1ReportSummary <- as.data.frame(table(Reports$L1, Reports$Report.Name))
L1ReportSummary <- subset(L1ReportSummary, Freq>0)

#How many times people in each Level 1 use the software
ReportWho <- as.data.frame(table(Reports$L1, Reports$UserId))
ReportWho <- subset(ReportWho, Freq>0)
names(ReportWho) <- c("L1", "UserId", "Freq")

# Plot how many people are accessing the software in each L1 - not the number of times they are using the software
ggplot(ReportWho, aes(L1)) + geom_bar() + labs(x = "Level 1 Group", y = "Interactions", title = "Number of Users by Level 1")+ theme(axis.text.x = element_text(size = 10,angle = 45, hjust = 1, vjust = 1))+scale_y_continuous(breaks = scales::pretty_breaks(n = 10))

#tidy data to be able to graph the number of users performing each of the two actions. NOT interactions. 
tidyreports <-gather(Reports, "Activity", "Count", 4:5)
tidyreports2 <- subset(tidyreports, tidyreports$Count>0)

#plot type of usage by Level 1 Group, by unique users
ggplot(tidyreports, aes(x=L1, y = Count, fill = Activity)) + geom_bar(stat = "identity", position = "dodge") + labs(x = "Level 1 Group", title = "Number of Users by Activity and L1") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View")) + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1))


#Clean data - convert all character fields to all capital letters
Reports2 <- data.frame(lapply(Reports, function(v) {if (is.character(v)) return(toupper(v)) else return(v)}))

#Create a table to Identify different training cohorts
Cohorts <- as.data.frame(table(Training$CourseDate))
cohort <- c(1:41)
Cohorts$cohort <- cohort
Cohorts$CourseDate <- Cohorts$Var1
Cohorts$CohortSize <- Cohorts$Freq
Cohorts <- subset(Cohorts, select = c(3:5))

Cohorts <- as.data.frame(Cohorts)

#Convert dates to a useable format
Cohorts$CourseDate <- as.Date.factor(Cohorts$CourseDate, format = "%Y-%m-%d")

#merge training data with the cohorts that were created above
TrainingData <- merge(Training, Cohorts, by = "CourseDate", all = FALSE)

#How many users in each L1 have done the training
TrainingLevel <- as.data.frame(table(TrainingData$L1))

#plot the number of people in each Rank completing the training
ggplot(TrainingData, aes(Rank)) + geom_bar() + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1)) + labs(x = "Rank", title = "Number of people in each Rank who have completed training")

#Plot the number of people in each cohort
ggplot(TrainingData, aes(cohort)) + geom_bar()+ theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1)) + labs(x = "Cohort", title = "Number of people in each training class")

#Plot the number of people in each L1 taking training
ggplot(TrainingData, aes(L1)) + geom_bar() + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1)) + labs(x = "Level 1 Group", title = "Number of people in each Level 1 who have taken the training")

#summary of the unique people taking the training, by L1 and Rank
who2 <- as.data.frame(table(TrainingData$L1, TrainingData$UserId, TrainingData$Rank))
who2 <- subset.data.frame(who2, Freq >0)
names(who2) <- c("L1", "UserId", "Rank", "Freq")

#Plot people taking training, by L1 and Rank
ggplot(who2, aes(x=L1, y = Freq, fill = Rank)) + geom_bar(stat="identity", position = "dodge")+ theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1)) + labs(x = "Rank")

ggplot(who2, aes(x=L1, y = Freq)) + geom_bar(stat="identity")  + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1))+ facet_wrap(~ Rank, ncol = 5)

#join User and Training data. Include all UserIds in both data frames. 
df <- merge(Users,TrainingData, by = "UserId", all = TRUE)
df$L1 <- as.character(df$L1)
summary(df)

#result: There are more users who have accessed a report than have received training. There are 671 users who do not have a first day of course.  
#result: there are 364 users who do not have a last date in the system
#result: there are 358 users who do not have an ID
#result: there are 825 users who have never created or revised a report
#result: there are 366 users who have never viewed or refreshed a report

df$diff_in_days<- as.numeric(difftime(df$LastDate ,df$CourseDate , units = c("days")))
summary(df)
#1035 users have either not completed the training and/or have not used the report system

#Count number of times someone has taken the course but not used the system, used the system but not taken the course, or has both taken the course and used the system
Dates <- df[c(5,8)]
Dates$Last <- as.numeric(Dates$LastDate)
Dates$Course <- as.numeric (Dates$CourseDate)
Dates$Last[is.na(Dates$Last)] <-0
Dates$Course[is.na(Dates$Course)] <- 0

Dates$Check <- case_when(
  Dates$Last ==0 & Dates$Course == 0 ~ "Neither", 
  Dates$Last >0 & Dates$Course ==0 ~ "Last", 
  Dates$Last == 0 & Dates$Course > 0 ~ "Course", 
  Dates$Last >0 & Dates$Course > 0 ~ "Both"
)
DateChecks <- as.data.frame(table(Dates$Check))

# Results
# Both - 113
# Course Only - 364
# Report Only - 671

#Create a table that merges the report data and the user data
df2 <- merge(Reports2, Users, by = "UserId", all = TRUE)

#tidy data
tidydf2 <-gather(df2, "Activity", "Count", 4:5)

#plot type of usage by Level 1 Group, per user. Not the number of interactions. 
ggplot(tidydf2, aes(x=L1, y = Count, fill = Activity)) + geom_bar(stat = "identity", position = "dodge") + labs(x = "Level 1 Group", title = "Number of Users in Each Level 1 Using the Software") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View")) + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1))

#Merge training data with df2, which is user and report data
df3 <- merge(df2, TrainingData, by = "UserId", all = TRUE)
tidydf3 <-gather(df3, "Activity", "Count", 4:5)
ggplot(tidydf3, aes(x=Rank, y = Count, fill = Activity)) + geom_bar(stat = "identity", position = "dodge") + labs(x = "Rank", title = "Number of Users of Each Rank Using the Software") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View")) + theme(axis.text.x = element_text(size= 10, angle = 45, hjust = 1, vjust = 1))

#Summarize the number of interactions had with each function by L1
Interactions <- df %>% group_by(L1) %>% summarize(createsum = sum(CreateRevise, na.rm = TRUE), refreshsum = sum(RefreshView, na.rm = TRUE))

#take out users with no L1
Interactions2 <- Interactions[3:27,]

#tidy data
tidyInteractions2 <- gather(Interactions2, "Activity", "Interactions", 2:3)

#Plot who is doing which activities more often in the report writing software. Interactions. 
ggplot(tidyInteractions2, aes(x=L1, y = Interactions, fill = Activity)) + geom_bar(stat="identity", position = "dodge") + labs(x = "Level 1 Group", title = "Number of interactions, by type and Level 1") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View")) + theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1))

#Calculate number of interactions by rank, as able
df3$Rank2 <- fct_explicit_na(df3$Rank)
Interaction3 <- df3 %>% group_by(Rank2) %>% summarize(createsum = sum(CreateRevise, na.rm=TRUE), refreshsum = sum(RefreshView, na.rm = TRUE))
tidyInteractions3 <- gather(Interaction3, "Activity", "Interactions", 2:3)


#Remove missing data
tidyInteractions3 <- subset(tidyInteractions3, Rank2 != "(Missing)")
tidyInteractions3 <- subset(tidyInteractions3, Rank2 != "")
ggplot(tidyInteractions3, aes(x=Rank2, y = Interactions, fill = Activity)) + geom_bar(stat="identity", position = "dodge") + labs(x = "Rank", title = "Number of interactions, by type and Rank") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View")) + theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1))


#summarize the number of users participating in each function by L1 (create/review, refresh/biew, training)
#Create a table with L1 and training date
UserActivity <- Training[c(1,3)]
#Create a column with the Activity as "training"
UserActivity$Activity <- "Training"
#Set the training count to 1
UserActivity$Count <- 1
#Drop the course date
UserActivity <- UserActivity[c(-1)]
#From the tidy report data, drop unneccessary columns
tidyreports3 <- tidyreports2[c(-2, -3, -4, -5)]
#Join User Activity and Tidy Reports data together to get a tidy summary of the different functions by L1
UserActivity <- rbind(UserActivity, tidyreports3)

ggplot(UserActivity, aes(x=L1, y=Count, fill = Activity)) + geom_bar(stat="identity", position = "dodge")+ labs(x = "Level 1 Group", title = "Number of users who have completed training or use the software") + scale_fill_discrete(name = "Activity", labels = c("Create or Revise", "Refresh or View", "Training")) + theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1))

#Summary of how many users from each L1 are completing each activity
UserSummary <- as.data.frame(table(UserActivity$L1, UserActivity$Activity))

#Create a table to summarize the roles by Rank and L1
Role <- as.data.frame(table(Create$Rank, Create$L1, Create$Role))
Role <- subset(Role, Freq>0)
names(Role) <- c("Rank", "L1", "Role", "Freq")

ggplot(Role, aes(x=Role, y = Freq, fill = L1)) + geom_bar(stat="identity", position = "dodge")+ theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) + labs(title = "Number of people in each role by L1 group")

ggplot(Role, aes(x=L1, y = Freq, fill = Role)) + geom_bar(stat="identity", position = "dodge")+ theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) + labs(title = "Number of people in each role by L1 group")

ggplot(Role, aes(x=Rank, y = Freq, fill = Role)) + geom_bar(stat="identity", position ="dodge")+ theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) + labs(title = "Number of people in each role by Rank")

ggplot(Role, aes(x=Role, y = Freq, fill = Rank)) + geom_bar(stat="identity", position ="dodge")+ theme(axis.text.x = element_text(size = 10, angle = 45, hjust = 1, vjust = 1)) + labs(title = "Number of people in each role by Rank")
