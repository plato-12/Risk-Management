install.packages("readxl")
install.packages("openxlsx")

library(readxl)
library(openxlsx)
# Replace 'path_to_excel_file' with the actual path to your Excel file.
data_index1 <- read_excel("K:/Commodity Project/DynamicSpillover/Dataset/Commodity and US-EPU/BO1 Comdty (Crude Soybean) and EPU.xlsx", sheet = "Index1")
data_index2 <- read_excel("K:/Commodity Project/DynamicSpillover/Dataset/Commodity and US-EPU/BO1 Comdty (Crude Soybean) and EPU.xlsx", sheet = "Index2")

# Filter out missing dates from Index1 data
data_index1 <- data_index1[complete.cases(data_index1), ]
merged_data <- merge(data_index1, data_index2, by.x = "Date", by.y = "Date", all.x = TRUE)
# Replace 'output_file.xlsx' with the desired name for the output Excel file.
write.xlsx(merged_data, "CleanedEPU.xlsx", rowNames = FALSE)

# Install and load necessary packages if you haven't done it before
install.packages("readxl")
install.packages("openxlsx")

library(readxl)
library(openxlsx)

# Step 1: Read the EPU index data from the Excel file.
# Replace 'path_to_epu_data.xlsx' with the actual path to your Excel file.
epu_data <- read_excel("K:/Commodity Project/DynamicSpillover/Dataset/CleanedEPU.xlsx")

# Step 2: Convert the 'Date' column to a proper date format.
epu_data$Date <- as.Date(epu_data$Date, format = "%m-%d-%Y")

# Step 3: Calculate the logarithmic levels using the log() function.
epu_data$log_epu <- log(epu_data$LastPrice)

# Step 4: Create a new data frame with the original dates and the logarithmic levels.
log_epu_data <- data.frame(Date = epu_data$Date, Log_EPU = epu_data$log_epu)

# Step 5: Write the new data frame with logarithmic levels to a new Excel file.
# Replace 'output_file.xlsx' with the desired name for the output Excel file.
write.xlsx(log_epu_data, "log_EPU.xlsx", rowNames = FALSE)

