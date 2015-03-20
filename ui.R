

##CourseProject

##ui.R

library(shiny);library(ggplot2);data(diamonds);library(BH)

shinyUI(pageWithSidebar(
        
        headerPanel(h1("Get an Estimated Price of Your Diamond",
        style = "font-family: 
        'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"
                    )),
        
        
        
        
        
        sidebarPanel(
                
                img(src="diamond11.png",height=150,width=200), 
                h4('Weight (in carat)',style = "font-family: 'Lobster', cursive;
                        font-weight: 500; line-height: 1.1;color: #4d3a7d;"),
                numericInput("carat",label="",value=0.5,min=0.5,max=5,step=0.3),
                h4('Clarity',style = "font-family: 'Lobster', cursive;
                        font-weight: 500; line-height: 1.1;color: #4d3a7d;"),
                selectInput("clarity",label="",c("SI2","SI1","VS2","VS1","VVS2",
                        "VVS1","IF")),
                h4("Color",style = "font-family: 'Lobster', cursive;
                        font-weight: 500; line-height: 1.1;color: #4d3a7d;"),
                selectInput("color",label="",c("D","E","F","G","H")),
                h4("cut",style="font-family: 'Lobster', cursive;
                        font-weight: 500; line-height: 1.1;color: #4d3a7d;"),
                selectInput("cut",label="",c("Fair","Good","Very Good","Premium","Ideal"))
                
                ),
        
        
        mainPanel(
                
                h3('Your Diamond',style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                br(),
                h4('weight (in carat)',style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                verbatimTextOutput('carat_1'),
                h4('clarity',style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                verbatimTextOutput('clarity_1'),
                h4('color',style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                verbatimTextOutput('color_1'),
                h4('cut',style="font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                verbatimTextOutput('cut_1'),
                br(),
                h3('Estimated Price (in USD)',style = "font-family: 'Lobster', cursive;
        font-weight: 500; line-height: 1.1; 
        color: #4d3a7d;"),
                verbatimTextOutput('price_1')
                    
                
                )
        
        ))
        