library(caret)
library(rpart.plot)
fires <- read.csv('C:/Users/vrnsr/Downloads/Data Analytics/project/season.csv')

smp_size <- floor(0.25 * nrow(fires))

## set the seed to make your partition reproducable
set.seed(123)
train_ind <- sample(seq_len(nrow(fires)), size = smp_size)

train <- fires[train_ind, ]
test <- fires[-train_ind, ]


trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3333)
#This might take 10 min to -- depending on processor speed
dtree_fit <- train(factor(season) ~ factor(STAT_CAUSE_CODE)+factor(STATE)+factor(FIRE_SIZE_CLASS), data = train, method = "rpart",
                   parms = list(split = "information"),
                   trControl=trctrl,
                   tuneLength = 10)


#prp(dtree_fit$finalModel, box.palette = "Reds", tweak = 1.2)
rpart.plot(dtree_fit$finalModel)

p <- predict(dtree_fit,newdata = test)

acc <- round(sum(test$season==p)/length(p),4)

con <- table(test$season,p)
con 
sum(diag(con))/sum(con)

confusionMatrix(test$season,p)
