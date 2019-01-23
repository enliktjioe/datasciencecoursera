## Set my working directory
setwd("/Users/enlik/GitRepo/datasciencecoursera/DS_Course4_ExploratoryDataAnalysis/week4")

## Load required R Library
library(dplyr)
library(ggplot2)

## Read required datasets
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission 
## from all sources for each of the years 1999, 2002, 2005, and 2008.
require(dplyr)
q1 <- summarise(group_by(NEI, year), Emissions = sum(Emissions))

usedColors <- c("blue", "yellow", "green", "orange")
plot1 <- barplot(height = q1$Emissions/1000, names.arg = q1$year,
                 xlab = "years", ylab = expression('total PM2.5 emission in kilotons'),
                 ylim = c(0, 8000),
                 main = expression('Total PM'[2.5]*' emissions at various years in kilotons'),
                 col = usedColors)

## Add text on the top of bars
text(x = plot1, y = round(q1$Emissions/1000,2),
      label = round(q1$Emissions/1000,2), pos = 3,
      cex = 0.8, col = "black")


# Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.
require(dplyr)
q2 <- summarise(group_by(filter(NEI, fips == "24510"),
                                    year), Emissions = sum(Emissions))
usedColors <- c("blue", "yellow", "green", "orange")
plot2 <- barplot(height = q2$Emissions/1000, names.arg = q2$year,
                  xlab = "years", ylab = expression('Total PM'[2.5]*' emissions in kilotons'),
                  ylim =  c(0,4), main = expression('Total PM'[2.5]*' emissions in Baltimore City,
                                                    Maryland in kilotons'),
                  col = usedColors)

## add text on the top of bars
text(x = plot2, y = round(q2$Emissions/1000, 2),
     label = round(q2$Emissions/1000,2), pos = 3,
     cex = 0.8, col = "black")



# Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.
require(dplyr)
q3 <- summarise(group_by(filter(NEI, fips == "24510"), year,type), Emissions=sum(Emissions))

require(ggplot2)
ggplot(q3, aes(x = factor(year), y = q3$Emissions, fill = type, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  facet_grid(. ~ type) +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emission in tons")) +
  ggtitle(expression("PM"[2.5]*paste(" emissions in Baltimore ",
                                     "City by various source types", sep="")))+
  geom_label(aes(fill = type), colour = "white", fontface = "bold")


# Question 4
## Across the United States, how have emissions from coal combustion-related 
## sources changed from 1999-2008?
combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[combustion.coal,]

# Find emissions from coal combustion-related sources
emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

require(dplyr)
q4 <- summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))

require(ggplot2)
ggplot(q4, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
  ggtitle("Emissions from coal combustion-related sources in kilotons")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")


# Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
baltcitymary.emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

require(dplyr)
q5 <- summarise(group_by(baltcitymary.emissions, year), Emissions=sum(Emissions))

require(ggplot2)
ggplot(q5, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) +
  ggtitle("Emissions from motor vehicle sources in Baltimore City")+
  geom_label(aes(fill = year),colour = "white", fontface = "bold")


# Question 6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == “06037”). 
# Which city has seen greater changes over time in motor vehicle emissions?
require(dplyr)
baltcitymary.emissions<-summarise(group_by(filter(NEI, fips == "24510"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))
losangelscal.emissions<-summarise(group_by(filter(NEI, fips == "06037"& type == 'ON-ROAD'), year), Emissions=sum(Emissions))

baltcitymary.emissions$County <- "Baltimore City, MD"
losangelscal.emissions$County <- "Los Angeles County, CA"
q6 <- rbind(baltcitymary.emissions, losangelscal.emissions)

require(ggplot2)
ggplot(q6, aes(x=factor(year), y=Emissions, fill=County,label = round(Emissions,2))) +
  geom_bar(stat="identity") + 
  facet_grid(County~., scales="free") +
  ylab(expression("total PM"[2.5]*" emissions in tons")) + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variation in Baltimore and Los Angeles in tons"))+
  geom_label(aes(fill = County),colour = "white", fontface = "bold")
