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
      pos = $(@).offset()
      top = pos.top
      bottom = top + $(@).height()
      # console.log top
      if y > top - 300 and y < bottom - 300
        title = $(@).find('h1').text()
        # return false if title # break
    title or= @default_title
    document.title = title
