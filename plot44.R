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

## 4 Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

SCC <- readRDS("air_quality/Source_Classification_Code.rds")
SCC_SUMMARY <- readRDS("air_quality/summarySCC_PM25.rds")

Coal <- SCC[grepl("coal", SCC$Short.Name, ignore.case = T),]
SCC_SUMMARYcoal <- SCC_SUMMARY[SCC_SUMMARY$SCC %in% Coal$SCC,]
totalCoal <- aggregate(Emissions ~ year + type, SCC_SUMMARYcoal, sum)

## Write the plot to png file
png(filename="plot4.png", width=480, height = 480)

ggplot(totalCoal, aes(year, Emissions, col = type)) +
  geom_line() +
  geom_point() +
  ggtitle("Total US ~ PM[2.5] Coal Emission by Type and Year") +
  xlab("Year") +
  ylab("US  PM[2.5] Coal Emission") +
  scale_color_manual(values = c("red", "blue"), name="Type of sources")
dev.off()
