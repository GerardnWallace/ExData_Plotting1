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

#Set device parameters
par(mfcol = c(2, 2), mar = c(3,5,2,1))

#Plot 
with(power_data, {
  
  #Upper left panel
  plot(Global_active_power ~ ymd_hms(paste(Date, Time)),
       type = "l",
       xlab = "",
       ylab = "Global Avtive Power (kilowatts)")
  
  #Lower left panel
  plot(Sub_metering_1 ~ ymd_hms(paste(Date, Time)),
       type = "l",
       xlab = "",
       ylab = "Energy Submetering")
  lines(Sub_metering_2 ~ ymd_hms(paste(Date, Time)), col = "red")
  lines(Sub_metering_3 ~ ymd_hms(paste(Date, Time)), col = "blue")
  legend("topright",
         lty = 1,
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  #Upper right panel
  plot(Voltage ~ ymd_hms(paste(Date, Time)),
       type = "l",
       xlab = "")
  
  #Lower right panel
  plot(Global_reactive_power ~ ymd_hms(paste(Date, Time)),
       type = "l",
       xlab = "")
})

#Save to .png
dev.copy(png, file = "ExData_Plotting1/plot4.png")
dev.off()
