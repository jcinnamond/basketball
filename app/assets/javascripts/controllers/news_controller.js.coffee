APP = window.Basketball ?= {}

class APP.NewsController
  setTeamName: (name) ->

  setNews: (news_items) ->
    $("#news-list").remove()
    new APP.NewsView(news_items)

