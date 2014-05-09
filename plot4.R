#######################################
#Read data
hpc<- read.table("household_power_consumption.txt", header = TRUE, sep=";", na.strings = "?")
hpc[,10] <- as.Date(hpc$Date, format = "%d/%m/%Y")

#Subset the data to work with only relevant rows
hpc1<- hpc[hpc$V10== "2007-02-01",]
hpc2<- hpc[hpc$V10== "2007-02-02",]
hpc3<- rbind(hpc1,hpc2) #final dataset towrk with is called hpc3

hpc3[,11]<- as.character(paste(hpc3$Date, hpc3$Time), sep = " ")
hpc3$datetime <- as.POSIXct(strptime(hpc3[,11], format = "%d/%m/%Y %H:%M:%S"))
########################################



#plot4
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2,2))

with(hpc3, { 
  plot(
    hpc3$datetime, 
    hpc3$Global_active_power, 
    ylab = "Global Active Power", 
    xlab="",
    col="black", 
    type = "l"
    , bg="transparent"
  )
  
  plot(
    hpc3$datetime, 
    hpc3$Voltage, 
    ylab = "Voltage", 
    xlab="datetime",
    col="black"
    ,type = "l"
    , bg="transparent"
  )
  
  
  plot(
    hpc3$datetime, 
    hpc3$Sub_metering_1, 
    ylab = "Energy sub metering", 
    xlab="",
    col="black", 
    type = "l"
    , bg= "transparent"
  )
  lines(
    hpc3$datetime, 
    hpc3$Sub_metering_2, 
    col="red"
    , bg= "transparent"
  )
  lines(
    hpc3$datetime, 
    hpc3$Sub_metering_3, 
    col="blue" 
    , bg= "transparent"
  )
  legend("topright", 
         lty=1, 
         col=c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
         , bty="n")
  
  
  plot(
    hpc3$datetime, 
    hpc3$Global_reactive_power, 
    ylab = "Global_reactive_power", 
    xlab="datetime",
    col="black"
    ,type = "l"
    , bg="transparent"
  )
})
dev.off()
