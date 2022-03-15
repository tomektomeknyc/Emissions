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

## 1) Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from
## all sources for each of the years 1999, 2002, 2005, and 2008.
## Yes they have:
sum_SCC_SUMMARY <- aggregate(Emissions ~ year, SCC_SUMMARY , sum)

## Write the plot to png file
png(filename="plot1.png", width=480, height = 480)

plot(sum_SCC_SUMMARY$year, sum_SCC_SUMMARY$Emissions, type="s", col="green",main="Total PM2.5 Emmisions per Year"
     ,ylab="Total US PM2.5 Emissions", xlab="Year")
dev.off()
