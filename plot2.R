#load the lubridate library
library(lubridate)

## Read the data into R and save it as a data frame called meter
meter <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#convert time and date columns from factors to time and date values
meter$Date <- as.Date(meter$Date, format = "%d/%m/%Y")
meter$Time <- hms(meter$Time)

#subset the meter date frame to dates between 2007-02-01 and 2007-02-02 including those days
meter <- subset(meter, meter$Date >= "2007-02-01" & meter$Date <= "2007-02-02")

#convert the Global _active_power column from a character to a number
meter$Global_active_power <- as.numeric(meter$Global_active_power)

#turn the Global_active_power into a time series vector
z <- ts(meter$Global_active_power)

#plot the graph without the x-axis tick marks
plot(z, xaxt = "n", ylab = "Global Active Power (kilowatts)", xlab = "")
axis(1, at= c(0, 1500, 2900), labels = c("Thursday", "Friday", "Saturday"))
