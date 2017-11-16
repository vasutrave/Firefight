library(caret)
df <- read.csv()

set.seed(3033)
intrain <- createDataPartition(y = df$season,p = 0.7, list = FALSE)
train <- df[intrain,]
test <- df[-intrain,]

train[["season"]] <- factor(train[["season"]])

trctrl <- trainControl(method = "repeatedCV",number = 10,repeats = 3)

set.seed(3233)

svm_linear <- train(season ~., data = train, 				method = "svmLinear",
                 trControl=trctrl,
                 preProcess = c("center", "scale"),
                 tuneLength = 10)




