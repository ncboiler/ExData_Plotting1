#load the lubridate library
library(lubridate)

## Read the data into R and save it as a data frame called meter
meter <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#convert time and date columns from factors to time and date values
meter$Date <- as.Date(meter$Date, format = "%d/%m/%Y")
meter$Time <- hms(meter$Time)

#subset the meter date frame to dates between 2007-02-01 and 2007-02-02 including those days
meter <- subset(meter, meter$Date >= "2007-02-01" & meter$Date <= "2007-02-02")

png(filename = "plot4.png", width = 480, height = 480)

#set up the plot area for 2 rows and 2 columns
par(mfrow = c(2,2))

#add the global active power graph to the top left
#convert the Global _active_power column from a character to a number
meter$Global_active_power <- as.numeric(meter$Global_active_power)


###plot the time series of Global_active_power###

#convert the Global _active_power column from a character to a number
meter$Global_active_power <- as.numeric(meter$Global_active_power)
#turn the Global_active_power into a time series vector
z <- ts(meter$Global_active_power)
#plot the graph without the x-axis tick marks
plot(z, xaxt = "n", ylab = "Global Active Power", xlab = "")
axis(1, at= c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))

###Plot the time series for voltage
meter$Voltage <- as.numeric(meter$Voltage)
volt <- ts(meter$Voltage)
plot(volt, xaxt = "n", ylab = "Voltage", xlab = "datetime")
axis(1, at= c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))

### add the energy sub metering graph####

#Convert the meter values from character to number
meter$Sub_metering_1 <- as.numeric(meter$Sub_metering_1)
meter$Sub_metering_2 <- as.numeric(meter$Sub_metering_2)
meter$Sub_metering_3 <- as.numeric(meter$Sub_metering_3)

#turn the data into a time series
a  <- ts(meter$Sub_metering_1)
b  <- ts(meter$Sub_metering_2)
c  <- ts(meter$Sub_metering_3)

plot(a, xaxt = "n", ylab = "Energy sub metering", xlab = "")
axis(1, at= c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))

#plot the time series for Sub_metering_2 
lines(b, col = "red")

#plot the time series for Sub_metering_3
lines(c, col = "blue")

#create the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = c(1,1,1), cex = 0.75, bty = "n" )

### add the global reactive power graph to the plot
#convert the Global _reactive_power column from a character to a number
meter$Global_reactive_power <- as.numeric(meter$Global_reactive_power)
#turn the Global_active_power into a time series vector
x <- ts(meter$Global_reactive_power)
#plot the graph without the x-axis tick marks
plot(x, xaxt = "n", yaxt = "n",  ylab = "Global_reactive_power", xlab = "datetime")
axis(1, at= c(0, 1500, 2900), labels = c("Thu", "Fri", "Sat"))
axis(2, at = c(0.0, 0.1, 0.2,0.3,0.4,0.5), labels = c(0.0, 0.1,0.2,0.3,0.4,0.5))

dev.off()