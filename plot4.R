# Exploratory Data Analysis: Peer-graded Assignment: Course Project 2


# plot4.R will download the Emission Data and Source Classification Code 
# and will produce a plot detailing whether PM2.5 has decreased the US
# from 1999 to 2008 from coal 

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


# Merge NEI and SCC datasets by SCC 

Merged_data <- merge(NEI,SCC, by = "SCC")

#Use filter to select only rows with coal as a fuel source

library(dplyr)
Coal_data <- filter(Merged_data, grepl("coal", Short.Name, ignore.case = TRUE))


# calculate the sum in each year

Coal_Total_by_year <-  aggregate(Emissions ~ year, Coal_data, sum)

# Plot 4: 

library(ggplot2)

png("plot4.png")

g_plot <- ggplot(Coal_Total_by_year, aes(year, Emissions))

g_plot <- g_plot + geom_bar(stat = "identity", fill = "red") + xlab("Year") + ylab("Total PM2.5 Emissions") +
        ggtitle("Total PM2.5 Emissions from Coal by Year")

print(g_plot)

dev.off()

