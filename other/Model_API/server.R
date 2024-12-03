library(plumber)

serve_model <- plumb("plumber.R")
serve_model$run(port = 8000)
