library('RSQLite')
conn <- dbConnect(SQLite(), 'C:/Users/User/Downloads/FPA_FOD_20170508.sqlite')

# pull the fires table into RAM
fires <- dbReadTable(conn,"Fires")

# disconnect from db
dbDisconnect(conn)



ctrl <- fires[is.na(fires$CONT_DATE) == FALSE,"CONT_DATE"]-fires[is.na(fires$CONT_DATE) == FALSE,"DISCOVERY_DATE"]
cor(ctrl, fires[is.na(fires$CONT_DATE) == FALSE,"FIRE_SIZE"])

plot(fires[is.na(fires$CONT_DATE) == FALSE,"FIRE_SIZE"],ctrl,xlim = c(0,40000),ylim = c(0,10000))

df <- as.data.frame(cbind(fires[is.na(fires$CONT_DATE) == FALSE,"FIRE_SIZE"],ctrl))
set.seed(123)
train_index <- sample(c(TRUE, FALSE), nrow(df), replace = TRUE, prob = c(0.8, 0.2))
test_index <- !train_index

# Create x/y, train/test data
x_train <- df[train_index,]
x_test <- df[test_index,]

model <- lm(ctrl~V1,x_train)
summary(model)
p <- predict(model,x_test)

error <- mean((abs(p-x_test$ctrl))/p)
