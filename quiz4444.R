
set.seed(123)
t.test(x = rnorm(300), mu = 0)
mean(rnorm(300))

bike = read.csv("bike.csv", stringsAsFactors = FALSE)
bike = bike[, -c(1, 11, 12)]

train = bike[1:4000,]
test = bike[4001:nrow(bike), ]

model = lm(casual ~ ., data= train)
summary(model)
# 다음 문제를 풀어보세요.

#### 1. "bike.csv" 데이터를 read.csv() 함수로 불러와서 df 객체에 저장하시오.
(단, stringsAsFactors 인자의 값은 FALSE로 한다)
bike = read.csv("bike.csv", stringsAsFactors = FALSE)
df = bike
head(df)
#### 2. df 객체의 상위 3개 row를 출력하시오.
#1)
head(df,3)
#2)
df[1:3, ]
#### 3. df 객체의 row 개수를 확인하시오.
nrow(df)
#### 4. df 객체의 column 개수를 확인하시오.
ncol(df)


str(df)
dim(df)
#### 5. df 객체의 temp 변수의 평균 값을 반올림하여 소수점 첫 째 자리까지 기술하시오.
#             df$temp         mean      round      round(digit)
round(mean(df$temp), 1)
#### 6. df 객체의 holiday 변수가 1이면서, workingday 변수가 1인 경우가 존재하는지 확인하시오.
#1)
df[(df$holiday == 1) & (df$workingday == 1), ]  #6번의 조건에 해당하는게 하나도 없다는 의미
#2)
table(df$holiday, df$workingday)
#### 7. df 객체의 weather 변수에는 고유값(중복제거된값)이 몇 개 있는지 기술하시오.
length(unique(df$weather))
#### 8. df 객체의 상위 10개 row만 추출하여 df_sub 객체에 저장하시오
df_sub = df[1:10, ]
df_sub
#### 9. df_sub 객체를 "bike_sub.csv" 파일로 저장하시오.
write.csv(df_sub, "bike_sub.csv", row.names = FALSE)

#### 10. df 객체의 count 변수의 상위 1% 값 보다 큰 값을 이상치로 간주하고자 한다. 상위 1% 값을 구하시오.
quantile(df$count, probs = 0.99)

#### 11. df 객체의 짝수 번째 row만 추출하여 "bike_even.csv" 파일로 저장하시오
write.csv(df[seq(from = 2, to = nrow(df)),], "bike_even.csv", row.names = TRUE)


#1. "bike.csv" 데이터를 read.csv() 함수로 불러와서 df 객체에 저장하시오.
#(단, stringsAsFactors 인자의 값은 FALSE로 한다)
bike = read.csv("bike.csv", stringsAsFactors = FALSE)
#2. df 객체의 상위 6개 row를 출력하시오.
df[1:6, ]

#(lubridate 패키지의 함수를 활용하여 다음 문제를 풀이하는 것을 권장.)
library(lubridate)
#3. [datetime] 변수에서 연도를 추출하여 [year] 변수를 df 객체에 새로 생성하시오.
df[ , "year"] = year(df$datetime)
head(df)
#4. [datetime] 변수에서 월을 추출하여 [month] 변수를 df 객체에 새로 생성하시오.
df[ , "month"] = month(df$datetime)
#5. [datetime] 변수에서 시간을 추출하여 [hour] 변수를 df 객체에 새로 생성하시오.
df[ , "hour"] = hour(df$datetime)
#6. [datetime] 변수에서 일자를 추출하여 [date] 변수를 df 객체에 새로 생성하시오.
df[ , "date"] = date(df$datetime)
head(df, 2)
#7. [date] 변수에서 요일 정보를 추출하여 [wday] 변수를 df 객체에 새로 생성하시오.
df[ , "wday"] = wday(df$date, week_start = 1)
#8. [season] 변수와 [weather] 변수를 활용하여 그 조합의 빈도를 확인하시오
#(table() 함수 활용 권장)
table(bike$season, bike$weather)
tb = table(df[, c("season", "weather")])
round(prop.table(tb), 3)
round(prop.table(tb, margin = 1), 3)
prop.table(table(bike$season, bike$weather))
round(prop.table(table(bike$season, bike$weather)), 3)
#9. [temp] 변수와, [atemp] 변수의 상관계수를 확인하시오.
cor(bike$temp, bike$atemp)
#cor(df$temp, df$atemp)
library("ggplot2")
ggplot(data = df,
       aes(x = temp, y = atemp)) +
  geom_point(size = 3, alpha = 0.2)
#데이터 분석시 온도(기온)은 민감하게 잘 파악해야함.
#예를 들어 지금 느끼는 5도랑 한겨울에 느끼는 5도랑 체감기온이 다름.
#그래서 비교할 때 2주 전 평균온도에 비해 ~ 어떻다 고 표시해주는게 좋음.
#데이터 분석하고 모델을 만들때 나는 이럴때 어떤가 생각하고 만들자

#10. 시간[hour]별 [casual] 변수의 평균을 구하여 df_cnt_mean 객체에 저장하시오.
head(df,2)
df_cnt_mean = aggregate(data = df, casual ~ hour, FUN = "mean")
#요일별, 시간별, casual의 평균을 구하시오.
agg_test = aggregate(data = df, casual ~ wday + hour, FUN = "mean")
head(agg_test)
#평균의 영향을 받는 것은 물결 표시 앞쪽에 위치하자!
#11. 시간[hour]별 [registered] 변수의 평균을 구하여 df_reg_mean 객체에 저장하시오.
df_reg_mean = aggregate(data = df, registered ~ hour, FUN = "mean")
#12. 10번의 결과와 11번의 결과를 시각화 하시오.
head(df_cnt_mean)
head(df_reg_mean)

ggplot(data = df_cnt_mean, 
       aes(x = hour, 
           y = casual,
           fill = casual)) +
  geom_col() +
  theme_bw() +
  theme(legend.position = "none")

ggplot(data = df_reg_mean, 
       aes(x = hour, 
           y = registered,
           fill = registered)) +
  geom_col() +
  geom_point(data = df_reg_mean, aes(x = hour, y = registered),
             size = 5) +
  geom_line(data = df_reg_mean, aes(x = hour, y = registered),
            size = 1.2) +
  theme_bw() +
  theme(legend.position = "none")

