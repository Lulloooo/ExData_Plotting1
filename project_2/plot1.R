#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
#have PM2.5 emission decreased?
library(stats)
MP2agg <- aggregate(NEI$Emissions ~ NEI$year, FUN = sum)
#rename
names(MP2agg)[names(MP2agg) == "NEI$year"] <- "year"
names(MP2agg)[names(MP2agg) == "NEI$Emissions"] <- "emissions"
#plot
barplot(MP2agg$emissions ~ MP2agg$year, xlab = "year", ylab = "Emissions", 
        main = "Total Emissions x year", col = "darkgreen")
#save it
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()