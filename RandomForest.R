library('caret')
library('rpart')
fires <- read.csv('C:/Users/vrnsr/Downloads/Data Analytics/project/season.csv')

features <- c("STAT_CAUSE_CODE","FIRE_SIZE_CLASS","STATE")

fires$season <- as.factor(fires$season)

# index for train/test split
set.seed(123)
train_index <- sample(c(TRUE, FALSE), nrow(fires), replace = TRUE, prob = c(0.8, 0.2))
test_index <- !train_index

# Create x/y, train/test data
x_train <- as.data.frame(fires[train_index, features])
y_train <- fires$season[train_index]

x_test <- as.data.frame(fires[test_index, features])
y_test <- fires$season[test_index]

tr_control <- trainControl(method = 'cv', number = 3)

set.seed(123)
#24 mins on i7
rfmodel <- train(x = x_train,
                 y = y_train,
                 method = 'rf',
                 tuneLength = 3,
                 ntree = 100,
                 trControl = tr_control)

preds <- predict(rfmodel, newdata = x_test)

# calculate accuracy on test set
test_set_acc <- sum(y_test == preds)/length(preds)
print(paste(c("Accuracy:" , round(test_set_acc, 4))))

#acc <- round(sum(test$season==preds)/length(preds),4)

con <- table(y_test,preds)
con
sum(diag(con))/sum(con)
confusionMatrix(y_test,preds)
