oyster <- read.csv("./data/oyster_all_raw_20151113.csv", stringsAsFactors = FALSE)
names(oyster) <- names(oyster) %>% tolower

oyster_clean <- 
    oyster %>%
    slice(-grep("Topped-up|Season ticket|Unspecified location", journey.action)) %>%
    separate(col = journey.action, into = c("from", "to"), sep = " to ", remove = FALSE) %>% 
    mutate(start.time.clean = start.time %>% paste0(":00"),
           end.time.clean = end.time %>% paste0(":00"),
           date.clean = dmy(date),
           start.datetime = paste(date, start.time.clean, sep = " "),
           end.datetime = paste(date, end.time.clean, sep = " "),
           start.datetime = dmy_hms(start.datetime),
           end.datetime = dmy_hms(end.datetime),
           journey.time = difftime(end.datetime, start.datetime, units = "mins"),
           journey.weekday = wday(date.clean, label = TRUE, abbr = FALSE),
           from.clean = str_trim(gsub("\\[.*\\]|\\(.*\\)| [Dd][Ll][Rr]", "", from)),
           to.clean = str_trim(gsub("\\[.*\\]|\\(.*\\)| [Dd][Ll][Rr]", "", to))) %>% 
    left_join(stations, by = c("from.clean" = "station")) %>% 
    rename(from.long = long, 
           from.lat = lat) %>% 
    left_join(stations, by = c("to.clean" = "station")) %>% 
    rename(to.long = long, 
           to.lat = lat)