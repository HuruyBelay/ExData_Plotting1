## Reading the dataset from the web

if(!file.exists('data.zip')){
  url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  
  download.file(url,destfile = "data.zip")
}
unzip("data.zip") # This creates the file "household_power_consumption.txt"

## Reading the dataset from the local disk

data<-read.table("household_power_consumption.txt", sep = ";", header = T)

## checking the data set diminisions
dim(data)

## changing to Date format 
data$DateTime<-paste(data$Date, data$Time)

## concatenating Date and Time
data$DateTime<-strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")

## Filtering from the dataset of time 2007-02-01 and 2007-02-02

start<-which(data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
end<-which(data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))
data<-data[start:end, ]

## ## Plot the data and save the plot as plot1.png

png(filename = "plot1.png", width = 480, height = 480)

hist(as.numeric(as.character(data$Global_active_power)) , col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

dev.off()

