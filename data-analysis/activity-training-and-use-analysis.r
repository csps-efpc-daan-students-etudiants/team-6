# Author: Jason Albino

## This code describes the steps taken to obtain average count of instances to create and to view reports of learners who have completed training and the average time elapsed
## between start of training and last usage of system, segmented by rank.

## Relevant data was only obtained from the 113 learners with known first days of training and last used dates

## Merge the first sheet of the Report Usage file with the training file. The 2 files were already read in and assigned variables

df2 <- df_usage
df1 <- df_training

my_data <- merge(df2, df1, by=c('UserId'), all.x = T)

names(my_data) <- c("UserId", "Create", "View", "Last_Day", "First_Day", "Course", "L1", "Rank", "Location", "Provider") ##Assign user-defined names

my_data$Last_Day <- round_date(my_data$Last_Day, unit = "day") 								## Strip time from date stamp
my_data$First_Day <- round_date(my_data$First_Day, unit = "day")							## Strip time from date stamp

my_data$Rank <- sapply(my_data$Rank, function(v) { if (is.character(v)) return(toupper(v)) else return(v)})		## Convert all ranks to uppercase

my_data$dateDiff <- my_data$Last_Day - my_data$First_Day								## Create column with time elapsed

## Calculate the mean instances for report creation and report viewing, by rank

reports <- c(2,3,8)													## Create vector of indices for subsetting

reportData <- my_data[, reports]											## Extract relevant columns from merged sheet

aggMean <- aggregate(reportData, by = list(my_data$Rank), FUN = mean)							

## Calculate the mean time elapsed between start of training and last time used

dates <- c(8,11)													## Create vector of indices for subsetting

dateDiffData <- reportData[, dates]											## Extract relevant columns from merged sheet

aggDiffMean <- aggregate(dateDiffData, by = list(my_data$Rank), FUN = mean)

> aggMean
   Group.1    Create     View Rank
1      2LT  15.00000 122.0000   NA
2     CAPT  17.50000 115.0000   NA
3      CDR  11.00000  64.0000   NA
4      CIV        NA 161.0563   NA
5      CPL 116.00000 119.0000   NA
6     LCDR  13.50000 164.0000   NA
7     LCOL  15.20000 145.8000   NA
8    LT(N)  17.00000 188.0000   NA
9      MAJ        NA 245.5455   NA
10    MCPL  16.00000 250.0000   NA
11     MWO  13.66667 272.6667   NA
12      WO  43.00000 187.0000   NA

> aggDiffMean
   Group.1 Rank    dateDiff
1      2LT   NA   4.000000 
2     CAPT   NA  25.666667 
3      CDR   NA   3.000000 
4      CIV   NA  50.098592 
5      CPL   NA  60.000000 
6     LCDR   NA 149.000000 
7     LCOL   NA   4.000000 
8    LT(N)   NA 163.000000 
9      MAJ   NA  66.363636 
10    MCPL   NA  53.666667 
11     MWO   NA   6.666667 
12      WO   NA 115.000000 


## Add column with date the data was received

my_data$dateReceived <- as.POSIXct(rep("2019-05-28", nrow(my_data)))

my_data$daysSince <- my_data$dateReceived - my_data$Last_Day								## Calculate number of days since last use

## Calculate mean time between 28 May 2019 and last time used, by rank

recent <- c(8,13)													                              ## Create vector of indices
recentData <- my_data[, recent]											                  	## Extract columns
aggRecent <- aggregate(recentData, by = list(my_data$Rank), FUN = mean)							
> aggRecent
   Group.1 Rank  daysSince
1      2LT   NA 200.16667 
2     CAPT   NA 157.33333 
3      CDR   NA 248.16667 
4      CIV   NA 148.94131 
5      CPL   NA  60.16667 
6     LCDR   NA  90.16667 
7     LCOL   NA 184.36667 
8    LT(N)   NA  97.16667 
9      MAJ   NA 110.71212 
10    MCPL   NA 115.50000 
11     MWO   NA 150.83333 
12      WO   NA  61.16667 


## This code locates users who have completed the training (n =113) with mean calculations performed by rank and by L1

> df3 <- df1$UserId
> df4 <- df2$UserId
> intersect(df3, df4)													## Users who have taken training
  [1] "User009" "User027" "User111" "User060" "User056" "User079" "User028" "User069" "User100" "User088" "User105"
 [12] "User075" "User029" "User030" "User032" "User005" "User013" "User062" "User047" "User071" "User001" "User091"
 [23] "User101" "User089" "User020" "User080" "User017" "User044" "User113" "User046" "User018" "User010" "User048"
 [34] "User059" "User033" "User092" "User034" "User002" "User057" "User012" "User081" "User036" "User107" "User016"
 [45] "User074" "User118" "User072" "User052" "User006" "User051" "User050" "User095" "User037" "User099" "User085"
 [56] "User076" "User065" "User058" "User014" "User022" "User093" "User073" "User109" "User011" "User003" "User004"
 [67] "User038" "User114" "User068" "User015" "User094" "User040" "User117" "User021" "User103" "User054" "User102"
 [78] "User104" "User119" "User115" "User007" "User049" "User116" "User070" "User024" "User055" "User082" "User031"
 [89] "User019" "User064" "User067" "User041" "User084" "User008" "User090" "User096" "User097" "User063" "User045"
[100] "User077" "User078" "User083" "User025" "User112" "User110" "User053" "User042" "User026" "User108" "User087"
[111] "User098" "User106" "User086"

## Number of unique users
df5 <- intersect(df3, df4)
> table(df5)
df5
User001 User002 User003 User004 User005 User006 User007 User008 User009 User010 User011 User012 User013 User014 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User015 User016 User017 User018 User019 User020 User021 User022 User024 User025 User026 User027 User028 User029 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User030 User031 User032 User033 User034 User036 User037 User038 User040 User041 User042 User044 User045 User046 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User047 User048 User049 User050 User051 User052 User053 User054 User055 User056 User057 User058 User059 User060 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User062 User063 User064 User065 User067 User068 User069 User070 User071 User072 User073 User074 User075 User076 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User077 User078 User079 User080 User081 User082 User083 User084 User085 User086 User087 User088 User089 User090 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User091 User092 User093 User094 User095 User096 User097 User098 User099 User100 User101 User102 User103 User104 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User105 User106 User107 User108 User109 User110 User111 User112 User113 User114 User115 User116 User117 User118 
      1       1       1       1       1       1       1       1       1       1       1       1       1       1 
User119 
      1 

> common <- my_data$UserId %in% df5
> df6 <- my_data[common, ]
> nrow(df6)
[1] 113

> sum(is.na(df6$Rank))
[1] 7

> table(df6$Rank)

  2LT  CAPT   CDR   CIV   CPL  LCDR  LCOL LT(N)   MAJ  MCPL   MWO    WO 
    1     6     1    71     1     2     5     1    11     3     3     1 

> reportData2 <- df6[, reports]
> aggCreate <- aggregate(reportData2, by=list(reportData2$Rank), FUN = mean)

aggCreate <- aggregate(reportData2, by=list(reportData2$Rank), FUN = mean, na.rm = T)
> aggCreate
   Group.1    Create     View Rank
1      2LT  15.00000 122.0000   NA
2     CAPT  17.50000 115.0000   NA
3      CDR  11.00000  64.0000   NA
4      CIV  17.24286 161.0563   NA
5      CPL 116.00000 119.0000   NA
6     LCDR  13.50000 164.0000   NA
7     LCOL  15.20000 145.8000   NA
8    LT(N)  17.00000 188.0000   NA
9      MAJ  26.11111 245.5455   NA
10    MCPL  16.00000 250.0000   NA
11     MWO  13.66667 272.6667   NA
12      WO  43.00000 187.0000   NA
> recentData2 <- df6[, recent]

> aggRecent2 <- aggregate(recentData2, by= list(reportData2$Rank), FUN = mean)

> aggRecent2
   Group.1 Rank  daysSince
1      2LT   NA 200.16667 
2     CAPT   NA 157.33333 
3      CDR   NA 248.16667 
4      CIV   NA 148.94131 
5      CPL   NA  60.16667 
6     LCDR   NA  90.16667 
7     LCOL   NA 184.36667 
8    LT(N)   NA  97.16667 
9      MAJ   NA 110.71212 
10    MCPL   NA 115.50000 
11     MWO   NA 150.83333 
12      WO   NA  61.16667 
