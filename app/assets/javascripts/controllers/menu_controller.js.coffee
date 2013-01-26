APP = window.Basketball ?= {}

class APP.MenuController
  constructor: ->
    @nav = $("nav")
    @news = $("section")

    news_loader = new APP.NewsLoader()
    $(".team-link").click( (event) =>
      event.preventDefault()
      target = event.target
      parentId = $(target).attr("data-parent-id")
      teamId = $(target).attr("data-id")

      news_loader.load(parentId, teamId)
      APP.NewsList.setTeamName(target.text)

      @nav.addClass("hide-for-small")
      @news.removeClass("hide-for-small")
    )

    $("#mobile-select-team").click( () =>
      @nav.removeClass("hide-for-small")
      @main.addClass("hide-for-small")
    )


