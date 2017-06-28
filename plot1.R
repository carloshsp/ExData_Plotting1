## Exploratory Data Analysis Project 1
## Plot 1

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
png(filename = "plot1.png")
hist(housedt$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylim = c(0,1200))
dev.off()
rm(housedt)
