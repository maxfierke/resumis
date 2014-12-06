# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ($) ->
  "use strict"
  resumis =
    populateLatestProject: ->
      $lp = $("#latest-project")
      if $lp.length > 0
        $.get "/projects.json", (data) ->
          proj = data[0]
          $lp.find(".project-title a").text(proj.name).prop "href", "/projects/#project_" + proj.id
          $lp.find(".project-shortdesc").text proj.short_description
    init: ->
      resumis.populateLatestProject()

  resumis.init()
