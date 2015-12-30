library(shiny)
shinyUI(fluidPage(
        titlePanel("US Population Distribution"),
        sidebarLayout(
                sidebarPanel(
                        h4('Create demographic plots using 2010 US Census data.'),
                        helpText(strong('Instructions on how to operate:')),
                        p('1. Select the race of people you want to get information on.', br(),
                                        '2. Range of interest selects counties whose ',
                                        'percentages for the given race lie within this range.', br(),
                                        '3. The checkbox indicates whether you want to display the',
                                        ' histogram or not.', br(),
                                        '4. Once ready, hit the \'Update\' button for your settings ',
                                        'to take effect.\n', br(),
                                        'Note: There is a text output and a graph output. Both are',
                                        ' reactive.', br(), br()),
                        selectInput('category', label = strong('Choose the population category to display'),
                                    choices = list('Percent White' = 'Percent White',
                                                   'Percent Black' = 'Percent Black',
                                                   'Percent Hispanic' = 'Percent Hispanic',
                                                   'Percent Asian' = 'Percent Asian'), 
                                    selected = 'Percent White'),
                        sliderInput('range', label = strong('Range of interest'),
                                    min = 0, max = 100, value = c(1,100)),
                        checkboxInput('histSelect', label = 'Show histogram',
                                      value = T),
                        submitButton('Update')
                , width = 5),
                mainPanel(
                        textOutput('text1'),
                        br(),
                        plotOutput('histogram', height = 500)
                , width = 7)
        )
))