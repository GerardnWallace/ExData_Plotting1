library(data.table)
library(dplyr)
library(dtplyr)
library(lubridate)

#Load Data
data.dir <- paste0("C:/Users/Gerard/Documents//School/Coursera Data Science/",
                   "Exploratory Data Analysis/Exploratory-Data-Analysis-",
                   "Project/household_power_consumption.txt")
power_data <- read_delim(data.dir, 
                         ";", escape_double = FALSE, 
                         col_types = cols(Time = col_character()), 
                         trim_ws = TRUE)

#Convert to data.table
power_data <- tbl_dt(data.table(power_data))

#Convert data and time strings
power_data <- mutate(power_data, Date =dmy(Date))

#Filter 2007-02-01 to 2007-01-02
power_data <- filter(power_data, Date == "2007-02-01" | Date == "2007-02-02")

#Plot 
with(power_data, 
     plot(Global_active_power ~ ymd_hms(paste(Date, Time)),
          type = "l",
          xlab = "",
          ylab = "Global Avtive Power (kilowatts)"))

#Save to .png
dev.copy(png, file = "ExData_Plotting1/plot2.png")
dev.off()
