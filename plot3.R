library(data.table)
pclasses <- c("character", "character", rep("numeric", 7))
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?" , 
                    colClasses = pclasses)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# date Range
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

dev.off()
defaultpar <- par(no.readonly = TRUE)
# subset the data
febdata <- subset(power, (power$Date == date1 | power$Date == date2))
# combine date and time columns and convert to posixcT format
datetime <- paste(febdata$Date,febdata$Time)
febdata$datetime <- as.POSIXct(datetime)

# plot
plot(febdata$datetime, febdata$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "l")
lines(febdata$datetime, febdata$Sub_metering_2, col = "red")
lines(febdata$datetime, febdata$Sub_metering_3, col = "blue")

# add legend
legend("topright" , legend = c("Sub_metering_1                         ", 
                               "Sub_metering_2                         ", 
                               "Sub_metering_3                         "), 
       col = c("Black", "Red", "Blue"), lty = 1, lwd = 2, cex = 0.7, y.intersp = 1, xjust=1)

# copy plot
dev.copy(png, file = "./plot3.png", width = 480, height = 480, units = "px")

# close device to get file

dev.off()
par(defaultpar)