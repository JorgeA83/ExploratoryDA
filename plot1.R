##Read data from household_power_consumption.txt in C:\R\data
data <- read.table("./data/household_power_consumption.txt", header = TRUE, sep =";")

##Subset the Data to read only February 1st and 2nd of 2007
library(dplyr)
data2 <- filter(data, as.Date(data$Date, format = "%d/%m/%Y") >= "2007-02-01" & as.Date(data$Date, format = "%d/%m/%Y") <= "2007-02-02")


## Class convertion
## Convert Date from factor to Date
data2$Date <- as.Date(data2$Date, format = "%d/%m/%Y") 
## Create a field with Date and time
data2$Date_Time <- paste(data2$Date, data2$Time)
## Convert that field using strptime
data2$Date_Time <- strptime(data2$Date_Time, format="%Y-%m-%d %H:%M:%S")

#Convert to numeric the rest of the factor variables
data2$Global_active_power <- as.numeric(as.character(data2$Global_active_power))
data2$Global_reactive_power <- as.numeric(as.character(data2$Global_reactive_power))
data2$Voltage <- as.numeric(as.character(data2$Voltage))
data2$Global_intensity  <- as.numeric(as.character(data2$Global_intensity))
data2$Sub_metering_1 <- as.numeric(as.character(data2$Sub_metering_1))
data2$Sub_metering_2 <- as.numeric(as.character(data2$Sub_metering_2))

##Create the plot 
hist(data2$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

##Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off() ##Close the PNG Device