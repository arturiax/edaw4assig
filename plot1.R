## plot1.R
##Q1
##Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?


library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI.zip")
unzip("NEI.zip")

NEI <- readRDS("summarySCC_PM25.rds") #We dont need SCC data

png("plot1.png")

NEI %>% 
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions)) %>%  #We obtain total emissions by year
  plot(type ="l") # plot line

dev.off()
#There is a decrease