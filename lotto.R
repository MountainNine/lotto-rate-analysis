#import

library(httr)
library(jsonlite)
library(dplyr)
library(data.table)

######### 크롤링 및 CSV에 저장

#basic_url <- 'https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo='
#df_lotto_num <- NULL
#for (x in 1:944) {
#  req_url <- paste0(basic_url, x)
#  df_response <- as.data.frame(fromJSON(req_url))
#  df_sub <- subset(df_response, select = c("drwNo", "drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6", "bnusNo"))
#  if(x == 1) {
#    df_lotto_num <- df_sub
#  } else {
#      df_lotto_num <- rbind(df_lotto_num, df_sub)
#  }
#  print(paste(x , "crawled."))
#}
#write.csv(df_lotto_num, "./lotto.csv")

######### 데이터프레임 가공

df_lotto_num <- read.csv("./lotto.csv")
df_lotto <- subset(df_lotto_num, select = c("drwtNo1", "drwtNo2", "drwtNo3", "drwtNo4", "drwtNo5", "drwtNo6")) #보너스 번호는 제외
df_count <- apply(df_lotto, 2, table)
df_sum <- NULL
for(item in df_count) {
  if(is.null(df_sum)) {
    df_sum <- as.data.frame(df_count$drwtNo1)
  } else {
    df_item <- as.data.frame(item)
    df_sum <- rbindlist(list(df_sum, df_item))[,lapply(.SD, sum, na.rm=TRUE), by = Var1]
  }
}

######### 시각화 및 검정

barplot(height = df_sum$Freq, width = df_sum$Var1, col = "blue", border = "white")
chisq.test(df_sum$Freq)

# X-squared = 32.552, df = 44, p-value = 0.8985
# 카이제곱 값은 32.552이고, 유의확률은 0.8985이므로, 95%의 신뢰수준(유의수준 0.05)에서 귀무가설을 채택한다.
# 다시 말해, 로또의 확률은 균일하다고 볼 수 있다.