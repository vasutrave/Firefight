library("RSQLite")
library("ggplot2")
library("plotrix")
library(reshape2)
library("ppls")
library(caret)
library(MLmetrics)
library(maps)

conn<-dbConnect(SQLite(),"E:/academics/5th_sem/Data Analytics/project/FPA_FOD_20170508.sqlite")
fires<-dbReadTable(conn,"Fires")
dbDisconnect(conn)

df<-data.frame(table(fires$FIRE_SIZE_CLASS))
colnames(df)<-c("Class","Frequency")

#Pie chart with diff classes of fire
#pie1<-ggplot(df,aes(x="", y=Frequency, fill=Class))+geom_bar(width=1,stat="identity")+ggtitle("Different classes of fire")+coord_polar(theta="y")
#pie1

#pie chart with causes of fire
#dfa<-data.frame(table(fires$STAT_CAUSE_DESCR))
#colnames(dfa)<-c("Class","Frequency")
#pie2<-ggplot(dfa,aes(x="", y=Frequency, fill=Class))+geom_bar(width=1,stat="identity")+ggtitle("Different causes of fire")+coord_polar(theta="y")
#pie2

#Heat maps
df1<-data.frame(STATE=fires$STATE,FIRE_SIZE=fires$FIRE_SIZE,CAUSE=fires$STAT_CAUSE_DESCR,YEAR=fires$FIRE_YEAR)

vc<-c(1992,1993,1994,1995,1996,1997,1998,1999,2000)
df2<-df1[is.element(df1$YEAR,vc),]
df2<-df2[,1:3]
df2<-acast(df2,STATE~CAUSE,value.var="FIRE_SIZE")
df2<-as.matrix(df2)
hm<-heatmap(df2,Rowv=NA,Colv=NA,col=heat.colors(256),scale="column",margins=c(5,5),main="Heat map of fire sizes for different counties for different causes during the period 1992-2000")

vc<-c(2001,2002,2003,2004,2005,2006,2007,2008)
df2<-df1[is.element(df1$YEAR,vc),]
df2<-df2[,1:3]
df2<-acast(df2,STATE~CAUSE,value.var="FIRE_SIZE")
df2<-as.matrix(df2)
hm<-heatmap(df2,Rowv=NA,Colv=NA,col=heat.colors(256),scale="column",margins=c(5,5),main="Heat map of fire sizes for different counties for different causes during the period 2001-2008")

vc<-c(2009,2010,2011,2012,2013,2014,2015)
df2<-df1[is.element(df1$YEAR,vc),]
df2<-df2[,1:3]
df2<-acast(df2,STATE~CAUSE,value.var="FIRE_SIZE")
df2<-as.matrix(df2)
hm<-heatmap(df2,Rowv=NA,Colv=NA,col=heat.colors(256),scale="column",margins=c(5,5),main="Heat map of fire sizes for different counties for different causes during the period 2009-2015")



#map
df3<-read.csv("E:/academics/5th_sem/Data Analytics/project/state_map1.csv")
vars<-c("STATE")
df4<-data.frame(table(ST_CODE=fires[vars]))
i=1
df3[,2]= as.character(df3[,2])
df3[,1]= as.character(df3[,1])
df4[,1]= as.character(df4[,1])
while(i<=nrow(df4))
{
	val<-df4[i,1]
	df4[i,1]<-df3[which(df3$Code==val),1]
	i<-i+1
}
df5<-data.frame(STATE=state.name,X=state.center$x,Y=state.center$y)
df5$STATE<-as.character(df5$STATE)
a<-c(as.character("District of Columbia"),-77.0268,38.8974)
b<-c(as.character("Puerto Rico"),-66.5901,18.2208)
df5<-rbind(df5,a)
df5<-rbind(df5,b)
df5$X<-as.numeric(df5$X)
df5$Y<-as.numeric(df5$Y)
df4$long=c(1:52)
df4$lat=c(1:52)
i=1
while(i<=nrow(df5))
{
	val<-df4[i,1]
	df4[i,3]<-df5[which(df5$STATE==val),2]
	df4[i,4]<-df5[which(df5$STATE==val),3]
	i<-i+1
}
world_map<-map_data("usa")
p<-ggplot()+coord_fixed()+xlab("")+ylab("")
base_world<-p+geom_polygon(data=world_map,aes(x=long,y=lat,group=group),color="blue",fill="light blue")
map_data<-base_world+geom_point(data=df4,aes(x=long,y=lat),color="red",fill="orange",pch=21,size=5,alpha=I(0.7))
map_data_colored<-base_world+geom_point(data=df4,aes(x=long,y=lat,size=Freq),pch=21,alpha=I(0.7),fill="Blue")

