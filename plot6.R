
library(ggplot2)
library(RColorBrewer)

dir.create("./air_quality")
urlzip <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(urlzip, destfile = "./air_quality.zip")
unzip("./air_quality.zip", exdir = "./air_quality")


## This first line will likely take a few seconds. Be patient!
SCC_SUMMARY <- readRDS("air_quality/summarySCC_PM25.rds")
SCC <- readRDS("air_quality/Source_Classification_Code.rds")

# Opening both files
str(SCC_SUMMARY)
str(SCC)



## 6 Compare emissions from motor vehicle sources in Baltimore City with emissions
## from motor vehicle sources in Los Angeles County, California
## (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

SCC <- readRDS("air_quality/Source_Classification_Code.rds")
SCC_SUMMARY <- readRDS("air_quality/summarySCC_PM25.rds")



BaltLA <- subset(SCC_SUMMARY, SCC_SUMMARY$fips %in% c("24510","06037") & SCC_SUMMARY$type == "ON-ROAD")
BaltLA_aggregate <- aggregate(Emissions ~ year + fips, BaltLA, sum)

## Write the plot to png file
png(filename="plot6.png", width=480, height = 480)

ggplot(BaltLA_aggregate, aes(year, Emissions, col = fips)) +
  geom_line() +
  geom_point() +
  ggtitle("Baltimore and Los Angeles Vehicle Emissions by Year") +
  labs(x = "Year", y = "Motor Vehicle Emissions")  +
  scale_color_manual(values = c("red", "blue"), name="City",labels = c("Los Angeles", "Baltimore"))
  dev.off()

