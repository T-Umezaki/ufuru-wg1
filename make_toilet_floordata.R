#setwd("C:\umezaki\github\ufuru-wg1")  # 作業ディレクトリ
#getwd()

df_times15 <- read.table("things_times15.csv", header=T, sep=",", encoding="UTF-8")

#個室データを階毎にサマリ
cond <- (df_times15$thing_id=="04M01") #力技TT 
df_floor_sum <- df_times15[cond,]
cond <- (df_times15$thing_id=="04M02")
df_floor_sum <- merge(df_floor_sum, df_times15[cond,], by="datetime", all=T)

#NA除去
df_floor_sum$ej.x <- ifelse(is.na(df_floor_sum$ej.x),"-","X")  
df_floor_sum$ej.y <- ifelse(is.na(df_floor_sum$ej.y),"-","X")  
df_floor_sum$et.x[is.na(df_floor_sum$et.x)]<-900
df_floor_sum$et.y[is.na(df_floor_sum$et.y)]<-900

#空室演算 &&が使えない → 　&ならOKだったはず
df_floor_sum$ej1<- "X"
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.x != "X","-",df_floor_sum$ej1)  
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.y != "X","-",df_floor_sum$ej1)  

#使用時間
df_floor_sum$et1 <- df_floor_sum$et.x+df_floor_sum$et.y

#riyoutitsu
df_floor_sum$er1 <- round(df_floor_sum$et1/1800,digits=2)
df_4F <- df_floor_sum[c("datetime","ej1","et1","er1")]

## 14F 力技TT
#個室データを階毎にサマリ
cond <- (df_times15$thing_id=="14M01") #力技TT 
df_floor_sum <- df_times15[cond,]
cond <- (df_times15$thing_id=="14M02")
df_floor_sum <- merge(df_floor_sum, df_times15[cond,], by="datetime", all=T)
cond <- (df_times15$thing_id=="14M03")
df_floor_sum <- merge(df_floor_sum, df_times15[cond,], by="datetime", all=T)

#NA除去
df_floor_sum$ej.x <- ifelse(is.na(df_floor_sum$ej.x),"-","X")  
df_floor_sum$ej.y <- ifelse(is.na(df_floor_sum$ej.y),"-","X")  
df_floor_sum$ej <- ifelse(is.na(df_floor_sum$ej),"-","X")  
df_floor_sum$et.x[is.na(df_floor_sum$et.x)]<-900
df_floor_sum$et.y[is.na(df_floor_sum$et.y)]<-900
df_floor_sum$et[is.na(df_floor_sum$et)]<-900

#空室演算 &&が使えない
df_floor_sum$ej1<- "X"
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.x != "X","-",df_floor_sum$ej1)  
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.y != "X","-",df_floor_sum$ej1)  
df_floor_sum$ej1<- ifelse(df_floor_sum$ej != "X","-",df_floor_sum$ej1)  

#使用時間
df_floor_sum$et1 <- df_floor_sum$et.x+df_floor_sum$et.y + df_floor_sum$et

#riyoutitsu
df_floor_sum$er1 <- round(df_floor_sum$et1/2700,digits=2)
df_14F <- df_floor_sum[c("datetime","ej1","et1","er1")]

## 15F 力技TT
#個室データを階毎にサマリ
cond <- (df_times15$thing_id=="15M01") #力技TT 
df_floor_sum <- df_times15[cond,]
cond <- (df_times15$thing_id=="15M02")
df_floor_sum <- merge(df_floor_sum, df_times15[cond,], by="datetime", all=T)
cond <- (df_times15$thing_id=="15M03")
df_floor_sum <- merge(df_floor_sum, df_times15[cond,], by="datetime", all=T)

#NA除去
df_floor_sum$ej.x <- ifelse(is.na(df_floor_sum$ej.x),"-","X")  
df_floor_sum$ej.y <- ifelse(is.na(df_floor_sum$ej.y),"-","X")  
df_floor_sum$ej <- ifelse(is.na(df_floor_sum$ej),"-","X")  
df_floor_sum$et.x[is.na(df_floor_sum$et.x)]<-900
df_floor_sum$et.y[is.na(df_floor_sum$et.y)]<-900
df_floor_sum$et[is.na(df_floor_sum$et)]<-900

#空室演算 &&が使えない
df_floor_sum$ej1<- "X"
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.x != "X","-",df_floor_sum$ej1)  
df_floor_sum$ej1<- ifelse(df_floor_sum$ej.y != "X","-",df_floor_sum$ej1)  
df_floor_sum$ej1<- ifelse(df_floor_sum$ej != "X","-",df_floor_sum$ej1)  

#使用時間
df_floor_sum$et1 <- df_floor_sum$et.x+df_floor_sum$et.y + df_floor_sum$et

#riyoutitsu
df_floor_sum$er1 <- round(df_floor_sum$et1/2700,digits=2)
df_15F <- df_floor_sum[c("datetime","ej1","et1","er1")]

write.csv(df_15F, "15F.csv", quote=F,row.names=F)
write.csv(df_14F, "14F.csv", quote=F,row.names=F)
write.csv(df_4F, "4F.csv", quote=F,row.names=F)

