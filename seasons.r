library('RSQLite')
conn <- dbConnect(SQLite(), 'C:/Users/User/Downloads/FPA_FOD_20170508.sqlite')

# pull the fires table into RAM
fires <- dbReadTable(conn,"Fires")

# disconnect from db
dbDisconnect(conn)

season <- matrix(0,nrow = nrow(fires),ncol = 1)

for (i in (1:nrow(fires)))
{
  if(fires$DISCOVERY_DOY[i] > 59 & fires$DISCOVERY_DOY[i] < 151)
     season[i] <- 1
  else if (fires$DISCOVERY_DOY[i] >= 151 & fires$DISCOVERY_DOY[i] < 243)
    season[i] <- 2
  else if (fires$DISCOVERY_DOY[i] >= 243 & fires$DISCOVERY_DOY[i] < 334)
    season[i] <- 3
  else 
    season[i] <- 4
}

fires <- cbind(fires,season)
fires <- fires[fires$FIRE_YEAR > 2005,c("STATE","STAT_CAUSE_CODE","season","FIRE_SIZE_CLASS")]
write.csv(fires,'C:/Users/User/Desktop/fifth/Data Analyss/Project/Firefight/season.csv')
