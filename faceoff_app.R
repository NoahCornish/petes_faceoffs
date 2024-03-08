#shinyapp


# Load and prepare the data ---
# Note: For a Shiny app, it's better to load and prepare data outside the server function if the data does not change based on user input.
# However, gs4_auth() requires interactive authentication which can't be done in a deployed Shiny app.
# You might need to use a service account for authentication or preload the data.

# app.R

library(shiny)
library(DT) 
source("faceoff_code.R")


ui <- fluidPage(
  titlePanel("FACEOFF TRACKING BETA"),
  # Instructions for users to refresh the page for updated data
  HTML("<p>To see the most recent data, please <strong>refresh</strong> the page.</p>"),
  DTOutput("win_loss_table")
)


server <- function(input, output, session) {
  
  source("faceoff_code.R")
  
  output$win_loss_table <- renderDT({
    # Assuming 'player_win_loss' is your data frame
    datatable(player_win_loss, 
              options = list(pageLength = nrow(player_win_loss), 
                             searching = FALSE, 
                             paging = FALSE, # Disables pagination
                             autoWidth = TRUE),
              fillContainer = FALSE) # Adjusts the table width to the content
  })
}

shinyApp(ui = ui, server = server)

