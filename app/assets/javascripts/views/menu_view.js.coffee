APP = window.Basketball ?= {}

class APP.MenuView
  constructor: (leagues) ->
    container = $("nav")

    # Remove the placeholder text and replace it using the menu template
    placeholder = $("#menu-placeholder")
    placeholder.remove()

    template = $("#menu-template").text()

    output = Mustache.render(template, {leagues: leagues})
    container.append(output)
