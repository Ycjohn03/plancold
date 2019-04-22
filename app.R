
library(shiny)
library(ggplot2)
library(gridExtra)
library(xts)
nnamme <- readRDS("namme.rds")
data.t_hour <- readRDS("data.t_hour.rds")[-c(700:702),]
names(data.t_hour) <- (nnamme$V1)


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

ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions
  sidebarLayout(
    # Inputs: Select variables to plot
    sidebarPanel(
      # Select variable for y-axis
      selectInput(inputId = "variable01", label = "X-axis:",
                  choices = ( nnamme$V1 )),
      # Select variable for x-axis
      selectInput(inputId = "variable02", label = "Y-axis:",
                  choices = ( nnamme$V1))
    ),
    # Output: Show scatterplot
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

shinyApp(ui, server)
