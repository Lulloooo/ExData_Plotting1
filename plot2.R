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
#plot2
plot(hpcsub$Global_active_power~ hpcsub$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="", xaxt = "n")
axTicks(1)
axis(1, at = c(1170284000, 1170371000, 1170458000), label = c("Thu", "Fri", "Sat"))
#save it
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()