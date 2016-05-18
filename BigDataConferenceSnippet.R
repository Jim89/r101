library(dplyr)
library(lubridate)
library(tidyr)
library(stringr)
library(networkD3)
library(igraph)


oyster <- read.csv("./data/oyster_all_raw_20160125.csv", 
                   header = TRUE, 
                   stringsAsFactors = FALSE)

names(oyster) <- tolower(names(oyster))

# Overall dimensions
dim(oyster)

# Number of columns
ncol(oyster)

# Number of rows
nrow(oyster)

str(oyster)

summary(oyster)

# Select all the dates
oyster$date

# Get the first 1 rows
oyster[1:10, ]

# Get just the first 3 columns
oyster[ , 1:3]

stations <- read.csv("./data/stations.csv", stringsAsFactors = FALSE) 

mutate(oyster, cost_plus_bal = sum(charge, balance, na.rm = TRUE))

oyster <- mutate(oyster, 
                 date.clean = dmy(date), # dmy = day, month, year
                 start.time.clean = hm(start.time), # hm = hour, minute
                 end.time.clean = hm(end.time))

oyster <- mutate(oyster, 
                 start.datetime = paste(date, start.time, sep = " "),
                 end.datetime = paste(date, end.time, sep = " "))

oyster <- mutate(oyster,
                 start.datetime = dmy_hm(start.datetime),
                 end.datetime = dmy_hm(end.datetime))

oyster <- mutate(oyster,
                 journey.time = difftime(end.datetime, 
                                         start.datetime, 
                                         units = "mins"))


# separate([data], [column to separate], [names of new columns], [how to split])
oyster <- separate(oyster,
                   col = journey.action, 
                   into = c("from", "to"), 
                   sep = " to ", 
                   remove = FALSE)

regex <- "\\[.*\\]|\\(.*\\)"


oyster <- mutate(oyster,
                 from.clean = str_trim(gsub(regex, "", from)),
                 to.clean = str_trim(gsub(regex, "", to)))

oyster <- left_join(oyster , stations, by = c("from.clean" = "station"))
oyster <- rename(oyster, 
                 from.long = long,
                 from.lat = lat)

oyster <- left_join(oyster, stations, by = c("to.clean" = "station"))
oyster <- rename(oyster,
                 to.long = long,
                 to.lat = lat)

oyster_summary <- group_by(oyster, journey.action)
oyster_summary <- summarise(oyster_summary, trips = n(),
                            avg_time = mean(as.numeric(journey.time)) 
                            oyster_summary <- arrange(oyster_summary, desc(trips))
                            

graph <- oyster %>% 
  group_by(from.clean, to.clean) %>% 
  summarise(weight = n()) %>% 
  filter(from.clean != "") %>% 
  filter(to.clean != "") %>% 
  graph_from_data_frame()

nw <- networkD3::igraph_to_networkD3(graph, group = rep(1, length(V(graph))))

# Weight links by number of gifts sent
nw$links$value <- 1

forceNetwork(Links = nw$links,
             Nodes = nw$nodes,
             colourScale = JS("d3.scale.category20()"),
             Source = "source",
             Target = "target",
             Value = "value",
             NodeID = "name",
             Group = "group",
             charge = -250,
             linkColour = "grey",
             opacity = 1,
             legend = F,
             bounded = F,
             zoom = TRUE,
             height = 550,
             width = 1000)