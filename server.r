library(shiny)
library(ggplot2)
library(gridExtra)
library(xts)
nnamme <- readRDS("C:/plancold/namme.rds")
data.t_hour <- readRDS("C:/plancold/data.t_hour.rds")
names(data.t_hour) <- (nnamme$V1)
server <- function(input, output) {
   variable01 <- reactive({(input$variable01)})
   variable02 <- reactive({(input$variable02)})
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