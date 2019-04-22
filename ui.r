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
