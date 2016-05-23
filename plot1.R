library(data.table)
pclasses <- c("character", "character", rep("numeric", 7))
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?" , 
                                colClasses = pclasses)
power$Date <- as.Date(power$Date, "%d/%m/%Y")
#power$Time <- strptime(power$Time, format = "%H:%M:%S")

# date Range
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

# subset the data
febdata <- subset(power, (power$Date == date1 | power$Date == date2))

par.defaults <- par(no.readonly=TRUE);
# construct plot
hist(febdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts", main="Global Active Power")
# copy to png file

dev.copy(png, file = "./plot1.png", width = 480, height = 480, units = "px")
# close device to get file
dev.off()
