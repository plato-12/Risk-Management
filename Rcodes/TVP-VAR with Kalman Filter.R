# Install and load the necessary packages
install.packages(c("readxl", "writexl", "KFAS", "xts"))
library(readxl)
library(writexl)
library(KFAS)
library(xts)

# Load the data from the Excel file
data <- read_excel("K:/Commodity Project/Risk-Management/Datasets/TVP-VAR/Returns of six indices.xlsx")

# Convert to datetime object
data$Date <- as.POSIXct(data$Date, format = "%Y-%m-%d %H:%M:%S")

# Drop the time part and convert to date object
data$Date <- as.Date(data$Date)

# Set Date as row names
row.names(data) <- data$Date

dates <- data$Date
data$Date <- NULL
library(xts)
data_xts <- xts(data, order.by = dates)

# Number of time series
p <- ncol(data_xts)

# Create the model
model <- SSModel(data_xts ~ SSMtrend(1, Q = diag(p)) +
                   SSMseasonal(12, Q = diag(p)),
                 H = diag(p))

# Fit the model
fit <- fitSSM(model, inits = rep(0, p * 2 + 1))  # inits length should match the number of parameters


# Apply the Kalman filter
kf <- KFS(fit$model)

# Print the result
print(fit)

# Create a list of data frames
fit_list <- list(
  Parameters = data.frame(Parameter = names(fit$coef), Estimate = fit$coef),
  VarCovMatrix = as.data.frame(fit$V)
)

# Write the result to an Excel file
write_xlsx(fit_list, "K:/Commodity Project/Risk-Management/Datasets/TVP-VAR/Result.xlsx")
# Print the fit object
print(fit)

# Print the summary of the fit object
summary(fit)

# Run the Kalman filter and smoother on the fitted model
KFS_result <- KFS(fit$model)

# The smoothed state estimates are in the `alphahat` element
smoothed_states <- KFS_result$alphahat

# Create a data frame from the smoothed state estimates and write to an Excel file
smoothed_states_df <- data.frame(smoothed_states)
write_xlsx(smoothed_states_df, "K:/Commodity Project/Risk-Management/Datasets/TVP-VAR/Result.xlsx")

