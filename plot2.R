
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
## 2 Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
##(fips == 24510) from 1999 to 2008?
##Use the base plotting system to make a plot answering this question.

Baltimore <- subset(SCC_SUMMARY, SCC_SUMMARY$fips =="24510")

sum_Baltimore <- aggregate(Emissions ~ year, Baltimore, sum)

## Write the plot to png file
png(filename="plot2.png", width=480, height = 480)

plot(sum_Baltimore$year, sum_Baltimore$Emissions,type="o", main="Sum of PM2.5 in Baltimore emmisons per year",
     xlab="Years", ylab="Sum of PM2.5 emissions", col="blue")

dev.off()
