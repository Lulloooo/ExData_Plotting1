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
#plot 1
hist(as.numeric(hpcsub$Global_active_power), main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
#save it
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()