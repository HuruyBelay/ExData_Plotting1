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

## Plot the data and save the plot as plot4.png

png(filename = "plot4.png", width = 480, height = 480)

par(mfcol=c(2,2))

plot(data$DateTime, as.numeric(as.character(data$Global_active_power)),
     type='l',ylab="Global Active Power", xlab="")

plot(data$DateTime, as.numeric(as.character(data$Sub_metering_1)),
     type='l', xlab="",ylab ="Energy sub metering")
lines(data$DateTime, as.numeric(as.character(data$Sub_metering_2)),
      type='l', col='red')
lines(data$DateTime, data$Sub_metering_3,type='l', col="blue")
legend('topright', c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1),col=c("black","red","blue"))

plot(data$DateTime, as.numeric(as.character(data$Voltage)),type='l', 
     ylab="Voltage",xlab="datetime" )

plot(data$DateTime, as.numeric(as.character(data$Global_reactive_power)),
     type='l', ylab="Global_reactive_power",xlab="datetime" )

dev.off()
