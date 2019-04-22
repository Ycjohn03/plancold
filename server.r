library(shiny)
library(ggplot2)
library(gridExtra)
library(xts)
server <- function(input, output) {
   variable01 <- reactive({input$variable01})
   variable02 <- reactive({input$variable02})
   # Create scatterplot object the plotOutput function is expecting
   output$scatterplot <- renderPlot({
      myData01 <- subset(data.t_hour, select=c(variable01(),variable02()))
      p1 <- ggplot(data=myData01, aes_string(variable01(),variable02())) +geom_point()
      p2 <- ggplot(data=myData01,aes_string(index(myData01),variable01()))+geom_line()+ xlab("Date") + ylab(variable01())
      p3 <- ggplot(data=myData01,aes_string(index(myData01),variable02()))+geom_line()+ xlab("Date") + ylab(variable02())
      grid.arrange(p2,p3,p1,ncol=2)
   })
}
