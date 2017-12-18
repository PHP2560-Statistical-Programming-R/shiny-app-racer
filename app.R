#source("check_packages.R")

library(shiny)
library(tidyverse)
library(shinythemes)
library(racecar)
library(plotly)

###requires racecar package

ui <- fluidPage(theme = shinytheme("cyborg"),
                ####CSS CODE TO FORMAT THE TWO TAB NAVIGATION BAR
                tags$style(type = 'text/css', '.navbar { background-color:black;
                           font-family: Arial;
                           font-size: 13px;
                           color:black; }',
                           '.navbar-default .navbar-brand {
                           color:red;
                           }',
             
                           ####CSS CODE TO SUPRESS INITIAL WARNING ERRORS WHEN DATA IS NOT UPLOADED
                           ".shiny-output-error { visibility: hidden; }",
                           ".shiny-output-error:before { visibility: hidden; }"),
                
                navbarPage("raceR",
                           tabPanel("About", fluidRow(column(width = 4,
                                                             tags$img(src = "logo.jpg")), 
                                                      column(width = 6, 
                                                             tags$h1("raceR", style = "color:red;"))),
                                              fluidRow(column(width = 12, tags$h4("Welcome to raceR! This app provides an interactive interface
                                                                                  that complements the racecar package. RaceR is 
                                                                                  designed to be used by those interested in perfomance analytics 
                                                                                  from racecar data and provides a simple design for generating and 
                                                                                  comparing the most common plots used to analyze racecar data. 
                                                                                  The data is measured from the car while driving 
                                                                                  around a race track. The car sends the data to racestudio2 software. 
                                                                                  The data can be exported from racestudio2 into a csv. The files uploaded
                                                                                  to this app should only be .csv exports from racestudio2."), 
                                                              tags$h5("raceR provides two different options for looking at data - shown above as 'Single' and 
                                                                      'Compare'."), 
                                                              tags$h5("Choose the 'Single' tab if you are interested in looking at data for a single lap by a 
                                                                      single driver and do not want to compare it to other data."), 
                                                              tags$h5("Choose the 'Compare' tab if you are interested in comparing lap data among 2 different
                                                                       driver, comparing 2 laps completed by the same driver, or looking at different plots for the
                                                                      same driver on the same lap.")))),
                           
                           
                           ######### tab for looking at one set of data - for one driver or one lap #########       
                           tabPanel("Single", fluidRow(column(width = 4,
                                                              tags$img(src = "logo.jpg")), 
                                                       column(width = 6, 
                                                              tags$h1("raceR", style = "color:red;"))),
                                    ######## csv upload box for single data tab
                                    
                                    fluidRow(column(width = 12,
                                                    fileInput("upload1", label = h4("Upload .csv here")))),
                                    
                                    ######## graph choice drop down for single data tab           
                                    fluidRow(column(width = 12, selectInput("graphtype1", label = h5("Choose Graph"),
                                                                            choices = list("Braking Map" = "braking", "Throttle Position Map" = "throttle",
                                                                                           "Graph of Lap Speed" = "laps", "Map of Lap RPM" = "maprpm", 
                                                                                           "Map of Lap Speed" = "mapspeed", "Air to Fuel Ratio vs RPM" = "airfuel", 
                                                                                           "Oil Pressure Map" = "oilpressure"),
                                                                            selected = "mapspeed"))),
                                    
                                    ######## distance slider for single data tab       
                                    fluidRow(column(width = 12,
                                                    sliderInput("distrange1", label = h5("Select Distance"), 
                                                                min = 0,
                                                                max = 3.5, value = c(0, 3.5)))),
                                    
                                    fluidRow(column(width = 12, textOutput("text1"))),
                                    ######## graphical output for single data tab         
                                    fluidRow(column(width = 12, height = "auto",
                                                    plotlyOutput("graph1")),
                                    ######## test output for the point on the graph         
                                             verbatimTextOutput("event")),
                                    ######## summary statistics output for single data tab         
                                    fluidRow(column(width = 12,
                                                    tableOutput("table1")))),
                                    
                           
                           ######### tab for looking at two sets of data - compare two drivers or compare two laps of the same driver #########    
                           tabPanel("Compare", 
                                    fluidRow(column(width = 6,
                                                    tags$img(src = "logo.jpg")), 
                                             column(width = 6, 
                                                    tags$h1("raceR", style = "color:red;"))),
                                    ######## left csv upload box for compare data tab      
                                    fluidRow(column(width = 6,
                                                    fileInput("upload2", label = h4("Upload .csv here"))),
                                             ######## right csv upload box for compare data tab  
                                             column(width = 6,
                                                    fileInput("upload3", label = h4("Upload .csv here")))),
                                    
                                    ######## left graph choice drop down for compare data tab
                                    fluidRow(column(width = 4,
                                                    selectInput("graphtype2", label = h5("Choose Graph"),
                                                                choices = list("Braking Map" = "braking", "Throttle Position Map" = "throttle",
                                                                               "Graph of Lap Speed" = "laps", "Map of Lap RPM" = "maprpm", 
                                                                               "Map of Lap Speed" = "mapspeed", "Air to Fuel Ratio vs RPM" = "airfuel",
                                                                               "Oil Pressure Map" = "oilpressure"),
                                                                selected = "mapspeed")),
                                             ######## distance slider for compare data tab
                                             column(width = 4,
                                                    sliderInput("distrange2", label = h5("Select Distance"), 
                                                                min = 0,
                                                                max = 3.5, value = c(0, 3.5))),
                                             
                                             ######## right graph choice drop down for compare data tab       
                                             column(width = 4,
                                                    selectInput("graphtype3", label = h5("Choose Graph"),
                                                                choices = list("Braking Map" = "braking", "Throttle Position Map" = "throttle",
                                                                               "Graph of Lap Speed" = "laps", "Map of Lap RPM" = "maprpm", 
                                                                               "Map of Lap Speed" = "mapspeed", "Air to Fuel Ratio vs RPM" = "airfuel",
                                                                               "Oil Pressure Map" = "oilpressure"),
                                                                selected = "mapspeed"))),
                                    fluidRow(column(width = 6, 
                                                    textOutput("text2")),
                                             column(width = 6, 
                                                    textOutput("text3"))),
                                    ######## left graphical output for compare data tab 
                                    fluidRow(column(width = 6, height = "400px",
                                                    plotlyOutput("graph2")),
                                             ######## right graphical output for compare data tab           
                                             column(width = 6, height = "400px",
                                                    plotlyOutput("graph3"))),
                                    
                                    ######## left summary statistics output for compare data tab  
                                    fluidRow(column(width = 6,
                                                    tableOutput("table2")),
                                             
                                             ######## right summary statistics output for compare data tab  
                                             column(width = 6,
                                                    tableOutput("table3")))))) 



server <- function(input, output) {
  
  options(shiny.maxRequestSize = 50*1024^2)
  
  ##create plot for single data tab based on user input from dropdown menu
  output$graph1 <- renderPlotly( {
    input_data <- cleanSingleLap(input$upload1$datapath, 1)
    if(input$graphtype1 %in% c("laps")) {
      lapspeed(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("mapspeed")) {
      mapspeed(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("maprpm")) {
      maprpm(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("throttle")) {
      throttle_position(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("braking")) {
      braking_pattern(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("airfuel")) {
      airfuel(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype1 %in% c("oilpressure")) {
      oilpressure(input_data, 1, startdist = input$distrange1[1], enddist = input$distrange1[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } 
  })
  output$event <- renderPrint({
    d <- event_data("plotly_hover")
    if (is.null(d)) "Hover on a point!" else d
  })
  ##create left plot for compare data tab based on user input from dropdown menu
  output$graph2 <- renderPlotly({
    input_data <- cleanSingleLap(input$upload2$datapath, 1)
    if(input$graphtype2 %in% c("laps")) {
      lapspeed(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
    } else if (input$graphtype2 %in% c("mapspeed")) {
      mapspeed(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype2 %in% c("maprpm")) {
      maprpm(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2] + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      ))
      
    } else if (input$graphtype2 %in% c("throttle")) {
      throttle_position(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype2 %in% c("braking")) {
      braking_pattern(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype2 %in% c("airfuel")) {
      airfuel(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype2 %in% c("oilpressure")) {
      oilpressure(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    }
    
  })
  ##create right plot for compare data tab based on user input from dropdown menu 
  output$graph3 <- renderPlotly({
    input_data <- cleanSingleLap(input$upload3$datapath, 1)
    if(input$graphtype3 %in% c("laps")) {
      lapspeed(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("mapspeed")) {
      mapspeed(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("maprpm")) {
      maprpm(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("throttle")) {
      throttle_position(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("braking")) {
      braking_pattern(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("airfuel")) {
      airfuel(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    } else if (input$graphtype3 %in% c("oilpressure")) {
      oilpressure(input_data, 1, startdist = input$distrange2[1], enddist = input$distrange2[2]) + theme(
        strip.background = element_blank(),
        strip.text.x = element_blank()
      )
      
    }
    
  })
  ##create summary statistics table for single data tab
  output$table1 <- renderTable( {
    input_data <- cleanSingleLap(input$upload1$datapath, 1)
    if(input$graphtype1 %in% c("laps")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        group_by(lap) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype1 %in% c("mapspeed")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype1 %in% c("maprpm")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_RPM = mean(PE3_RPM), Sd_RPM = sd(PE3_RPM))
      
    } else if (input$graphtype1 %in% c("throttle")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_Throttle = mean(PE3_TPS), Sd_Throttle = sd(PE3_TPS))
      
    } else if (input$graphtype1 %in% c("braking")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_Break = mean(BPS_Front), Sd_Break = sd(BPS_Front))
      
      
    } else if (input$graphtype1 %in% c("airfuel")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_Ratio = mean(PE3_LAMBDA), Sd_Ratio = sd(PE3_LAMBDA))
      
    } else if (input$graphtype1 %in% c("oilpressure")) {
      input_data %>%
        filter(Distance >= input$distrange1[1]) %>%
        filter(Distance <= input$distrange1[2]) %>%
        summarise(Ave_Lat_Accel = mean(GPS_LatAcc), Sd_Lat_Accel = sd(GPS_LonAcc))
      
    } 
  })
  
  ##create left summary statistics table for compare data tab
  output$table2 <- renderTable( {
    input_data <- cleanSingleLap(input$upload2$datapath, 1)
    if(input$graphtype2 %in% c("laps")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        group_by(lap) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype2 %in% c("mapspeed")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype2 %in% c("maprpm")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_RPM = mean(PE3_RPM), Sd_RPM = sd(PE3_RPM))
      
    } else if (input$graphtype2 %in% c("throttle")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Throttle = mean(PE3_TPS), Sd_Throttle = sd(PE3_TPS))
      
    } else if (input$graphtype2 %in% c("braking")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Break = mean(BPS_Front), Sd_Break = sd(BPS_Front))
      
      
    } else if (input$graphtype2 %in% c("airfuel")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Ratio = mean(PE3_LAMBDA), Sd_Ratio = sd(PE3_LAMBDA))
      
    } else if (input$graphtype2 %in% c("oilpressure")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Lat_Accel = mean(GPS_LatAcc), Sd_Lat_Accel = sd(GPS_LonAcc))
      
    }
  })
  ##create right summary statistics table for compare data tab 
  output$table3 <- renderTable( {
    input_data <- cleanSingleLap(input$upload3$datapath, 1)
    if(input$graphtype3 %in% c("laps")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        group_by(lap) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype3 %in% c("mapspeed")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Speed = mean(GPS_Speed), Sd_Speed = sd(GPS_Speed))
      
    } else if (input$graphtype3 %in% c("maprpm")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_RPM = mean(PE3_RPM), Sd_RPM = sd(PE3_RPM))
      
    } else if (input$graphtype3 %in% c("throttle")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Throttle = mean(PE3_TPS), Sd_Throttle = sd(PE3_TPS))
      
    } else if (input$graphtype3 %in% c("braking")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Break = mean(BPS_Front), Sd_Break = sd(BPS_Front))
      
      
    } else if (input$graphtype3 %in% c("airfuel")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Ratio = mean(PE3_LAMBDA), Sd_Ratio = sd(PE3_LAMBDA))
      
    }  else if (input$graphtype3 %in% c("oilpressure")) {
      input_data %>%
        filter(Distance >= input$distrange2[1]) %>%
        filter(Distance <= input$distrange2[2]) %>%
        summarise(Ave_Lat_Accel = mean(GPS_LatAcc), Sd_Lat_Accel = sd(GPS_LonAcc))
      
    }
  })
  
  
  
  output$text1 <- renderText({
    if(input$graphtype1 %in% c("laps")) {
      print("This plot displays the speed change over the distance of a single lap. This plot uses a rainbow color
            scheme as a heat map to show changes in speed. Red is the slowest speed and purple is the fastest. This
            graph provides a finer gradient of speed over the lap compared to the 'Map of Lap Speed' plot. This
            graph is most useful for looking at how long it takes to complete a given section of the track.")
      
    } else if (input$graphtype1 %in% c("mapspeed")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The speed is recorded and displayed in miles per hour. This map uses a heat mapping to show
            the change in speed as the driver drives around the track. Dark red is the slowest speed and pale yellow 
            is the fastest.")
      
    } else if (input$graphtype1 %in% c("maprpm")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The RPM is recorded and displayed as engine revolutions per minute. This map 
            uses a heat mapping to show the change in RPM as the driver drives around the track. Dark red 
            is the slowest RPM and pale yellow is the fastest.")
      
    } else if (input$graphtype1 %in% c("throttle")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The throttle pressure is recorded and displayed as a percentage of full throttle. This map 
            uses a heat mapping to show the change in throttle pressure as the driver drives around the track. Dark red 
            is the lowest throttle pressure and pale yellow is the highest.")
      
    } else if (input$graphtype1 %in% c("braking")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The brake pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in brake pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
      
    } else if (input$graphtype1 %in% c("airfuel")) {
      print("This plot displays engine RPM on the x-axis and the ratio of air to fuel in the exhaust on the y-axis.
            The line shows the linear trend of the relationship between these two variables as RPM increases.")
      
    } else if (input$graphtype1 %in% c("oilpressure")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The oil pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in oil pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
    }
  })
  
  output$text2 <- renderText({
    if(input$graphtype2 %in% c("laps")) {
      print("This plot displays the speed change over the distance of a single lap. This plot uses a rainbow color
            scheme as a heat map to show changes in speed. Red is the slowest speed and purple is the fastest. This
            graph provides a finer gradient of speed over the lap compared to the 'Map of Lap Speed' plot. This
            graph is most useful for looking at how long it takes to complete a given section of the track.")
      
    } else if (input$graphtype2 %in% c("mapspeed")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The speed is recorded and displayed in miles per hour. This map uses a heat mapping to show
            the change in speed as the driver drives around the track. Dark red is the slowest speed and pale yellow 
            is the fastest.")
      
    } else if (input$graphtype2 %in% c("maprpm")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The RPM is recorded and displayed as engine revolutions per minute. This map 
            uses a heat mapping to show the change in RPM as the driver drives around the track. Dark red 
            is the slowest RPM and pale yellow is the fastest.")
      
    } else if (input$graphtype2 %in% c("throttle")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The throttle pressure is recorded and displayed as a percentage of full throttle. This map 
            uses a heat mapping to show the change in throttle pressure as the driver drives around the track. Dark red 
            is the lowest throttle pressure and pale yellow is the highest.")
      
    } else if (input$graphtype2 %in% c("braking")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The brake pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in brake pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
      
    } else if (input$graphtype2 %in% c("airfuel")) {
      print("This plot displays engine RPM on the x-axis and the ratio of air to fuel in the exhaust on the y-axis.
            The line shows the linear trend of the relationship between these two variables as RPM increases.")
      
    } else if (input$graphtype2 %in% c("oilpressure")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The oil pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in oil pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
    }
  })
  
  output$text3 <- renderText({
    if(input$graphtype3 %in% c("laps")) {
      print("This plot displays the speed change over the distance of a single lap. This plot uses a rainbow color
            scheme as a heat map to show changes in speed. Red is the slowest speed and purple is the fastest. This
            graph provides a finer gradient of speed over the lap compared to the 'Map of Lap Speed' plot. This
            graph is most useful for looking at how long it takes to complete a given section of the track.")
      
    } else if (input$graphtype3 %in% c("mapspeed")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The speed is recorded and displayed in miles per hour. This map uses a heat mapping to show
            the change in speed as the driver drives around the track. Dark red is the slowest speed and pale yellow 
            is the fastest.")
      
    } else if (input$graphtype3 %in% c("maprpm")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The RPM is recorded and displayed as engine revolutions per minute. This map 
            uses a heat mapping to show the change in RPM as the driver drives around the track. Dark red 
            is the slowest RPM and pale yellow is the fastest.")
      
    } else if (input$graphtype3 %in% c("throttle")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The throttle pressure is recorded and displayed as a percentage of full throttle. This map 
            uses a heat mapping to show the change in throttle pressure as the driver drives around the track. Dark red 
            is the lowest throttle pressure and pale yellow is the highest.")
      
    } else if (input$graphtype3 %in% c("braking")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The brake pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in brake pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
      
    } else if (input$graphtype3 %in% c("airfuel")) {
      print("This plot displays engine RPM on the x-axis and the ratio of air to fuel in the exhaust on the y-axis.
            The line shows the linear trend of the relationship between these two variables as RPM increases.")
      
    } else if (input$graphtype3 %in% c("oilpressure")) {
      print("This plot displays a map of the track by plotting the longitude and latitude points of the car
            on the x and y axes. The oil pressure is recorded and displayed as pounds per square inch. This map 
            uses a heat mapping to show the change in oil pressure as the driver drives around the track. Dark red 
            is the lowest brake pressure and pale yellow is the highest.")
    }
  })
}


shinyApp(ui = ui, server = server)

