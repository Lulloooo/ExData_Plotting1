#set working directory
setwd("~/Personal/ExData_Plotting1")
#read the file
hpc <- read.delim("hpc.txt", dec = ".", sep = ";")
#set the date as date
hpc$Date <- as.Date(hpc$Date, format="%d/%m/%Y")
#subset the data
hpcsub <- subset(hpc, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#remove hpc
rm(hpc)
#convert date
datetime <- paste(as.Date(hpcsub$Date), hpcsub$Time)
hpcsub$Datetime <- as.POSIXct(datetime)
#plot 3
plot(hpcsub$Sub_metering_1~hpcsub$Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="", xaxt = "n")
  lines(hpcsub$Sub_metering_2~hpcsub$Datetime,col='Red')
  lines(hpcsub$Sub_metering_3~hpcsub$Datetime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axTicks(1)
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
#save it
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()