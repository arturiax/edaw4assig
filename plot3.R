## plot3.R
##Q3
##Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
##Which have seen increases in emissions from 1999–2008? 

library(dplyr)
library(ggplot2)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI.zip")
unzip("NEI.zip")

NEI <- readRDS("summarySCC_PM25.rds") #We dont need SCC data

png("plot3.png")


NEI %>% 
  filter(fips == "24510") %>% 
  group_by(type, year) %>% 
  summarise(total_emissions = sum(Emissions)) %>% 
  ggplot(aes(x = year, y = total_emissions, col = type)) +
  geom_line()


dev.off()
#Total emissions decrease in all types except type POINT


