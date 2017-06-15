library(data.table)
library(dplyr)

# トイレの空室情報を作成する
#setwd("C:\umezaki\github\ufuru-wg1")  # 作業ディレクトリ
#getwd()

#POSIXct初期値
posixct <- as.POSIXct("2013-01-17 15:24:24.123456", format="%Y-%m-%d %H:%M:%OS")

df_org <- read.table("toilet_duraion_20170531-sjis.csv", header=T, sep=",", encoding="UTF-8")
# for debug df_org <- df_org[158:164,]


# 個室毎に個別データを並び替え
df_org <- df_org[order(df_org$thing_id,df_org$status_start),]

# 時間軸に変更する
df_times15 <- data.frame("",posixct,"",0,0)
names(df_times15) <- c("thing_id","datetime","ej","et","er")
df_times15<-df_times15[-1,]

nrow_org <- nrow(df_org)
#nrow_org <- 500
before_status_start <- posixct
for(i in 1:nrow_org){
  # 空き状況：ej
  # 開始時間
  thing_id <- df_org[i,"thing_id"]
  org_status_start <- as.POSIXlt(df_org[i,"status_start"])
  org_status_end <- as.POSIXlt(df_org[i,"status_end"])
  status_start <- org_status_start
  status_end <- org_status_start
  if(org_status_start$min < 60 && org_status_start$min >= 45){
    status_start$min=45
    status_start$sec=00
    status_end$min=59 # すみません。本来は+1時間です。まあ、誤差の範囲で^^
    status_end$sec=59
  }
  if(org_status_start$min < 45 && org_status_start$min >= 30){
    status_start$min=30
    status_start$sec=00
    status_end$min=45
    status_end$sec=00
  }
  if(org_status_start$min < 30 && org_status_start$min >= 15){
    status_start$min=15
    status_start$sec=00
    status_end$min=30
    status_end$sec=00
  }
  if(org_status_start$min < 15 && org_status_start$min >= 00){
    status_start$min=00
    status_start$sec=00
    status_end$min=15
    status_end$sec=00
  }
  #空き状況:ej →未使用状況と比較後に作成
  #空き率:er →最後に作成
  
  #空き時間:et
  ## 前レコードが同一テーブルでない場合
  if(before_status_start != status_start || before_thing_id != thing_id){
    #et <- as.difftime(900,units ="secs") #MAX15分
  }
  
  # 時間枠での使用時間算出
  if(org_status_end < status_end){
    st15 <- org_status_end-org_status_start
    et <- as.numeric(st15,units="secs")
    #書き込み
    df_times15 <- rbind(df_times15,data.frame("thing_id"=thing_id,"datetime"=status_start,"ej"="X","et"=et,"er"=0))
  }else{
    st15 <- status_end-org_status_start
    et <- as.numeric(st15,units ="secs")
    #書き込み
    df_times15 <- rbind(df_times15,data.frame("thing_id"=thing_id,"datetime"=status_start,"ej"="X","et"=et,"er"=0))

    while(org_status_end > status_end){
      status_start <- status_start + 900
      status_end <- status_end + 900
      if(org_status_end > status_end){
        et <- as.difftime(900,units ="secs") #15分
      }else{
        st15 <- org_status_end-status_start
        et <- as.numeric(st15,units ="secs")
      }
      df_times15 <- rbind(df_times15,data.frame("thing_id"=thing_id,"datetime"=status_start,"ej"="X","et"=et,"er"=0))
    }
  }
  
  #前レコード保持
  before_status_start <- status_start 
  before_thing_id <- thing_id
}
#同一時間帯に２回以上使ったデータのサマリ
df_times15 <-
df_times15 %>%
  dplyr::group_by(thing_id,datetime) %>%
  dplyr::summarise(ej="X",et = sum(et),er=0)

df_times15$et <- 900-df_times15$et

write.csv(df_times15, "things_times15.csv", quote=F,row.names=F)



  




