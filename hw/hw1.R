df <- read.csv("./hw/hw1_data.csv")

#Q1

names(df)

#Q2

tail(df)

#Q3

df$Ozone[47]

#Q4

sum(is.na(df$Ozone))

#Q4

mean(df$Ozone,na.rm = T)

#Q5

sb <- subset(df, Ozone>31 & Temp > 90)
mean(sb$Solar.R)

#Q6

mean(df[df$Month==6,"Temp"])

#Q7

max(df[df$Month==5,"Ozone"],na.rm=T)

#Q8

tapply(df$Temp, df$Month, mean)

#Q9

tapply(df$Temp, list(df$Month,df$Day), max)

#Q10