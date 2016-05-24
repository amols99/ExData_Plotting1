library(data.table)
pclasses <- c("character", "character", rep("numeric", 7))
power <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE, na.strings = "?" , 
                                colClasses = pclasses)
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# date Range
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
# save default par values to reset at the end
dev.off()
defaultpar <- par(no.readonly = TRUE)

# subset the data
febdata <- subset(power, (power$Date == date1 | power$Date == date2))
# combine date and time columns and convert to posixcT format
datetime <- paste(febdata$Date,febdata$Time)
febdata$datetime <- as.POSIXct(datetime)
par.defaults <- par(no.readonly=TRUE);
# plot
plot(febdata$datetime, febdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

# copy plot
dev.copy(png, file = "./plot2.png", width = 480, height = 480, units = "px")

# close device to get file


dev.off()
par(defaultpar)