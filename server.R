
# Load libraries and data
library(caret)
library(ggplot2)

cars <- datasets::cars

# Generate 2nd and 3rd order features
cars$speed2 <- cars$speed^2
cars$speed3 <- cars$speed^3

# Create linear models from the data
fit1 <- lm(dist~speed-1,data=cars)
fit2 <- lm(dist~speed+speed2-1, data=cars)
fit3 <- lm(dist~speed+speed2+speed3-1, data=cars)

cars$fit1 <- fitted(fit1)
cars$fit2 <- fitted(fit2)
cars$fit3 <- fitted(fit3)

# Shiny Sever
shinyServer(
    function(input, output) {
        output$dataPlot <- renderPlot({
            fit <- switch(input$model,
                          "linear" = "fit1",
                          "quadratic" = "fit2",
                          "cubic" = "fit3")
            
            color <- switch(input$model,
                            "linear" = 'red',
                            "quadratic" = 'blue',
                            "cubic" = "green")
            
            ggplot(cars, aes(x=speed,y=dist)) + geom_point(size=3,colour='black') + 
                geom_line(aes_string(x="speed",y=fit),colour=color,size=2)
        })
        output$newDist <- renderText({
            newcar <- data.frame(speed=input$newSpeed,speed2=input$newSpeed^2,speed3=input$newSpeed^3)
            fit <- switch(input$model,
                          "linear" = fit1,
                          "quadratic" = fit2,
                          "cubic" = fit3)
            
            newdist <- predict(fit, newdata=newcar)
            paste("your stopping distance is", newdist, 'ft', sep=' ')
        })
        output$modelPrint <- renderText({paste("your prediction model is  ", input$model, sep=' ')})
})
