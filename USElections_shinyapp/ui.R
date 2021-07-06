#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    dashboardHeader(title = "Election profile",
                     dropdownMenu(badgeStatus = "success", type = c("messages","notifications","tasks"),
                                  messageItem("EC",
                                              "We are here to view the election history", 
                                              icon = shiny::icon("user"), 
                                              time = "Today"),
                                  notificationItem(icon = icon("users"), status = "info", "Get ready!"),
                                  taskItem(value = 50, color = "green", "Check the task")),
                    
                    dropdownMenu(badgeStatus = "warning", type = "notifications", icon = icon("bells"), 
                                 headerText = "Take note",
                                 notificationItem("Sometime presidential candidates lose popular votes but gets to be president",
                                                  icon = icon("info-circle"), status = "danger"))),
    
    dashboardSidebar(sidebarMenu(
        menuItem("dashboard", icon = icon("dashboard"), tabName = "dashboard"),
        menuItem("Widgets", icon = icon("th"), tabName = "widgets", badgeLabel = "candidates", badgeColor = "green"),
        menuItem("years", icon = icon("calendar"),
                 menuSubItem("sub-item1", tabName = "subitem1")),

        
        selectInput("select_yr", label = "Select election year", choices = c(unique(elections_historic$year))),
        tableOutput("yrs")
    )
    
    ),
    
    dashboardBody(fluidRow(
        # A static valueBox
        valueBox(10 * 2, "New Orders", icon = icon("credit-card")),
        
        # Dynamic valueBoxes
        valueBoxOutput("winner",),
        
        valueBoxOutput("party_won"),
        valueBoxOutput("winnerType")
    ),
    
    fluidRow(
        # box for sliderInput
        box( width = 5,
            sliderInput("elect_yr", "Select time period for timeseries analysis of election voter turnout",
                        min = 1824,
                        max = 2016,
                        step = 4,
                        sep = "",
                        value = c(1824, 2016)) 
        ),
        
        # line graph plot of votes for selected time period
        box(title = "Voter turnout timeseries ", solidHeader = TRUE, collapsible = TRUE, background = "green",width = 7,
            plotOutput("timeseries", height = 350)),
        
       
        
       
    ),
    
    fluidRow(
      
        box( 
            # box for describing winner whether unpopular or not 
            title = "Status of victory", width=4, textOutput("status"), background = "yellow",
            footer = "Losing the popular votes but winning the electoral colleage makes it unpopular victory",
            textOutput("unpopolarType")
        ),
        # box for ploting bar graph of frequency of party winning for selected period
        box(width = 4, solidHeader = TRUE, background = "red",
            footer = "Based on the year span selected we can calculated the frequency of winning election by various parties",
            title = "Party Profile", 
            plotOutput("partyprof")
        ),
        
        # box for turnout
        box(width = 4, solidHeader = TRUE, background = "blue", footer = "Election turnout is important for democracy",
            title = "Election turnout",
            valueBoxOutput("ecTurnout"))
    ),
    
    fluidRow(
        # box of radiobuttons for selecting themes
        box(background = "black", width = 3,
            radioButtons("theme", "Choose a theme for the graph", choiceNames = c("Dark mode",
                                                                                  "Gray mode",
                                                                                  "Classic mode"),
                         choiceValues = c("theme_dw", "theme_gray", "theme_classic"))
        )
    ))
)

    













# # Define UI for application that draws a histogram
# shinyUI(fluidPage(
# 
#     # Application title
#     titlePanel("Old Faithful Geyser Data"),
# 
#     # Sidebar with a slider input for number of bins
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#             plotOutput("distPlot")
#         )
#     )
# ))
