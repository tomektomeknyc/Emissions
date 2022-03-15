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

## 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

SCC <- readRDS("air_quality/Source_Classification_Code.rds")
SCC_SUMMARY <- readRDS("air_quality/summarySCC_PM25.rds")



baltimoreEmm <- subset(SCC_SUMMARY, SCC_SUMMARY$fips == "24510" & SCC_SUMMARY$type == "ON-ROAD")
baltimoreAggr <- aggregate(Emissions ~ year, baltimoreEmm, sum)

## Write the plot to png file
png(filename="plot5.png", width=480, height = 480)

ggplot(baltimoreAggr, aes(year, Emissions)) +
  geom_line(col = "brown") +
  geom_point(col = "brown") +
  ggtitle("Baltimore PM2.5 Motor Vehicle Emissions by Year") +
  xlab("Year") +
  ylab("Motor Vehicle Emissions")
  dev.off()
