df_wether <- read.table("weather_data1.csv", header=T, sep=",", encoding="shift-jis")
#date format yyyy/m/d ==> yyyy/mm/dd
df_wether$date2 <- as.factor(as.Date(df_wether$date))
df_wether$date <- df_wether$date2
df_wether$date2 <- NULL


df_toilet_duraion_for_ml <- read.table("toilet_duraion_for_ml.csv", header=T, sep=",", encoding="utf-8")

df_toilet_duraion_for_ml$date <- substring(df_toilet_duraion_for_ml$datetime,1,10)
df_toilet_duraion_for_ml <- merge(df_toilet_duraion_for_ml,df_wether,by="date",all.x = T)
df_toilet_duraion_for_ml$date <- NULL
df_toilet_duraion_for_ml$flnum <- 80

write.csv(df_toilet_duraion_for_ml, "toilet_duraion_for_ml.csv", quote=F,row.names=F)
