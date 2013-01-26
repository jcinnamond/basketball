APP = window.Basketball ?= {}

class APP.Team
  constructor: (@parentId, params) ->
    @name = params.name
    @id = params.id
