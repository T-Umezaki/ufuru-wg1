library(data.table)
library(dplyr)

dt_wifi <-fread("wificategoryforArea.csv", header=T)

#df_wifi_top300 <- dt_wifi[1:300, ,] #テスト用

#dt_wifi_dev <- dt_wifi[,sum(count) , by = vendor ] # デバイス別
#dt_wifi_date <- dt_wifi[,sum(count) , by = datetime ] # 日付別

#相関データとしてappleを使う
dt_wifi <- subset(dt_wifi, vendor=="Apple")

#dt_wifi_apl <- dt_wifi[,sum(count) , by = datetime ]

#15分単位を集計
#dt_wifi_date[, datetime15 := dt_wifi_date[, 1, with=F]]
df_wifi <- data.frame(dt_wifi) 
class(df_wifi)

df_wifi$d <- substr(df_wifi$datetime,1,10)
df_wifi$h <- substr(df_wifi$datetime,12,13)
df_wifi$m <- substr(df_wifi$datetime,15,16)

cond <- (df_wifi$m < "15" & df_wifi$m >= "00")
df_wifi[cond,]$m <- "00"
cond <- (df_wifi$m < "30" & df_wifi$m >= "15")
df_wifi[cond,]$m <- "15"
cond <- (df_wifi$m < "45" & df_wifi$m >= "30")
df_wifi[cond,]$m <- "30"
cond <- (df_wifi$m >= "45")
df_wifi[cond,]$m <- "45"

dt_wifi <- data.table(df_wifi)

dt_wifi2 <- dt_wifi %>% group_by(d,h,m) %>% summarise(flnum := mean(count))
dt_wifi2 <- data.table( dt_wifi2)

dt_wifi2[,datetime := paste(d," ",h,":",m,":00",sep = "")]
dt_wifi2[,flnum := round(flnum,digits=1)]

dt_wifi_sum <- dt_wifi2[, .(datetime, flnum),]
dt_wifi_sum[,datetime := chartr("/","-",datetime),]


write.csv(dt_wifi_sum, "floor_wifi_sum.csv", quote=F,row.names=F)

