## ui.R ##
library(shinydashboard)

shinyUI(dashboardPage(
  skin = "green",
  dashboardHeader(title = "Yelp Yep"),
  dashboardSidebar(
    sidebarMenu(id = "sideBarMenu",
                menuItem("ReadMe", tabName = "readme", icon = icon("mortar-board"), selected=TRUE
                ),
                menuItem("Charts", tabName = "charts", icon = icon("bar-chart")
                ),
                menuItem("Hipster", tabName = "hips", icon = icon("paint-brush")),
                menuItem("Summary", tabName = 'summary', icon = icon('newspaper-o')),
                menuItem("Maps", tabName = "maps", icon = icon("map-marker"),
                         menuSubItem("Distribution", tabName = 'mp1'),
                         menuSubItem("Density", tabName = 'mp2')),
                menuItem("Source code", icon = icon('file-text-o'),
                         menuSubItem("ui.R", tabName = 'ui'),
                         menuSubItem("server.R", tabName = 'server')
                         ),
                menuItem("Github",icon = icon("github"),
                         badgeLabel = "Like", badgeColor = "green",
                         href = "https://github.com/casunlight"),
                hr(),
                conditionalPanel("input.sideBarMenu == 'hips'",
                                 fluidRow(
                                   column(1),
                                   column(10,
                                 radioButtons(inputId = 'hp.at',
                                              label = 'Hipster VS. Attributes',
                                              choices = hp_col,
                                              selected = NULL)))
                ))),
  
  dashboardBody(
    tabItems(
      tabItem(tabName = "mp1",
              h2("Fancy map content"),
              fluidRow(
                column(8, leafletOutput("map1", height = 450, width = 800))
              )),
      tabItem(tabName = "mp2",
              h2("Fancy map content"),
              fluidRow(
                column(8, plotOutput("map2", height = 450, width = 800))
              )),
      
      tabItem(tabName = "charts",
              
              fluidRow(
                column(4, sliderInput("num_cat", "More categories to show:",
                                      1, 100, 25)),
                column(7, 
                       selectizeInput(inputId = 'attributes',
                                      label = 'Select Categories',
                                      choices = attri_col,
                                      selected = 'attributes.Ambience.hipster'))
              ),
              
              fluidRow(plotOutput("chart1", height = 400, width = 800))
      ),
      
      tabItem(tabName = "hips",
              fluidRow(box(
                title = "Hello Hipsters ~", status = "primary",
                height = 180, width = 25,
                plotOutput("hist1", height = 450, width = 800)
              ))),
      
      tabItem(tabName = "summary",
              fluidRow(downloadButton('downloadTable', 'Download')),
              hr(),
              fluidRow(dataTableOutput("table"))
      ),
      
      tabItem(tabName = "readme",
              includeMarkdown("README.md")
      ),
      tabItem(tabName = "ui",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="ui.R",
                   downloadButton('downloadData1', 'Download'),
                   br(),br(),
                   pre(includeText("ui.R"))
              )
      ),
      tabItem(tabName = "server",
              box( width = NULL, status = "primary", solidHeader = TRUE, title="server.R",
                   downloadButton('downloadData2', 'Download'),
                   br(),br(),
                   pre(includeText("server.R"))
              )
      )
    )
  )
)
)




