library(caret)
library(rpart.plot)
fires <- read.csv('C:/Users/User/Desktop/fifth/Data Analyss/Project/Firefight/season.csv')

smp_size <- floor(0.25 * nrow(fires))

## set the seed to make your partition reproductible
set.seed(123)
train_ind <- sample(seq_len(nrow(fires)), size = smp_size)

train <- fires[train_ind, ]
test <- fires[-train_ind, ]


trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
set.seed(3333)
dtree_fit <- train(season ~., data = train, method = "rpart",
                   parms = list(split = "information"),
                   trControl=trctrl,
                   tuneLength = 10)


prp(dtree_fit$finalModel, box.palette = "Reds", tweak = 1.2)
