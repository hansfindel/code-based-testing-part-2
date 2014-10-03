# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
	$('#code_name').hide()
	$('#robot_code_name_id').change ->
		if $(this).val() == "0"
			$('#code_name').show()
		else
			$('#code_name').hide()
