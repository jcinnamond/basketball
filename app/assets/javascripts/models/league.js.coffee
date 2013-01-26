APP = window.Basketball ?= {}

class APP.League
  constructor: (params) ->
    @name = params.name
    @shortName = params.short_name
    @abbreviation = params.abbreviation
    @teams = []
    @teams.push(new APP.Team(@abbreviation, team_data)) for team_data in params.teams
