APP = window.Basketball ?= {}

class APP.NewsController
  setTeamName: (name) ->
    $("#team-name").text(name)
    $("#news-list").remove()
    $("#news-placeholder").text("Loading news...")

  setNews: (news_items) ->
    new APP.NewsView(news_items)

