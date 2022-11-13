library(tidyverse)
library(lubridate)
library(sal)
library(scales)

# import and combine files
datalist = list()
extract_dates = c('20210524', '20210603', '20210701', '20210807', '20210906', '20211003', '20211106', 
                  '20211207', '20220109', '20220205', '20220304', '20220409', '20220605', '20220823', '20221112')
for (i in 1:length(extract_dates)) {
  url = paste('https://github.com/erikgregorywebb/lds-meetinghouses/blob/main/data/lds_meetinghouse_assignments_', extract_dates[i], '.csv?raw=true', sep = '')
  temp = read_csv(url)
  datalist[[i]] = temp %>% mutate(extract_date = extract_dates[i])
}
raw = do.call(rbind, datalist)

# clean
meetinghouse_assignments = raw %>% mutate(extract_date_ymd = ymd(extract_date))

# aggregate
meetinghouse_assignment_trend = meetinghouse_assignments %>%
  group_by(extract_date_ymd, assignment_type) %>% count() %>%
  arrange(extract_date_ymd, desc(n))

# plot
meetinghouse_assignment_trend %>%
  filter(assignment_type %in% c('ward', 'stake')) %>%
  ggplot(., aes(x = extract_date_ymd, y = n, col = assignment_type)) +
  scale_y_continuous(breaks= pretty_breaks(), labels = comma) + 
  geom_line() +
  facet_wrap(~assignment_type, scales = 'free')
