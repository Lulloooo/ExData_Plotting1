#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
#subset for vehicle
a <- grepl("Vehicle", SCC$EI.Sector, ignore.case=TRUE)
#extract vehicle from SCC
b <- SCC[a, ]
#add it to NEI
c <- merge(NEI, b, by="SCC")
#filter for baltimore
d <- c[c$fips == "24510",]
#get emissions by vehicle
library(stats)
VechBaltAgg <- aggregate(d$Emissions ~ d$year, FUN = sum)
#rename variables
names(VechBaltAgg)[names(VechBaltAgg) == "d$year"] <- "year"
names(VechBaltAgg)[names(VechBaltAgg) == "d$Emissions"] <- "emissions"
#plot 5
library(ggplot2)
ggplot(VechBaltAgg, aes(x=year, y=emissions, group = 1)) + 
  geom_point(color = "darkgreen") +
  geom_line(color = "darkgreen") + 
  xlab("Year") + 
  ylab("Vehicles' Total PM2.5 Emissions (tons)") + 
  ggtitle("Total PM2.5 Emissions from Vehicles in Baltimore") +
  theme_bw()
#saving
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()