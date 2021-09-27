library(shiny)
require(tidyverse)
options(browser = "firefox")

tb = NULL

vide <-  '. . . . . . . .'
present <- '---___---'
choisi <- '¯\\_(ツ)_/¯'

seat_row_width <- 6L
seat_row_number <- 5L
empty_seats <- list(
  ## c(5L,2L),
##  c(5L,3L),
##  c(5L,4L),
##  c(5L,5L),
##  c(5L,6L),
##  c(1L,5L)
)

empty_seats_as_numbers <- map_dbl(empty_seats, function(seat ){
  row <- seat[1]
  col <- seat[2]
  (row - 1) * seat_row_width + col
}
)

students_as_numbers <- as.character(setdiff(1:(seat_row_number*seat_row_width), empty_seats_as_numbers))


construct_matrix <- function() {
  map(1:seat_row_number, function (row) {
    map(1:seat_row_width, function (col) {
      student <- (row - 1) * seat_row_width + col
      if(student %in% empty_seats_as_numbers) {
        vide
      }
      else {
        present
      }
    })
  }) %>% unlist %>% matrix(ncol = seat_row_width, byrow = T)
}




compute_tibble <- function() {

  mx <- construct_matrix()

  tire_au_sort <- function() {
    r_raw <- runif(1) * seat_row_number + 1
    c_raw <- runif(1) * seat_row_width + 1
    r <- floor(r_raw)
    c <- floor(c_raw)
    if (mx[r, c] == vide) tire_au_sort()
    else {
      print(str_c(r_raw, ' - ', c_raw))
      mx[r,c] <<- choisi
    }
  }
  tire_au_sort()
  colnames(mx) <- 1:6
  tb <<- as_tibble(mx)
}

## Define server logic ----
shinyServer(function(input, output) {

  ## set.seed(as.numeric(Sys.time()))
  compute_tibble()

  output$table <- renderTable(
    tb,
    colnames = F,
    bordered = T,
    striped = T
  )
})
