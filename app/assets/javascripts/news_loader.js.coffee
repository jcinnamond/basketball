APP = window.Basketball ?= {}

class APP.NewsLoader
  load: (parentId, teamId) ->
    jQuery.ajax("/leagues/#{parentId}/teams/#{teamId}/news").done( (data) ->
      news = []
      news.push(new APP.NewsItem(params)) for params in data
      APP.NewsList.setNews(news)
    )
