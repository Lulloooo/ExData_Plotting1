#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
#filter for baltimore
balt <- NEI[NEI$fips == "24510",]
#have PM2.5 emission decreased?
library(stats)
baltAgg <- aggregate(balt$Emissions ~ balt$year, FUN = sum)
#rename
names(baltAgg)[names(baltAgg) == "balt$year"] <- "year"
names(baltAgg)[names(baltAgg) == "balt$Emissions"] <- "emissions"
#plot
barplot(baltAgg$emissions ~ baltAgg$year, xlab = "year", ylab = "Emissions", 
        main = "Total Emissions x year", col = "darkgreen")
#save it
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()