library(strucchange)
library(readxl)
data <- read_excel("K:/Commodity Project/Week 9/USD Index(2013-2023).xlsx")
data$Date <- as.Date(data$Date)
ts_data <- ts(data$LastPrice)
bp_test <- breakpoints(ts_data ~ 1)
print(bp_test)
library(ggplot2)
# Define your breakpoints
breakpoints <- c(510, 1069, 1469, 1869, 2269)
# Plot the time series with the structural breakpoints
ggplot(data, aes(x = Date, y = LastPrice)) +
  geom_line() +
  geom_vline(xintercept = as.numeric(data$Date[breakpoints]), linetype = "dashed", color = "red") +
  labs(x = "Date", y = "Last Price", title = "Time Series with Structural Breakpoints") +
  theme_minimal()
