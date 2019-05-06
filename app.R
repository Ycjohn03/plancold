nnamme <- readRDS("namme.rds")
data.t_hour <- readRDS("data.t_hour.rds")
names(data.t_hour) <- (nnamme$V1)


library(shinythemes)
library(shiny)
library(ggplot2)
library(gridExtra)
library(xts)
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


server <- function(input, output) {
  variable01 <- reactive({as.data.frame(input$variable01)})
  variable02 <- reactive({as.data.frame(input$variable02)})
  # Create scatterplot object the plotOutput function is expecting
  output$p1plot <- renderPlot({
    myData01 <- subset(data.t_hour, select=c(variable01(),variable02()))
    ggplot(data=myData01, aes_string(variable01(),variable02())) +geom_point(shape=18, color='#E69F00')+labs(title="Two Variables scatter plot")
  })
  output$p2plot <- renderPlot({
    myData01 <- subset(data.t_hour, select=c(variable01(),variable02()))
    ggplot(data=myData01,aes_string(index(myData01),variable01()))+geom_line(color='#56B4E9')+ xlab("Date") + ylab(variable01())
  })
  output$p3plot <- renderPlot({
    myData01 <- subset(data.t_hour, select=c(variable01(),variable02()))
    ggplot(data=myData01,aes_string(index(myData01),variable02()))+geom_line(color='#56B4E2')+ xlab("Date") + ylab(variable02())
  })
  output$correlation <- renderPrint({
    myData01 <- subset(data.t_hour, select=c(variable01(),variable02()))
    cor(myData01, use="complete.obs")[2,1]
  })
}
shinyApp(ui, server)

