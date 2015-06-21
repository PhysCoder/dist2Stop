# A Shiny Application
# The application must include the following:
# Some form of input (widget: textbox, radio button, checkbox, ...)
# Some operation on the ui input in sever.R
# Some reactive output displayed as a result of server calculations
# You must also include enough documentation so that a novice user could use your application.
# The documentation should be at the Shiny website itself. Do not post to an external link
# http://shiny.rstudio.com/tutorial/

# UI control of the App, which consists of a side panel with model selection and test speed input
# The main panel includes a scatter plot of the raw data with the fitted model overlaid

shinyUI(fluidPage(
        titlePanel("Dist2Stop"),
        
        sidebarLayout(
            
            sidebarPanel(
                helpText("Create a predictive model between Speed and stopping distance of cars\n"), 
                helpText("Press 'Predict' after entering model choice and test speed"),
                selectInput(inputId = "model",
                    label = " Choose prediction model",
                    choices = c("linear","quadratic","cubic"),
                    selected = "linear"),
                numericInput(inputId="newSpeed",label="Your speed (mph)",value=0,min=0),
                submitButton(text="predict"),
                h4(textOutput(outputId="newDist"),style = "color:red"),
                h4(textOutput(outputId="modelPrint"),style = "color:blue")
            ),
            
            mainPanel(plotOutput("dataPlot"))
        )

    )
)