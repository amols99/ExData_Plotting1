library(data.table)
pclasses <- c("character", "character", rep("numeric", 7))
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?" , 
                                colClasses = pclasses)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# date Range
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

# subset the data
febdata <- subset(power, (power$Date == date1 | power$Date == date2))
# combine date and time columns and convert to posixcT format
datetime <- paste(febdata$Date,febdata$Time)
febdata$datetime <- as.POSIXct(datetime)
par.defaults <- par(no.readonly=TRUE);
par(mfrow=c(2,2), mar=c(5,5,2,2), oma=c(0,0,0,0), cex = 0.5)

# plot 1

plot(febdata$datetime, febdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#plot 2

plot(febdata$datetime, febdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")

# plot 3

plot(febdata$datetime, febdata$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(febdata$datetime, febdata$Sub_metering_2, col = "red")
lines(febdata$datetime, febdata$Sub_metering_3, col = "blue")

# add legend
legend("topright" , legend = c("Sub_metering_1                         ", 
                               "Sub_metering_2                         ", 
                               "Sub_metering_3                         "), 
                                col = c("Black", "Red", "Blue"), lty = 1, lwd = 1, cex = 0.7, y.intersp = 3, xjust=1)


# last and 4th plot

plot(febdata$datetime, febdata$Global_reactive_power, ylab = "Global_reactive_power" , xlab = "datetime" , type = "l")
# copy plot
dev.copy(png, file = "./plot4.png", width = 480, height = 480, units = "px")

# close device to get file
dev.off()
