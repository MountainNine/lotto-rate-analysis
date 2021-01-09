library(httr)
library(jsonlite)

basic_url <- 'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo='
df_lotto_num <- NULL
for (x in 1:944) {
  req_url <- paste0(basic_url, x)
  df_response <- as.data.frame(fromJSON(req_url))
  df_sub <- subset(df_response, select = c("drwNo", "drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"))
  rbind(df_lotto_num, df_sub)
  print(paste(x , "crawled."))
}
write.csv(df_lotto_num, "./lotto.csv")
