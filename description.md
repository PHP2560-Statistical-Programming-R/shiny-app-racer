# Add description as well as the break down of work to be done by group. 

Use of app:

Our app uses .csv data that is exported from racestudio2. The data is collected from live telemetry instruments on the Brown Formula Racing car. The app is useful because it allows the raw data to be converted quickly into common race analysis graphs. The app can be used to assist with driver training as well as diagnose certain car problems. The compare feature allows comparisons between drivers as well as comparisons of different variables from a single lap. For example, the app could be used to compare what happens to oil pressure as the car breaks around a certain corner.    

Creation process:

We created this app to be an easy to use and simple interface for our R package, racecar. In creating this app, we first designed the layout of the app and allocated spaces for each input and output feature using commands like fluidPage, fluidRow, and column. We then worked individually to add functionality to each of the features presented in our app. After all of our features were working nicely, we decided to add style by choosing and implementing a color scheme. We chose a black background because after doing research, we learned that a black background is the industry standard for looking at racecar plots.

Individual roles:

# Blain:
- Helped design the layout of the app
- Added summary statistics table to each graph
- Added the distance selector that zooms into specific parts of the track 
- Helped decide which graphs to create from textbook

# Fuyu:
- Helped design the layout of the app
- Helped write the code in graph output
- added renderplotly and verbatimTextOutput code to shiny app
- added legends and titles to plots

# Jess: 
- Helped design and implement the layout of the app
- added the two-tab functionality to look at one or two sets of data
- added css code to style app
- helped implement upload .csv feature
- added descriptions for all graphs
- added "About" tab to app

---------------------------------

Before running this app verify that you have the following packages installed and loaded into R. If you need to install or load any of these packages, run the following commands for the packages that you are missing. 

install.packages("shiny")

install.packages("tidyverse")

install.packages("shinythemes")

install.packages("plotly")

library(shiny)

library(tidyverse)

library(shinythemes)

library(plotly)

You will also need to install our R package, racecar which can be found at https://github.com/PHP2560-Statistical-Programming-R/shiny-app-racer

- download our repository: 
https://github.com/PHP2560-Statistical-Programming-R/r-package-racecar/tree/master/racecar%20files
- run the code: "install.package("racecar", type = "source", repos = NULL)"


