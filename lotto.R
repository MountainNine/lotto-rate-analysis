#import

library(httr)
library(jsonlite)
library(dplyr)
library(plyr)

#crawling and write to csv file

basic_url <- 'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo='
df_lotto_num <- NULL
for (x in 1:944) {
  req_url <- paste0(basic_url, x)
  df_response <- as.data.frame(fromJSON(req_url))
  df_sub <- subset(df_response, select = c("drwNo", "drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"))
  if(x == 1) {
    df_lotto_num <- df_sub
  } else {
      df_lotto_num <- rbind(df_lotto_num, df_sub)
  }
  print(paste(x , "crawled."))
}
write.csv(df_lotto_num, "./lotto.csv")

# manipulate dataframe

df_lotto_num <- read.csv("./lotto.csv")
df_lotto <- subset(df_lotto_num, select = c("drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"))
columns <- colnames(df_lotto)
df_count <- apply(df_lotto, 2, table)
df_sum <- NULL
for(item in df_count) {
  if(is.null(df_sum)) {
    df_sum <- as.data.frame(df_count$drwtNo1)
  } else {
    df_sum <- merge(by=var1)
  }
}