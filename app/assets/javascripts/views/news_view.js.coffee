APP = window.Basketball ?= {}

class APP.NewsView
  constructor: (news_items) ->
    container = $("section[role='main']")

    # Clear the placeholder text but don't remove it because it will
    # be used again if the team changes
    $("#news-placeholder").text("")

    template = $("#news-template").text()

    output = Mustache.render(template, {news: news_items})
    container.append(output)
