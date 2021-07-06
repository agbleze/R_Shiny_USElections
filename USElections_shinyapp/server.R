#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(socviz)

theData <- reactive({
    ## load dataset
    election_dataset <- elections_historic
    #View(election_dataset)
    #piping the dataset to make it available to other functions without explicitly refering to it
    election_dataset %>%
        select(year, win_party, "President elected" = winner, votes, 
               "Share_electoral_college_%" = ec_pct,
               popular_pct, "Popular_vote_margin" = margin, turnout_pct, 
               "Winner_electoral_college_vote" = ec_votes) %>%
        filter(year == input$elect_yr[1], year == input$elect_yr[2])
})

server <- function(input, output, session){
    # plot timeseries of voter turnout
    output$timeseries <- renderPlot({
        ggplot(data  = theData(), x = year, y = turnout_pct) + geom_line() + 
            geom_smooth(method = loess())
    }
        
    )
    
    # plot of unpopular type
    output$unpopolarType <- renderText({
        ifelse(election_dataset$popular_pct > 0.5, "Popular", "Unpopular")
    }
        
    )
    
    # plot for party profile
    output$partyprof <- renderPlot({
        ggplot(data = theData()) + geom_bar(aes(win_party, fill = win_party), stat = count)
    })
    
    # plot for turnout
    output$ecTurnout <- renderValueBox({
        yearSel <- select_yr.value
        
        turnout <- filter(elections_historic$year == yearSel)
        turnoutData <- as.numeric(turnout$turnout_pct) * 100
    })
}








# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')

    })

})
