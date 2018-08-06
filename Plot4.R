## plot1.R
##
## James Francisco PhD
## Written for Johns Hopkins Data Science MOOC - Exploratory Data analysis
## Course delivered by Coursera
##
## Define the path and file names for data download

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- file.path(getwd(), "household_power_consumption.zip")

## download and unzip the data 

download.file(url, zipfile)
unzip("household_power_consumption.zip")

## Extract the data to be analyzed
data <- read.table(text = grep("^[1,2]/2/2007",readLines("household_power_consumption.txt"),value=TRUE), sep = ';', col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), na.strings = '?')
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$datetime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

## Create and save the plot
data$datetime <- as.POSIXct(data$datetime)
attach(data)
opt = par(mfrow = c(2,2))
plot(Global_active_power ~ datetime, type = "l",
     +      ylab = "Global Active Power (kilowatts)", xlab = "")
plot(Voltage ~ datetime, type = "l", ylab = "Voltage", xlab = "datetime")
plot(Sub_metering_1 ~ datetime, type = "l", ylab = "Energy Submetering", xlab = "")
lines(Sub_metering_2 ~ datetime, col = "red")
lines(Sub_metering_3 ~ datetime, col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       +        legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(Global_reactive_power ~ datetime, type = "l", ylab = "Global reactive power", xlab = "datetime")
dev.copy(png, file = "Plot4.png", height = 480, width = 480)
dev.off()
detach(data)