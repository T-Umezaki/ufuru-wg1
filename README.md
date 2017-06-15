# ufuru-wg1

トイレの開閉データから利用状況を算出し、機械学習の教師データとするスクリプトです。

機械学習教師データ作成手順

入力データ：
※気象データを除き、データはここにはありません。ご利用の際、元データはboxなどから取得お願いいたします。

・toilet_duraion_20170531-sjis.csv　：
　トイレの入退出時間、滞在時間　４F：２室　　１４F：３室　　１５F：３室

・weather_data1.csv
　気象庁一日単位での最低、最高気温

・wificategoryforArea.csv
　およそ１０秒毎フロア内WiFi接続状況　１０Fのみ
 
 実行順序
 
・個室毎１５分毎の空き状況・時間・率データを作成
　make_toilet_use_data.R
・階毎に集約
　make_toilet_floordata.R
・時間ごとに集約
　make_toilet_empty_sum.R
・天気、気温データ結合
　connect_wether.R
・フロア人数データ集計
　make floor_data.R
・フロア人数データデータ結合
　connect_floor.R
 
 最終アウトプット：
 　toilet_duraion_for_ml.csv
  　　→これを突っ込めば機械学習ができる！！　イメージです。
    
よい機械学習をよろしくお願いします。


