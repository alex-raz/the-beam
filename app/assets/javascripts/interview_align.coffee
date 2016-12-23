
alignInterview = ->
  elements = []
  max = 0

  # find all interview
  $('.interview').each (i) ->
    body = $('.interview__body', this).first()
    elements.push(body) if body

  # calculate max height of interviews
  elements.forEach (el) ->
    el.removeAttr('style')
    body_height = el.height()
    max = body_height if body_height > max

  # set max height to all the interviews
  elements.forEach (el) ->
    el.height(max)


$(document).on 'ready turbolinks:load', ->
  alignInterview()

$(window).on 'resize', ->
  clearTimeout(tout) if tout?

  tout = setTimeout ->
    alignInterview()
  , 500
