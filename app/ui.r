## Used libraries
    library(shiny)
    library(shiny.router)
    library(shinydashboard)
    library(dashboardthemes)
    library(shinyBS)
    library(shinyjs)
    library(htmltools)
    library(DT)
    xfun::session_info('DT')

## creating custom theme object
  customTheme <- shinyDashboardThemeDIY(

    ### general
    appFontFamily = "Arial"
    ,appFontColor = "rgb(0,0,0)"
    ,primaryFontColor = "rgb(0,0,0)"
    ,infoFontColor = "rgb(0,0,0)"
    ,successFontColor = "rgb(0,0,0)"
    ,warningFontColor = "rgb(0,0,0)"
    ,dangerFontColor = "rgb(0,0,0)"
    ,bodyBackColor = "rgb(250,250,250)"

    ### header
    ,logoBackColor = "rgb(35, 35, 35)"

    ,headerButtonBackColor = "rgb(68, 68, 68)"
    ,headerButtonIconColor = "rgb(255,255,255)"
    ,headerButtonBackColorHover = "rgb(210,210,210)"
    ,headerButtonIconColorHover = "rgb(0,0,0)"

    ,headerBackColor = "rgb(68, 68, 68)"
    ,headerBoxShadowColor = "#aaaaaa"
    ,headerBoxShadowSize = "2px 2px 2px"

    ### sidebar
    ,sidebarBackColor = cssGradientThreeColors(
      direction = "down"
      ,colorStart = "rgb(68, 68, 68)"
      ,colorMiddle = "rgb(68, 68, 68)"
      ,colorEnd = "rgb(68, 68, 68)"
      ,colorStartPos = 0
      ,colorMiddlePos = 50
      ,colorEndPos = 100
    )
    ,sidebarPadding = 0

    ,sidebarMenuBackColor = "transparent"
    ,sidebarMenuPadding = 0
    ,sidebarMenuBorderRadius = 0

    ,sidebarShadowRadius = "3px 5px 5px"
    ,sidebarShadowColor = "#aaaaaa"

    ,sidebarUserTextColor = "rgb(255,255,255)"

    ,sidebarSearchBackColor = "rgb(55,72,80)"
    ,sidebarSearchIconColor = "rgb(153,153,153)"
    ,sidebarSearchBorderColor = "rgb(55,72,80)"

    ,sidebarTabTextColor = "rgb(255,255,255)"
    ,sidebarTabTextSize = 13
    ,sidebarTabBorderStyle = "none none solid none"
    ,sidebarTabBorderColor = "rgb(0, 0, 0)"
    ,sidebarTabBorderWidth = 1

    ,sidebarTabBackColorSelected = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgb(96, 96, 96)"
      ,colorMiddle = "rgb(96, 96, 96)"
      ,colorEnd = "rgb(96, 96, 96)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorSelected = "rgb(255,255,255)"
    ,sidebarTabRadiusSelected = "0px 0px 0px 0px"

    ,sidebarTabBackColorHover = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgb(96, 96, 96)"
      ,colorMiddle = "rgb(96, 96, 96)"
      ,colorEnd = "rgb(96, 96, 96)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorHover = "rgb(255, 255, 255)"
    ,sidebarTabBorderStyleHover = "none none solid none"
    ,sidebarTabBorderColorHover = "rgb(0, 0, 0)"
    ,sidebarTabBorderWidthHover = 1
    ,sidebarTabRadiusHover = "0px 15px 15px 0px"

    ### boxes
    ,boxBackColor = "rgb(255,255,255)"
    ,boxBorderRadius = 5
    ,boxShadowSize = "0px 1px 1px"
    ,boxShadowColor = "rgba(0,0,0,.1)"
    ,boxTitleSize = 16
    ,boxDefaultColor = "rgb(210,214,220)"
    ,boxPrimaryColor = "rgba(44,222,235,1)"
    ,boxInfoColor = "rgb(210,214,220)"
    ,boxSuccessColor = "rgba(0,255,213,1)"
    ,boxWarningColor = "rgb(244,156,104)"
    ,boxDangerColor = "rgb(255,88,55)"

    ,tabBoxTabColor = "rgb(255,255,255)"
    ,tabBoxTabTextSize = 14
    ,tabBoxTabTextColor = "rgb(0,0,0)"
    ,tabBoxTabTextColorSelected = "rgb(0,0,0)"
    ,tabBoxBackColor = "rgb(255,255,255)"
    ,tabBoxHighlightColor = "rgba(44,222,235,1)"
    ,tabBoxBorderRadius = 5

    ### inputs
    ,buttonBackColor = "rgb(12,89,207)"
    ,buttonTextColor = "rgb(250,250,250)"
    ,buttonBorderColor = "rgb(0,0,0)"
    ,buttonBorderRadius = 5

    ,buttonBackColorHover = "rgb(0,150,255)"
    ,buttonTextColorHover = "rgb(250,250,250)"
    ,buttonBorderColorHover = "rgb(0,0,0)"

    ,textboxBackColor = "rgb(255,255,255)"
    ,textboxBorderColor = "rgb(200,200,200)"
    ,textboxBorderRadius = 5
    ,textboxBackColorSelect = "rgb(245,245,245)"
    ,textboxBorderColorSelect = "rgb(200,200,200)"

    ### tables
    ,tableBackColor = "rgb(255, 255, 255)"
    ,tableBorderColor = "rgb(240, 240, 240)"
    ,tableBorderTopSize = 2
    ,tableBorderRowSize = 2

  )


  





## shiny ui
  ui <- shinyUI(
    dashboardPage(
    
      dashboardHeader(
        title = 'BENCHMARKS'
      ),
      dashboardSidebar(
        sidebarMenu(
          menuItem("About", icon = icon("info"), href = route_link('about'), newtab = FALSE),
          menuItem("Benchmarks", icon = icon("tachometer"), href = route_link('benchmarks'), newtab = FALSE),
          menuItem("Scenarios", icon = icon("folder"), href = route_link('scenarios'), newtab = FALSE),
          menuItem("Instances", icon = icon("cubes"), href = route_link('instances'), newtab = FALSE),
          menuItem("Parameters", icon = icon("wrench"), href = route_link('parameters'), newtab = FALSE),
          menuItem("Targets", icon = icon("terminal"), href = route_link('targets'), newtab = FALSE)
        )
      ),
      dashboardBody(

        customTheme,
        router_ui()
      )
    )
  )