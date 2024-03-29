# Exploratory Data Analysis: Peer-graded Assignment: Course Project 2


# plot6.R will download the Emission Data and Source Classification Code 
# and will produce a plot detailing whether PM2.5 has decreased in Baltimore City 
# and Los Angeles from 1999 to 2008 for motor vehicle sources

# This is acomplished in a number of steps:



# Set working directory, save the zip file URL, and the zip file name

setwd("C:/Users/jordan.woloschuk/Documents/GitHub/Exploratory_Data_Analysis-Course_Project_2")

zip_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

zip_file <- "exdata_data_NEI_data.zip"

# Names of the text files that are contained in the zip file

SCC_RDS <- "Source_Classification_Code.rds"
NEI_RDS <- "summarySCC_Pm25.rds"

# Checks if the above files exists. If not, checks to see if the zip file is in
# the directory, if not, then downloads the zip file.
# The zip file is then unzipped and the zipfile is then removed from the working
# directory.

if (!(file.exists(SCC_RDS) && file.exists(NEI_RDS))){
        if (!file.exists(zip_file)) {
                download.file(zip_url, zip_file, method = "curl")
        }
        
        # Unzip the zip file
        unzip(zip_file)
        
        # Remove the zip file to keep the repository tidy
        file.remove(zip_file)
}

# Read the text files for all data

NEI <- readRDS(NEI_RDS)
SCC <- readRDS(SCC_RDS)

# Pull only the Baltimore data


Baltimore_data <- NEI[NEI[,"fips"] == "24510", ]

# Pull only the on-road type data

Baltimore_data <- Baltimore_data[Baltimore_data[,"type"] == "ON-ROAD", ]


Baltimore_Total_by_year_On_Road <-  aggregate(Emissions ~ year, Baltimore_data, sum)


# Pull only the Los Angeles data


LA_data <- NEI[NEI[,"fips"] == "06037", ]

# Pull only the on-road type data

LA_data <- LA_data[LA_data[,"type"] == "ON-ROAD", ]


LA_Total_by_year_On_Road <-  aggregate(Emissions ~ year, LA_data, sum)

# Add LA emissions to Balitomore  then have two emission data sets


both_cities <- Baltimore_Total_by_year_On_Road
both_cities$Emissions_LA <- LA_Total_by_year_On_Road$Emissions

library(ggplot2)

png("plot6.png")

g_plot <- ggplot(both_cities, aes(year, y = Emissions, color = Cities)) + 
        geom_point(aes(y = Emissions, col = "Baltimore City"), cex = 4) + 
        geom_point(aes(y = Emissions_LA, col = "Los Angeles"), cex = 4)

g_plot <- g_plot + xlab("Year") + ylab("Total PM2.5 Emissions") +
               ggtitle("Baltimore City and Los Angeles Total PM2.5 Emissions from Motor Vehicles by Year") 


print(g_plot)

dev.off()

# Los Angeles has a greater changes over time in motor vehicle emissions compared
# to Baltimore City
