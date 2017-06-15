df_ml <- read.table("toilet_duraion_for_ml.csv", header=T, sep=",", encoding="shift-jis")
df_floor <- read.table("floor_wifi_sum.csv", header=T, sep=",", encoding="UTF-8")

df_ml$flnum <- NULL

df_ml_with_floor <- merge(df_ml,df_floor,by="datetime",all.x = T)

#ついでに時間と曜日データ作成
df_ml_with_floor$time <- substr(df_ml_with_floor$datetime,12,16)
df_ml_with_floor$day <- as.POSIXlt(df_ml_with_floor$datetime)
df_ml_with_floor$day <- weekdays(df_ml_with_floor$day)

write.csv(df_ml_with_floor, "toilet_duraion_for_ml.csv", quote=F,row.names=F)
