
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


## 3 Of the four types of sources indicated by the
## type (point, nonpoint, onroad, nonroad) variable, which of these four sources have
## seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases
## in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this
## question.


Baltimore <- subset(SCC_SUMMARY, SCC_SUMMARY$fips =="24510")

Type <- aggregate(Emissions ~ year + type, Baltimore, sum)

## Write the plot to png file
png(filename="plot3.png", width=480, height = 480)

ggplot(Type, aes(year, Emissions, col= type)) + geom_line()+geom_point()+
  ggtitle("Baltimore PM2.5 Emissions by Type and Year")+
  xlab("Year")+
  ylab("Total Emissions")+
  scale_color_discrete(name="Four Sources:")+
  theme(legend.title = element_text(face ="bold"))
dev.off()
