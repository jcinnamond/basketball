APP = window.Basketball ?= {}

class APP.NewsItem
  constructor: (params) ->
    @headline = params.headline
    @description = params.description
    images = params.images
    if images.length > 0
      @image = "#{images[0].url}"
