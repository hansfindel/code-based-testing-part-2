# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

start = ->
	$('#code_name').hide()
	$('#robot_code_name_id').change ->
		if $(this).val() == "-1"
			$('#code_name').show()
		else
			$('#code_name').hide()


# On turbolinked page loads:
$(document).on('page:load ready', start)