APP = window.Basketball ?= {}

class APP.NewsView
  constructor: (news_items) ->
    container = $("section[role='main']")

    # Remove the placeholder text and replace it using the news template
    placeholder = $("#news-placeholder")
    placeholder.remove()

    template = $("#news-template").text()

    output = Mustache.render(template, {news: news_items})
    container.append(output)
