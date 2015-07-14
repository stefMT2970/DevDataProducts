library(shiny)
library(shinydashboard)

# define tab's upfront
normTab = tabItem(
   tabName="normDis",
   tags$p("Select a sample size to generate normal random draws."),
   tags$p( "The vertical line shown is the mean of the random draws,
           A standard normal Gauss curve is superimposed.
           The summary table applies to the random draws."),
   fluidRow(
         column(6,
                h4("Select sample size"),
                sliderInput(inputId= 'normSize', 
                            label ='Sample Size', 
                            min=50, max=2000,
                            value=500,
                            step=50)
         )
      ),
      fluidRow(
         plotOutput("normPDF")
      ),
      fluidRow(
         verbatimTextOutput("normSummary")   
      )
   )

poissonTab = tabItem(
   tabName="poissonDis",
      tags$p("Select a sample size and lambda value to generate Poisson random draws.
             The vertical line shown is the mean of the random draws,
             which should be close to the selected lambda value.
             The blue dots show the theoretical Poisson distribution."),
      fluidRow(
         column(6,
                h4("Select sample size"),
                sliderInput(inputId= 'poisSize', 
                            label ='Sample Size', 
                            min=50, max=2000,
                            value=500,
                            step=50)
         ),
         column(6,
                h4("Select lambda"),
                sliderInput(inputId= 'poisLambda', 
                            label ='Lambda (mean)', 
                            min=1, max=20,
                            value=2,
                            step=0.2)
         )
      ),
      fluidRow(
         plotOutput("poissonPDF")
      )
   )

chisqTab = tabItem(
   tabName="chisqDis", 
      tags$p("Select a sample size and v (degrees of freedom) value to generate 
             chi square random draws.
             The vertical line shown is the mean of the random draws which should
             be close to the degrees of freedom. The blue line shows the 
             theoretical chi square distribution
             "),
      fluidRow(
         column(6,
                h4("Select sample size"),
                sliderInput(inputId= 'chisqSize', 
                            label ='Sample Size', 
                            min=50, max=2000,
                            value=500,
                            step=50)
         ),
         column(6,
                h4("Select degrees of freedom"),
                sliderInput(inputId= 'chisqV', 
                            label ='Degrees of freedom', 
                            min=2, max=50,
                            value=5,
                            step=1)
         )
      ),
      fluidRow(
         plotOutput("chisqPDF")
      )
   )

tTab = tabItem(
   tabName="tDis", 
   tags$p("Select a sample size and v (degrees of freedom) value to generate 
             Students t random draws.
          The vertical line shown is the mean of the random draws which should
          be close to 0. The blue line shows the 
          theoretical t distribution.
          "),
   fluidRow(
      column(6,
             h4("Select sample size"),
             sliderInput(inputId= 'tSize', 
                         label ='Sample Size', 
                         min=50, max=2000,
                         value=500,
                         step=50)
      ),
      column(6,
             h4("Select degrees of freedom"),
             sliderInput(inputId= 'tV', 
                         label ='Degrees of freedom', 
                         min=2, max=50,
                         value=5,
                         step=1)
      )
   ),
   fluidRow(
      plotOutput("tPDF")
   )
)

aboutTab = tabItem(
   tabName = "about", 
   tags$h3("Examinations of common probability distributions"),
   tags$p("Select one of the distributions from the sidebar to start the visualisation."),
   tags$p("Use the sliders to change the sample size or the parameters.")
   )


# UI definition
shinyUI(
   dashboardPage(
      dashboardHeader(title="Common Distributions"),
      
      dashboardSidebar(
         sidebarMenu(
            menuItem("About", tabName="about", selected = TRUE),
            menuItem("Normal Distribution", tabName = "normDis"),
            menuItem("Poisson Distribution", tabName="poissonDis"),
            menuItem("Chi Square Distribution", tabName="chisqDis"),
            menuItem("Student T Distribution", tabName="tDis")
         )         
      ),
      
      dashboardBody(
         tabItems( aboutTab, normTab, poissonTab, chisqTab, tTab )
      )
   )
)

