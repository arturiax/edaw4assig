## plot6.R
##Q6
##Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). 
#Which city has seen greater changes over time in motor vehicle emissions?

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

png("plot6.png")

NEI %>% 
  filter(SCC %in% mv_sources[,1], fips %in% c("24510", "06037")) %>% # We filter by motor vehicle sources in Baltimore or California
  mutate(City = ifelse(fips=="24510","Baltimore", "Los Angeles")) %>% 
  group_by(year, City) %>% 
  summarise(total_emissions = sum(Emissions)) %>% #We obtain total emissions by year
  ggplot(aes(x = year, y = total_emissions, col = City)) + 
  geom_line() # plot lines

dev.off()
#Los Angeles has seen greter changes