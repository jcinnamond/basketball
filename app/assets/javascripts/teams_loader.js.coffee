APP = window.Basketball ?= {}

class APP.TeamsLoader
  constructor: ->
    jQuery.ajax("/teams").done( (data) ->
      leagues = []
      leagues.push(new APP.League(params)) for params in data
      new APP.MenuView(leagues)
    )
