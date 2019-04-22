nnamme <- readRDS("namme.rds")
data.t_hour <- readRDS("data.t_hour.rds")[-c(700:702),]
names(data.t_hour) <- (nnamme$V1)
