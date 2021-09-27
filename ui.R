## Define UI ----
shinyUI(
  fluidPage(
    h2('Qui est volontaire ?!'),

    fluidRow(
      column(width = 12, align = 'center',
             img(src = 'dice.png',
                 height = 60,
                 width = 90)
            ,
             img(src = 'logo_universite-lille.png',
                 height = 50,
                 width = 100))
    ),

    fluidRow(
      column(width = 12, align = 'center',
             h4('Plan de classe :'),
             h6(
'Porte < - - - - - - - - - - - - - - | Tableau | - - - - - - - - - - - - - - > Fenêtre'),
             tableOutput('table'),
             h6('Fond de classe')
             )
    )
  )
)
