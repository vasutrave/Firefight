library('RSQLite')
conn <- dbConnect(SQLite(), 'C:/Users/User/Downloads/FPA_FOD_20170508.sqlite')

# pull the fires table into RAM
fires <- dbReadTable(conn,"Fires")

# disconnect from db
dbDisconnect(conn)

fires <- fires[,c("FIRE_YEAR","DISCOVERY_DOY")]
mat <- matrix(0,nrow = nrow(fires),ncol = 3)


for(i in range(1:nrow(fires))){
      if(fires$DISCOVERY_DOY[i] > 0 & fires$DISCOVERY_DOY[i] < 32)
        mat[i][1] =1
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
      
        }