df<-data.frame(table(fires$FIRE_SIZE_CLASS))
colnames(df)<-c("Class","Frequency")
pie1<-ggplot(df,aes(x="", y=Frequency, fill=Class))+geom_bar(width=1,stat="identity")+ggtitle("Different classes of fire")+coord_polar(theta="y")
pie1

#Most common Cause of Fire
p2 <- as.data.frame(table(fires$STAT_CAUSE_DESCR))
p2 <- p2[with(p2,order(-Freq)),]
#barplot(sort(summary(p2)),main = "Causes of WildFires",ylab = "Number of Wildfires ",las=2)
p <- plot_ly(
  x = p2$Var1,
  y = p2$Freq,
  name = "Nubers of fires according to the cause",
  type = "bar"
) %>% layout(title = "Causes of Wildfires",xaxis = list(title = "Cause"), yaxis = list(title = "Number of Fires"))
p

# Create a sh
#Most common states(Top 26)
p3<- as.data.frame(table(fires$STATE))
p3 <- p3[with(p3,order(-Freq)),]
#barplot(sort(summary(as.factor(fires$STATE)))[c(30:55)],main = "States of WildFires",las=2)
p <- plot_ly(
  x = p3$Var1,
  y = p3$Freq,
  name = "Nubers of fires according to the cause",
  type = "bar"
) %>% layout(title = "Nubers of fires according to the State",xaxis = list(title = "States"), yaxis = list(title ="Number of Fires"))
p
#legend("topright", legend = c("California", "Georgia","Texas"))


#Number of wildfires each year
#barplot(summary(as.factor(fires$FIRE_YEAR)),las=2, ylab = "Number of Wildfires"
        , xlab = "Year", main = "Number of wildfires per year")
p3<- as.data.frame(table(fires$FIRE_YEAR))
p3 <- p3[with(p3,order(-Freq)),]
p<-plot_ly(
  x = p3$Var1,
  y = p3$Freq,
  name = "Number of Wildfires",
  type = "bar"
) %>% layout(title = "Number of Wildfires per Year",xaxis = list(title = "Years"), yaxis = list(title ="Number of Fires"))
p

#pie(ad$Freq,main = "Number of Patients : Type1 / Type2")


