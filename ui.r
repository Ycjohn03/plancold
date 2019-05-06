library(shinythemes)
ui <- fluidPage(theme = shinytheme("superhero"),titlePanel("Hourly Data"),
                fluidRow(
                  column(6,
                         fluidRow(
                           column(12,
                                  selectInput(inputId = "variable01", label = "X-axis:",
                                              choices = ( nnamme$V1 )),
                                  selectInput(inputId = "variable02", label = "Y-axis:",
                                              choices = ( nnamme$V1))),
                           column(12,plotOutput(outputId = "p1plot")),
                           h2("correlation coefficient"),
                           column(12,verbatimTextOutput("correlation"))
                         )),
                  column(6,
                         fluidRow(
                           column(12,
                                  plotOutput(outputId = "p2plot")),
                           column(12,
                                  plotOutput(outputId = "p3plot"))))
                )
)
