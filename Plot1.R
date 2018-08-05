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

## Create and save the plot
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power")
dev.copy(png, file = "Plot1.png")
dev.off()