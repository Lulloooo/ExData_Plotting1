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
#plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
plot(hpcsub$Global_active_power~hpcsub$Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axTicks(1)
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
plot(hpcsub$Voltage~hpcsub$Datetime, type="l", 
       ylab="Voltage (volt)", xlab="datetime", xaxt="n")
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
plot(hpcsub$Sub_metering_1~hpcsub$Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  lines(hpcsub$Sub_metering_2~hpcsub$Datetime,col='Red')
  lines(hpcsub$Sub_metering_3~hpcsub$Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
plot(hpcsub$Global_reactive_power~hpcsub$Datetime, type="l", 
       ylab="Global_reactive_power",xlab="datetime", xaxt="n")
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
#save it
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()