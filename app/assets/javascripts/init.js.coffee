APP = window.Basketball ?= {}

$(document).ready ->
  new APP.TeamsLoader()
  APP.NewsList = new APP.NewsController
