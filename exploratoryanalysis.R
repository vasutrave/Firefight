library('RSQLite')
conn <- dbConnect(SQLite(), 'C:/Users/User/Downloads/FPA_FOD_20170508.sqlite')

# pull the fires table into RAM
fires <- dbReadTable(conn,"Fires")

# disconnect from db
dbDisconnect(conn)

#Frequency of fires according to their sizes 
df<-data.frame(table(fires$FIRE_SIZE_CLASS))
colnames(df)<-c("Class","Frequency")
pie1<-ggplot(df,aes(x="", y=Frequency, fill=Class))+geom_bar(width=1,stat="identity")+ggtitle("Different classes of fire")+coord_polar(theta="y")
pie1

#pie chart with causes of fire
dfa<-data.frame(table(fires$STAT_CAUSE_DESCR))
colnames(dfa)<-c("Class","Frequency")
pie2<-ggplot(dfa,aes(x="", y=Frequency, fill=Class))+geom_bar(width=1,stat="identity")+ggtitle("Different causes of fire")+coord_polar(theta="y")
pie2

#Most common Cause of Fire
p2 <- as.data.frame(table(fires$STAT_CAUSE_DESCR))
p2 <- p2[with(p2,order(-Freq)),]

p <- plot_ly(
  x = p2$Var1,
  y = p2$Freq,
  name = "Nubers of fires according to the cause",
  type = "bar"
) %>% layout(title = "Causes of Wildfires",xaxis = list(title = "Cause"), yaxis = list(title = "Number of Fires"))
p
#number of gires per State
p3<- as.data.frame(table(fires$STATE))
p3 <- p3[with(p3,order(-Freq)),]
barplot(sort(summary(as.factor(fires$STATE)))[c(30:55)],main = "States of WildFires",las=2)
p <- plot_ly(
  x = p3$Var1,
  y = p3$Freq,
  type = "bar"
) %>% layout(title = "Nubers of fires according to the State",xaxis = list(title = "States"), yaxis = list(title ="Number of Fires"))
p

#Number of fires per year
p4<- as.data.frame(table(fires$FIRE_YEAR))

p <- plot_ly(
  x = factor(p4$Var1),
  y = p4$Freq,
  name = "Numbers of fires according to the cause",
  type = "bar"
) %>% layout(title = "Nubers of fires according to the Year",xaxis = list(title = "Year"), yaxis = list(title ="Number of Fires"))
p



#No of fires per county

fires <- fires[is.na(fires$COUNTY) == FALSE,]
p1<- as.data.frame(table(fires$COUNTY))
p1 <- p1[with(p1,order(-Freq)),]
p3 <- p1[c(1:20),]
p <- plot_ly(
  x = factor(p3$Var1),
  y = p3$Freq,
  name = "Numbers of fires according to the cause",
  type = "bar"
) %>% layout(title = "Nubers of fires according to the Counties",xaxis = list(title = "Counties"), yaxis = list(title ="Number of Fires"))
p

