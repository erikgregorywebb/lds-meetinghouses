### 1. Navigate to https://www.churchofjesuschrist.org/maps/meetinghouses/
### 2. Right click Inspect -> Network -> XHR -> Copy -> Copy as cURL
### 3. Convert cURL to r (need header information and new token)

library(tidyverse)
library(dplyr)
library(httr)
library(jsonlite)

####### EXTRACT ####### 
url = 'https://ws.churchofjesuschrist.org/ws/maps/v1.0/services/rest/layer/location'

headers = c(
  `User-Agent` = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:88.0) Gecko/20100101 Firefox/88.0',
  `Accept` = 'application/json',
  `Accept-Language` = 'en-US,en;q=0.5',
  `Origin` = 'https://www.churchofjesuschrist.org',
  `DNT` = '1',
  `Connection` = 'keep-alive',
  `Referer` = 'https://www.churchofjesuschrist.org/'
)

params = list(
  `locale` = 'en',
  `layers` = 'meetinghouse',
  `client` = 'mapsClient',
  `token` = 'pcSTMSPmYMJZstNmkgSsjYUCtpc='
)

r = httr::GET(url = url, httr::add_headers(.headers=headers), query = params)
content = fromJSON(rawToChar(r$content), flatten = T)

####### CLEAN ####### 
# create meetinghouses dataframe
meetinghouses = content %>% 
  as_tibble() %>% 
  select(-type, -address.neighborhood, -detailsUpdated, -properties.Extent, -properties.HoursCode, -properties.HoursDisplay, 
         -properties.TimeZone, -properties.Assigned, -properties.Description) %>%
  unnest_wider(coordinates, names_sep = '_') %>% 
  rename('full_address' = 'addressFormatted', 'latitude' = 'coordinates_2', 'longitude' = 'coordinates_1',
         'address_line_1' = 'address.street', 'address_line_2' = 'address.street2', 'city' = 'address.city', 
         'county' = 'address.county', 'state' = 'address.state', 'state_code' = 'address.stateCode',
         'zipcode' = 'address.zip', 'country' = 'address.country', 'country_code_2_digit' = 'address.countryCode2', 
         'country_code_3_digit' = 'address.countryCode', 'created_year' = 'properties.CreatedYear', 'phone_alt' = 'properties.PhoneAlt') %>%
  mutate(phone = ifelse(is.na(phone) == TRUE, phone_alt, phone)) %>%
  mutate(city = gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(city), perl = TRUE)) %>%
  mutate(county = gsub("(?<=\\b)([a-z])", "\\U\\1", tolower(county), perl = TRUE)) %>%
  select(id, name, created_year, full_address, address_line_1, address_line_2, city, county, state, state_code, zipcode,
         country, country_code_2_digit, country_code_3_digit, phone, latitude, longitude)
glimpse(meetinghouses)  

# unnest meetinghouse assignments 
meetinghouses_assignments = content %>%
  select(meetinghouse_id = id, assignment = properties.Assigned) %>%
  unnest_longer(assignment, indices_include = FALSE) %>% flatten() %>%
  select(-assignment.properties) %>%
  rename('assignment_id' = 'assignment.id', 'assignment_type' = 'assignment.type', 
         'assignment_name' = 'assignment.name') %>% as_tibble()
glimpse(meetinghouses_assignments)
meetinghouses_assignments %>% group_by(assignment_type) %>% count(sort = T) %>% View()

####### EXPORT ####### 
setwd("~/Documents/Python/lds-meetinghouses")
write_csv(meetinghouses, 'lds_meetinghouses_20210524.csv')
write_csv(meetinghouses_assignments, 'lds_meetinghouse_assignments_20210524.csv')
