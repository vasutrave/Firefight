library('RSQLite')
library(ggplot2)
library(ggfortify)
conn<-dbConnect(SQLite(),"E:/academics/5th_sem/Data Analytics/project/FPA_FOD_20170508.sqlite")
fires<-dbReadTable(conn,"Fires")
dbDisconnect(conn)

fires <- fires[,c("FIRE_YEAR","DISCOVERY_DOY")]
mat <- matrix(0,nrow = nrow(fires),ncol = 3)

i=1
while(i<=nrow(fires))
{
      if(fires$DISCOVERY_DOY[i] > 0 & fires$DISCOVERY_DOY[i] < 32)
        mat[i][1] =
      else if(fires$DISCOVERY_DOY[i] >= 32 & fires$DISCOVERY_DOY[i] < 69)
        mat[i][1] =2
      else if(fires$DISCOVERY_DOY[i] >= 69 & fires$DISCOVERY_DOY[i] < 100)
        mat[i][1] =3
      else if(fires$DISCOVERY_DOY[i] >= 100 & fires$DISCOVERY_DOY[i] < 131)
        mat[i][1] =4
      else if(fires$DISCOVERY_DOY[i] >= 131 & fires$DISCOVERY_DOY[i] < 161)
        mat[i][1] =5
      else if(fires$DISCOVERY_DOY[i] >= 161 & fires$DISCOVERY_DOY[i] < 192)
        mat[i][1] =6
      else if(fires$DISCOVERY_DOY[i] >= 192 & fires$DISCOVERY_DOY[i] < 222)
        mat[i][1] =7
      else if(fires$DISCOVERY_DOY[i] >= 222 & fires$DISCOVERY_DOY[i] < 253)
        mat[i][1] =8
      else if(fires$DISCOVERY_DOY[i] >= 253 & fires$DISCOVERY_DOY[i] < 283)
        mat[i][1] =9
      else if(fires$DISCOVERY_DOY[i] >= 283 & fires$DISCOVERY_DOY[i] < 314)
        mat[i][1] =10
      else if(fires$DISCOVERY_DOY[i] >= 314 & fires$DISCOVERY_DOY[i] < 344)
        mat[i][1] =11
      else
        mat[i][1] =12
      i<-i+1
}
a<-mat[,1]
df<-fires
df$MONTH<-a
df1<-data.frame(Year=df$FIRE_YEAR,Month=df$MONTH)
b<-data.frame(table(df1))
newdf<-b[order(b$Year,b$Month),]
ts3<-ts(newdf$Freq,start=c(1992,1),end=c(2015,12),frequency=12)
plot.ts(ts3,xlim=c(1992,2004),main="Frequency of fires with respect to time (1992-2003)")
plot.ts(ts3,xlim=c(2004,2015),main="Frequency of fires with respect to time (2004-2015)")