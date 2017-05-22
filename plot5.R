## plot5.R
##Q5
##How have emissions from motor vehicle sources 
#changed from 1999–2008 in Baltimore City?

library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI.zip")
unzip("NEI.zip")

NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

#We are going to consider motor vehicle sources 
#those sources that are are recorded with "Vehicle" in the
# EI.Sector variable of the sources base

mv_sources <- 
  filter(SCC, grepl("[Vv]ehicle", EI.Sector)) %>% 
  select(SCC) %>% 
  mutate(SCC = as.character(SCC))   # We convert to character, as we are not using then as factors

png("plot5.png")

NEI %>% 
  filter(SCC %in% mv_sources[,1], fips == "24510") %>% # We filter by motor vehicle sources in Baltimore
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions)) %>%  #We obtain total emissions by year
  plot(type ="l") # plot line

dev.off()
#There is a decrease