$ ->
  if $('article').length
    new ScrollTitle()

class ScrollTitle
  constructor: ->
    @default_title = document.title
    @updateTitle()
    $(window).scroll(@updateTitle)

  updateTitle: =>
    y = $(window).scrollTop()
    title = ''
    $("article").each ->
      pos = $(@).position()
      top = pos.top
      return false if top > y + window.innerHeight
      title = $(@).find('h1').text()
      return false if top > y
    title or= @default_title
    document.title = title
