# LOAD LIBRARY
library(tidyverse)
library(socviz)

elections_historic

## load dataset
election_dataset <- elections_historic
#View(election_dataset)
#piping the dataset to make it available to other functions without explicitly refering to it
election_dataset %>%
select("Year" = year, "Winner_Party" = win_party, "President elected" = winner, votes, "Share_electoral_college_%" = ec_pct,
       "Popular_vote_share_%" = popular_pct, "Popular_vote_margin" = margin, turnout_pct, "Winner_electoral_college_vote" = ec_votes) %>% 
ggplot( aes(x = Year, y = turnout_pct)) + geom_line() + geom_smooth(method = loess) + theme_bw()+ 
  xlab("Years of election") + ylab("Voter turnout as a proportion of eligible voters") + 
  ggtitle("Time series of US elections voter turnout since 1824")
