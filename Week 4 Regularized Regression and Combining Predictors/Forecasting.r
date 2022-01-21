# Forecasting

install.packages("quantmod")

library(quantmod)

startDate = as.Date("2021-01-01")
endDate = as.Date("2022-01-20")
getSymbols("GOOG", src="yahoo", from=startDate, to = endDate, auto.assign = T)


head(GOOG)
tail(GOOG)

mGoog <- to.monthly(GOOG)
googOpen <- Op(mGoog)

tsl <- ts(googOpen, frequency = 12)
tsl

plot(tsl,
     xlab = "Years+1",
     ylab = "Goog",
     main = "Time series Google")

plot(decompose(tsl), xlab = "Years+1")

tsltrain <- window(tsl,start=1,end = 5)
teltest <- window(tsl,start=5,end = 7)
tsltrain

plot(tsltrain)
lines(ma(tsltrain,order=3),col = "red")

etsl <- etsl(tsltrain, model="MMM")
fcast <- forecast(etsl)
plot(fcast)
lines(tsltest, col = "red")

accuracy(fcast, tsltest)