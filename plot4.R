## Exploratory Data Analysis Project 1
## Plot 4

## require libraries
require(data.table)
require(tidyverse)
require(lubridate)

## read and filter relevant data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, temp)
household <- fread(unzip(temp, "household_power_consumption.txt"), 
                        nrows = 70000, na.strings = "?")[66637:69516]
unlink(temp)
rm(temp, url)
housedt <- household %>% 
        unite(dt, Date, Time) %>%
        mutate(dt = dmy_hms(dt))
        
rm(household)

## generate plot and png file
png(filename = "plot4.png")
par(mfrow = c(2,2))
with(housedt, plot(dt, Global_active_power, type = "l", 
                   xlab = "", ylab = "Global Active Power"))
with(housedt, plot(dt, Voltage, type = "l", 
                   xlab = "datetime", ylab = "Voltage"))
with(housedt, plot(dt, Sub_metering_1, type = "l", 
                   xlab = "", ylab = "Energy sub metering"))
with(housedt, lines(dt, Sub_metering_2, col = "red"))
with(housedt, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = 1, col = c("black", "red", "blue"), box.lwd = 0)
with(housedt, plot(dt, Global_reactive_power, type = "l", 
                   xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()
rm(housedt)
