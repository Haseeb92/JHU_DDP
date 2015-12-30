library(shiny)
library(ggplot2)
counties <- readRDS("data/counties.rds")

shinyServer(
        function(input, output) {

                data <- reactive({
                        switch(input$category,
                               'Percent White' = counties$white,
                               'Percent Black' = counties$black,
                               'Percent Hispanic' = counties$hispanic,
                               'Percent Asian' = counties$asian
                        )
                })
                
                pops <- reactive({
                        counties$total.pop*data()/100
                })
                
                output$text1 <- renderText({
                        paste0('The total percentage of US mainland ',
                               'population that ',
                               strsplit(input$category, ' ')[[1]][2], 's ',
                               'make up is: ', 
                               signif(sum(pops(), na.rm = T)*100/sum(counties$total.pop, na.rm = T), 3), '%.'
                               )
                })
                
                finalData <- reactive({
                        data()[data() >= input$range[1] & data() <= input$range[2]]
                })
                
                output$histogram <- renderPlot({
                        if(input$histSelect) {
                                ggplot(as.data.frame(finalData())) + 
                                        geom_histogram(aes(x = finalData()), 
                                                       color = 'light green',
                                                       fill = 'dark green',
                                                       bins = 30) +
                                        ggtitle('Population distribution by county') +
                                        xlab('%age of people for the selected race per county') +
                                        ylab('Number of counties')
                        }
                }, height = 500, width = 500)
                
        }
)