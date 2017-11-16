library('caret')
library('rpart')
fires <- read.csv('C:/Users/User/Desktop/fifth/Data Analyss/Project/Firefight/season.csv')

features <- c("STATE","STAT_CAUSE_CODE","FIRE_SIZE_CLASS")

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

# Train the decision tree model
set.seed(123)
dtree <- train(x = x_train,
               y = y_train,
               method = 'rpart',
               trControl = tr_control)
# make predictions using test set
preds <- predict(dtree, newdata = x_test)

# calculate accuracy on test set
test_set_acc <- round(sum(y_test == preds)/length(preds), 4)
print(paste(c("Accuracy:" , test_set_acc)))