
##server.R

##Load libraries and data to be used
library(shiny);library(ggplot2);data(diamonds);library(dplyr);library(BH)

##select parameters which can be asked to the user

diamonds<-select(diamonds,-x,-y,-z,-depth,-table)
model<-lm(data=diamonds,price~carat+color+clarity+cut-1)

shinyServer(
        function(input,output){
                output$carat_1<-renderPrint({input$carat})
                output$clarity_1<-renderPrint({input$clarity})
                output$color_1<-renderPrint({input$color})
                output$cut_1<-renderPrint({input$cut})
                output$price_1<-renderPrint({
                        if(predict(newdata=data.frame(carat=input$carat,clarity=input$clarity,
                                color=input$color,cut=input$cut),model)>0){
                                return(predict(newdata=data.frame(carat=input$carat,
                                                                  clarity=input$clarity,
                                                                  color=input$color,cut=input$cut),model))
                        }else{
                                return(0)
                                
                        }
                             
                        
                })
                
        }
        
        )