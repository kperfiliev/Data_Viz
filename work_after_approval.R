#Kirill, Stuart, Andrew
library(dplyr)
library(countrycode)

#read the whole data
data <- read.csv("global_firepower_2022_wide.csv")

#create a table with the specific variables
project_data <- select(data, country, Active.Personnel, Defense.Budget, Waterways..usable., Attack.Helicopters, 
                       Fighters.Interceptors, Helicopters, Total.Aircraft.Strength)

#ensure the data has no nulls
project_data1 <- na.omit(project_data)

#it seems that Total.Aircraft.Strength = Fighters.Interceptors, so get rid off the one column
project_data2 <- project_data1[, -8]


#combining all of the air values together into a new column
project_data3 <- project_data2 %>%
  mutate(air_power = Attack.Helicopters + Fighters.Interceptors + Helicopters)

#working data with the main variables
project_data4 <- select(project_data3, country, Active.Personnel, Defense.Budget, Waterways..usable., air_power)

#add continent column
project_data4$continent <- countrycode(sourcevar = project_data4[, "country"],
                            origin = "country.name",
                            destination = "continent")

