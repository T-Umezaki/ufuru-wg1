df_4F <- read.table("4F.csv", header=T, sep=",", encoding="UTF-8")
df_14F <- read.table("14F.csv", header=T, sep=",", encoding="UTF-8")
df_15F <- read.table("15F.csv", header=T, sep=",", encoding="UTF-8")

## 集計データ
start_datetime <- as.POSIXct("2017-01-23 08:00:00", format="%Y-%m-%d %H:%M:%S")
end_datetime <- as.POSIXct("2017-05-31 10:00:00", format="%Y-%m-%d %H:%M:%S")
rec_datetime <- start_datetime

df_times15_sum <- data.frame(start_datetime,"","","",0,0,0,0,0,0,0,0,0)
names(df_times15_sum) <- c("datetime","ej4f","ej14f","ej15f","et4f","et14f","et15f","er4f","er14f","er15f","weth","tempL","tempH")
df_times15_sum<-df_times15_sum[-1,]

while(rec_datetime < end_datetime){
  df_times15_sum <- rbind(df_times15_sum,data.frame("datetime"=rec_datetime,"ej4f"="-","ej14f"="-","ej15f"="-","et4f"=1800,"et14f"=2700,"et15f"=2700,"er4f"=1,"er14f"=1,"er15f"=1,"weth"=1,"tempL"=18,"tempH"=26))
  rec_datetime <- rec_datetime + 900
}

#日付を文字にしておく
df_times15_sum$datetime = as.factor(df_times15_sum$datetime)
df_times15_sum_bk <- df_times15_sum
# df_times15_sum <- df_times15_sum_bk

df_times15_sum <- merge(df_times15_sum,df_4F,by="datetime",all.x = T)
df_times15_sum <- merge(df_times15_sum,df_14F,by="datetime",all.x = T)
df_times15_sum <- merge(df_times15_sum,df_15F,by="datetime",all.x = T)

class(df_times15_sum$ej4f)
class(df_times15_sum$ej1.x)

df_times15_sum$ej4f <-  df_times15_sum$ej1.x
df_times15_sum$ej4f[is.na(df_times15_sum$ej4f)] <-  "-"
df_times15_sum$ej14f <-  df_times15_sum$ej1.y
df_times15_sum$ej14f[is.na(df_times15_sum$ej14f)] <-  "-"
df_times15_sum$ej15f <-  df_times15_sum$ej1
df_times15_sum$ej15f[is.na(df_times15_sum$ej15f)] <-  "-"

df_times15_sum$et4f <- ifelse(!is.na(df_times15_sum$et1.x), df_times15_sum$et1.x, 1800)
df_times15_sum$et14f <- ifelse(!is.na(df_times15_sum$et1.y), df_times15_sum$et1.y, 2700)
df_times15_sum$et15f <- ifelse(!is.na(df_times15_sum$et1), df_times15_sum$et1, 2700)

df_times15_sum$er4f <- ifelse(!is.na(df_times15_sum$er1.x), df_times15_sum$er1.x, 1)
df_times15_sum$er14f <- ifelse(!is.na(df_times15_sum$er1.y), df_times15_sum$er1.y, 1)
df_times15_sum$er15f <- ifelse(!is.na(df_times15_sum$er1), df_times15_sum$er1, 1)

df_toilet_duraion_for_ml <- df_times15_sum[c("datetime","ej4f","ej14f","ej15f","et4f","et14f","et15f","er4f","er14f","er15f")]
write.csv(df_toilet_duraion_for_ml, "toilet_duraion_for_ml.csv", quote=F,row.names=F)
