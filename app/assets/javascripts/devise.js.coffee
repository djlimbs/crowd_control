# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
	$('#guest').hide()
	$('#guestType').change ->
		if $('#guestType').val() == "guest"
			$( "#dj_couple").hide()
			$( "#guest").fadeIn()
		else
			$( "#dj_couple").fadeIn()
			$( "#guest").hide()