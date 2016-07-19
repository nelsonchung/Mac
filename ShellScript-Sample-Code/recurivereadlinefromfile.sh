#!/bin/sh

## 遞迴式從data.txt檔案中讀取內容並將結果echo出來

while read line; do 
    echo "$line"
done < "data.txt"
