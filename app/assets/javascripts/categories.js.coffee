# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@CategoryPoller =
  poll: ->
    setTimeout @request, 500
  request: ->
    status_div = $('#job-status')
    if status_div.attr('data-job_id')? 
      $.get(status_div.attr('data-url') + status_div.attr('data-job_id'))