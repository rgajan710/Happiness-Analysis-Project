# app.R
library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(readr)

# Load the dataset
happiness <- read_csv("data/world-happiness-report.csv")

# Preprocess dataset
happiness <- happiness %>%
  select(Country, Happiness_Score, GDP_per_Capita, Social_Support, Healthy_Life_Expectancy, Freedom, Generosity, Corruption)

happiness <- na.omit(happiness)  # Remove missing values

# UI
ui <- dashboardPage(
  dashboardHeader(title = "Global Happiness Analysis"),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      selectInput("xvar", "Select X-axis Variable:",
                  choices = c("GDP_per_Capita", "Social_Support", "Healthy_Life_Expectancy", "Freedom", "Generosity", "Corruption"),
                  selected = "GDP_per_Capita"),
      sliderInput("gdpRange", "Filter by GDP per Capita:",
                  min = min(happiness$GDP_per_Capita, na.rm = TRUE),
                  max = max(happiness$GDP_per_Capita, na.rm = TRUE),
                  value = c(min(happiness$GDP_per_Capita, na.rm = TRUE), max(happiness$GDP_per_Capita, na.rm = TRUE)))
    )
  ),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(plotOutput("scatterPlot", height = 400), width = 12),
                box(tableOutput("summaryTable"), width = 12)
              )
      )
    )
  )
)

# Server
server <- function(input, output) {
  
  filteredData <- reactive({
    happiness %>%
      filter(GDP_per_Capita >= input$gdpRange[1],
             GDP_per_Capita <= input$gdpRange[2])
  })
  
  output$scatterPlot <- renderPlot({
    ggplot(filteredData(), aes_string(x = input$xvar, y = "Happiness_Score")) +
      geom_point(color = "#2E86C1", size = 2) +
      geom_smooth(method = "lm", se = FALSE, color = "red") +
      labs(x = input$xvar, y = "Happiness Score") +
      theme_minimal()
  })
  
  output$summaryTable <- renderTable({
    filteredData() %>%
      summarise(
        Avg_Happiness_Score = round(mean(Happiness_Score), 2),
        Avg_GDP = round(mean(GDP_per_Capita), 2),
        Avg_Social_Support = round(mean(Social_Support), 2),
        Avg_Health = round(mean(Healthy_Life_Expectancy), 2)
      )
  })
}

# Run the app
shinyApp(ui, server)
