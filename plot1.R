# Exploratory Data Analysis: Peer-graded Assignment: Course Project 2


# plot1.R will download the Emission Data and Source Classification Code 
# and will produce a plot detailing whether PM2.5 has decreased in the US
# from 1999 to 2008

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

# Plot 1: Aggregate to calculate the sum in each year

Total_by_year <-  aggregate(Emissions ~ year, NEI, sum)

png("plot1.png")

plot(Total_by_year$year,Total_by_year$Emissions, pch = 19, col = Total_by_year$year,
     cex = 3, xlab = "Year", ylab = "Total PM2.5 Emissions",
     main = "Total PM2.5 Emissions by Year")

dev.off()

#PM2.5 emissions have decreased in the United States from 1999 to 2008


