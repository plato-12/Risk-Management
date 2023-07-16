# Install and load necessary packages
install.packages(c("readxl", "dplyr"))
library(readxl)
library(dplyr)

# Read the data
data <- read_excel("K:/Commodity Project/Risk-Management/BO1 Comdty (Crude Soybean).xlsx")

# Ensure that Date is as a Date, not a character string
data$Date <- as.Date(data$Date)

# Install and load necessary packages
install.packages("dplyr")
library(dplyr)

# Filter data for the given date range
data <- data %>% filter(Date >= as.Date("2013-01-04") & Date <= as.Date("2023-06-16"))

# Arrange data in descending order to calculate log returns correctly
data <- data %>% arrange(desc(Date))

# Calculate the log returns
data <- data %>% mutate(LogReturns = c(NA, diff(log(`BO1Comdty`))))

# View the data with the log returns
print(data)
print(data, n = Inf)
getwd()
# Install and load the necessary package
install.packages("writexl")
library(writexl)

# Write the data frame to an Excel file
write_xlsx(data, "K:/Commodity Project/DynamicSpillover/B01Comdty_Returns.xlsx")

