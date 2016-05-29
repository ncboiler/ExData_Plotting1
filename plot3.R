#load the lubridate library
library(lubridate)

## Read the data into R and save it as a data frame called meter
meter <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#convert time and date columns from factors to time and date values
meter$Date <- as.Date(meter$Date, format = "%d/%m/%Y")
meter$Time <- hms(meter$Time)

#subset the meter date frame to dates between 2007-02-01 and 2007-02-02 including those days
meter <- subset(meter, meter$Date >= "2007-02-01" & meter$Date <= "2007-02-02")

#Convert the meter values from character to number
meter$Sub_metering_1 <- as.numeric(meter$Sub_metering_1)
meter$Sub_metering_2 <- as.numeric(meter$Sub_metering_2)
meter$Sub_metering_3 <- as.numeric(meter$Sub_metering_3)

#turn the data into a time series
a  <- ts(meter$Sub_metering_1)
b  <- ts(meter$Sub_metering_2)
c  <- ts(meter$Sub_metering_3)

png(filename = "plot3.png", width = 480, height = 480 )

#plot the time series for sub_metering1 first
plot(a, xaxt = "n", ylab = "Energy sub metering", xlab = "")
axis(1, at= c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))

#plot the time series for Sub_metering_2 
lines(b, col = "red")

#plot the time series for Sub_metering_3
lines(c, col = "blue")

#create the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1) )

dev.off()
