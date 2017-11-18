library(MLmetrics)
library(maps)

conn<-dbConnect(SQLite(),"E:/academics/5th_sem/Data Analytics/project/FPA_FOD_20170508.sqlite")
fires<-dbReadTable(conn,"Fires")
dbDisconnect(conn)

#logistic regression
arr<-c("STAT_CAUSE_CODE","FIRE_SIZE_CLASS","FIRE_YEAR","STATE","DISCOVERY_DOY")
df2<-fires[arr]
df2[is.na(df2)]<-0
len <- round(0.9 * nrow(df2))
train <- df2[c(1:len),]
test <- df2[(len+1):nrow(df2),]
logistic <- glm(factor(STAT_CAUSE_CODE) ~ FIRE_SIZE_CLASS+STATE+DISCOVERY_DOY,family=binomial(link = "logit"),data=train)
print(summary(logistic))
p1<-predict(logistic,test,type="response")
er<-test$STAT_CAUSE_CODE-p1
er1<-er/test$STAT_CAUSE_CODE
er2<-mean(abs((er1)))*100
