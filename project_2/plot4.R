#set working directory
setwd("~/Personal/ExData_Plotting1/project_2")
#load the data
NEI <- readRDS("in_data/summarySCC_PM25.rds")
SCC <- readRDS("in_data/Source_Classification_Code.rds")
NEI$year <- as.character(NEI$year)
library(stats)
#check what lines are "coal"
subcoal <- grepl("coal", SCC$EI.Sector, ignore.case=TRUE)
#extract coal from SCC
subcoalSCC <- SCC[subcoal,]
#merge coal to NEI
subcoalNEI <- merge(NEI, subcoalSCC, by="SCC")
#get emissions by Coal
coalAgg <- aggregate(subcoalNEI$Emissions ~ subcoalNEI$year, FUN = sum)
#save it as a df
coalAgg <- as.data.frame(coalAgg)
#rename columns
names(coalAgg)[names(coalAgg) == "subcoalNEI$year"] <- "year"
names(coalAgg)[names(coalAgg) == "subcoalNEI$Emissions"] <- "emissions"
#plot
library(ggplot2)
ggplot(coalAgg, aes(y= emissions, x = year)) + 
  geom_col(fill = "darkgreen") +
  ggtitle("Coal-related Emissions") +
  theme_bw()
#save it
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()