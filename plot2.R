## plot2.R
##Q2
##Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008?

library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI.zip")
unzip("NEI.zip")

NEI <- readRDS("summarySCC_PM25.rds") #We dont need SCC data

png("plot2.png")

NEI %>% 
  filter(fips == "24510") %>% 
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions)) %>% 
  plot(type ="l")


dev.off()
#Total emissions decrease from 1998 to 2008 but from 2002 to 2005 there was a increase


