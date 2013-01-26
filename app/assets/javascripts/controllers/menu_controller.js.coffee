APP = window.Basketball ?= {}

class APP.MenuController
  constructor: ->
    news_loader = new APP.NewsLoader()
    jQuery(".team-link").click( (event)->
      event.preventDefault()
      target = event.target
      parentId = $(target).attr("data-parent-id")
      teamId = $(target).attr("data-id")

      news_loader.load(parentId, teamId)
      APP.NewsList.setTeamName(target.text)
    )

