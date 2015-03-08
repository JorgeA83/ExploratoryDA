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
##Set the margings and the mfrow to have 2 plots in each row
par(mfrow = c(2, 2), mar = c(14, 6, 2, 2), cex=.5)

#Plot 1 the same as plot2.R just a little change in the label
plot(data2$Date_Time, data2$Global_active_power, type = "l", xlab="", ylab= "Global Active Power")
#New Plot just using Voltage instead of Global Active Power and changing the labels of the axis
plot(data2$Date_Time, data2$Voltage, type = "l", xlab="datetime", ylab= "Voltage")
#Plot 3 same as plot3.R
plot(data2$Date_Time, data2$Sub_metering_1, type = "n", xlab="", ylab= "Energy sub metering")
lines(data2$Date_Time, data2$Sub_metering_1, type = "l", col = "black")
lines(data2$Date_Time, data2$Sub_metering_2, type = "l", col = "red")
lines(data2$Date_Time, data2$Sub_metering_3, type = "l", col = "blue")
legend("topright",  lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), legend = c("1", "2", "3"))
#Plot 4 same as Plot 2 but using Global Reactive Power instead of Voltage and changing the labels of the axis
plot(data2$Date_Time, data2$Global_reactive_power, type = "l", xlab="datetime", ylab= "Global_reactive_power")



##Save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off() ##Close the PNG Device
