# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
	$('form').on 'click', '#code_name_link', (event) ->
		$("#code_name_id_select").hide()
		$(this).text("Select an existing Code Name")
		$(this).attr("id","select_codename_link")

	$('form').on 'click', '#select_codename_link', (event) ->
		$("#code_name_fields_form").remove()
		$("#code_name_id_select").show()
		$(this).text("Add a Code Name")
		$(this).attr("id","code_name_link")
		event.stopImmediatePropagation()

$(document).ready(ready)
$(document).on('page:load', ready)