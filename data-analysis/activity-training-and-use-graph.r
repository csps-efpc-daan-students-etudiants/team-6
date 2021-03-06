# Author: Jason Albino

## This code describes how the different plots were created

## Bar Chart for create

gr_Create <- aggCreate[ , 1:2]
> colnames(gr_Create) <- c("Rank", "Average")
> gr_Create <- gr_Create[order(gr_Create$Average), ]
> gr_Create$Rank <- factor(gr_Create$Rank, levels = gr_Create$Rank)
> ggplot(gr_Create, aes(x=Rank, y=Average))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "Rank Vs Average Reports Created", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))


## Bar Chart for view

> view <- c(1,3)
> gr_View <- aggCreate[, view]
> colnames(gr_View) <- c("Rank", "Average")
> gr_View <- gr_View[order(gr_View$Average), ]
> gr_View$Rank <- factor(gr_View$Rank, levels = gr_View$Rank)
> ggplot(gr_View, aes(x=Rank, y=Average))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "Rank Vs Average Reports Viewed", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

## Bar Chart for recency of views, by rank

> gr_Recent <- aggRecent2[ , view]

> gr_Recent
   Group.1  daysSince
1      2LT 200.16667 
2     CAPT 157.33333 
3      CDR 248.16667 
4      CIV 148.94131 
5      CPL  60.16667 
6     LCDR  90.16667 
7     LCOL 184.36667 
8    LT(N)  97.16667 
9      MAJ 110.71212 
10    MCPL 115.50000 
11     MWO 150.83333 
12      WO  61.16667 
> colnames(gr_Recent) <- c("Rank", "Days")
> gr_Recent <- gr_Recent[order(gr_Recent$Days),]
> gr_Recent$Rank <- factor(gr_Recent$Rank, levels = gr_Recent$Rank)
> ggplot(gr_Recent, aes(x=Rank, y=Days))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "Rank Vs Average Days Since Last Used", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

> gr_Recent$Days <- as.numeric(gr_Recent$Days)
> ggplot(gr_Recent, aes(x=Rank, y=Days))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "Rank Vs Average Days Since Last Used", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

## Bar Chart for create, by L1

gr_CreateL1 <- aggCreateL1[ , 1:2]
> colnames(gr_CreateL1) <- c("L1", "Average")
> gr_CreateL1 <- gr_CreateL1[order(gr_CreateL1$Average), ]
> gr_CreateL1$L1 <- factor(gr_CreateL1$L1, levels = gr_CreateL1$L1)
> ggplot(gr_CreateL1, aes(x=L1, y=Average))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "L1 Vs Average Reports Created", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

## Bar Chart for view, by L1

> view <- c(1,3)
> gr_ViewL1 <- aggCreateL1[, view]
> colnames(gr_ViewL1) <- c("L1", "Average")
> gr_ViewL1 <- gr_ViewL1[order(gr_ViewL1$Average), ]
> gr_ViewL1$L1 <- factor(gr_ViewL1$L1, levels = gr_ViewL1$L1)
> ggplot(gr_ViewL1, aes(x=L1, y=Average))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "L1 Vs Average Reports Viewed", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))

## Bar Chart for recency of views, by L1

gr_Recent2L1 <- aggRecent2L1[ , view]
> colnames(gr_Recent2L1) <- c("L1", "Days")
> gr_Recent2L1 <- gr_Recent2L1[order(gr_Recent2L1$Days),]
> gr_Recent2L1$L1 <- factor(gr_Recent2L1$L1, levels = gr_Recent2L1$L1)
> ggplot(gr_Recent2L1, aes(x=L1, y=Days))+ geom_bar(stat = "identity", width = .5, fill = "tomato3")+ 
labs(title = "Ordered Bar Chart", subtitle = "L1 Vs Average Days Since Last Used", caption = "source: DND")+ 
theme(axis.text.x = element_text(angle = 65, vjust = 0.6))
