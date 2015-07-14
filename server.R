library(shiny)
library(ggplot2)

shinyServer(
   function(input, output) {

   # normal distribution logic      
      normData = reactive({
         rnorm(input$normSize)
      })  

      output$normPDF <- renderPlot({
         normGraph = normData()
         titleText <- paste(input$normSize, " random draws.")
         h=hist(normGraph, breaks=30, col="red", 
                main=titleText,
                xlab ="Randow draw value",
                freq = FALSE)
         h
         abline(v=mean(normGraph), col="black", lwd="2")
         nx = seq(-3, 3, 0.1)
         lines(x=nx, y=dnorm(nx), col = "blue", lwd="2")
      })
      
      output$normSummary <- renderPrint({
         summary(normData())
      })

   # poisson distribution logic
      poissonData = reactive({
         rpois(input$poisSize, input$poisLambda)
      })
      
      output$poissonPDF <- renderPlot({
         poisGraph = poissonData()
         px = seq(0, input$poisLambda * 4, 1)
         py = dpois(px, input$poisLambda)
         h=hist(poisGraph,
                col="red",
                main = paste(input$poisSize, " random draws."),
                xlab ="Randow draw value (count)",
                freq= FALSE,
                ylim =c(0, max(py)))
         abline(v=mean(poisGraph), col="black", lwd="2")
         points(px, py, pch=19, col="blue")
      })
      
   # Chi Square distribution logic
      chisqData = reactive({
         rchisq(input$chisqSize, input$chisqV)
      })
      
      output$chisqPDF <- renderPlot({
         chisqGraph = chisqData()
         px = seq(0, input$chisqSize, 0.1)
         py = dchisq(px, input$chisqV)
         h=hist(chisqGraph,
                col="red", breaks = 30,
                main = paste(input$chisqSize, " random draws."),
                xlab ="Randow draw value",
                freq= FALSE,
                ylim =c(0, max(py)))
         abline(v=mean(chisqGraph), col="black", lwd="2")
         lines(px, py, col="blue", lwd="2")
      })

   # Student t distribution logic
      tData = reactive({
         rt(input$tSize, input$tV)
      })
      
      output$tPDF <- renderPlot({
         tGraph = tData()
         px = seq(-4, 4, 0.1)
         py = dt(px, input$tV)
         h=hist(tGraph,
                col="red", breaks = 30,
                main = paste(input$tSize, " random draws."),
                xlab ="Randow draw value",
                freq= FALSE,
                ylim =c(0, max(py)))
         abline(v=mean(tGraph), col="black", lwd="2")
         lines(px, py, col="blue", lwd="2")
      })

  }
)
