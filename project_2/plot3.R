#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
#filter for baltimore
balt <- NEI[NEI$fips == "24510",]
#load ggplot2 package
library(ggplot2)
#get total sum of emissions for Baltimore by year
baltTypeAgg <- aggregate(Emissions ~ year + type, balt, sum)
#plot
ggplot(baltTypeAgg, aes(x=year, y=Emissions, color=type, group = type))+ 
  geom_point() +
  geom_line() + 
  xlab("Year") + 
  ylab("Total PM2.5 Emissions (tons)") + 
  ggtitle("Total PM2.5 Emissions in Baltimore by Year and Type") +
  scale_color_manual(values=c("darkgreen", "darkred", "darkblue", "purple")) +
  theme_bw()
#save the plot
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

