#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
#subset for vehicle
vech <- grepl("Vehicle", SCC$EI.Sector, ignore.case=TRUE)
#extract vehicle from SCC
vechS <- SCC[a, ]
#add it to NEI
vechN <- merge(NEI, b, by="SCC")
#filter for baltimore
vBalt <- vechN[vechN$fips == "24510",]
#filter for Los Angeles
vLos <- vechN[vechN$fips == "06037",]
#get emissions by vehicle for both cities
library(stats)
VechBaltAgg <- aggregate(vBalt$Emissions ~ vBalt$year, FUN = sum)
VechLosAgg <- aggregate(vLos$Emissions ~ vLos$year, FUN = sum)
#rename variables
names(VechBaltAgg)[names(VechBaltAgg) == "vBalt$year"] <- "year"
names(VechBaltAgg)[names(VechBaltAgg) == "vBalt$Emissions"] <- "Baltemissions"
names(VechLosAgg)[names(VechLosAgg) == "vLos$year"] <- "year"
names(VechLosAgg)[names(VechLosAgg) == "vLos$Emissions"] <- "Losemissions"
#merge the df
LosBal <- merge(VechBaltAgg, VechLosAgg, by = "year")
#plot 5
library(ggplot2)
ggplot(LosBal) + 
  geom_point(aes(x=year, y=Baltemissions, group = 1), color = "darkgreen") +
  geom_point(aes(x=year, y=Losemissions, group = 1), color = "blue") +
  geom_line(aes(x=year, y=Baltemissions, group = 1, color = "BaltEmissions")) + 
  geom_line(aes(x=year, y=Losemissions, group = 1, color = "LosEmissions")) +
  xlab("Year") + 
  ylab("Vehicles' Total PM2.5 Emissions (tons)") + 
  ggtitle("Total PM2.5 Emissions: Baltimore vs Los Angeles") +
  scale_color_manual(values = c("darkgreen", "blue")) +
  theme_bw()
#saving
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()