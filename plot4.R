## plot4.R
##Q4
##Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "NEI.zip")
unzip("NEI.zip")

NEI <- readRDS("summarySCC_PM25.rds") 
SCC <- readRDS("Source_Classification_Code.rds")

#We are going to consider emissions from coal combusion-related sources 
#those sources that are are recorded with "Fuel Comb" and "Coal"  in the
# EI.Sector variable of the sources base

# We get coal combusion-related sources
coal_sources <- 
    filter(SCC, grepl("Fuel Comb.*Coal", EI.Sector)) %>% 
    select(SCC) %>% 
    mutate(SCC = as.character(SCC))   # We convert to character, as we are not using then as factors


png("plo4.png")

NEI %>% 
  filter(SCC %in% coal_sources[,1]) %>% # We filter by coal combusion-related sources
  group_by(year) %>% 
  summarise(total_emissions = sum(Emissions)) %>%  #We obtain total emissions by year
  plot(type ="l") # plot line

dev.off()
#There is a decrease