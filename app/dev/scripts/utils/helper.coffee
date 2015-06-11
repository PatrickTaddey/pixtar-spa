$ = require("jquery")
Backbone = require("backbone")
_ = require("underscore")
moment = require("moment")
Pikaday = require('pikaday')

###
	class Helper 
	- position footer and jump to top
	- show alert messages in the contact form
	- get site to display the logo in menu
	- handle routing - set active element in menu
	exports singleton
###
class Helper

	# set csrftoken in request header
	set_csrftoken:(csrftoken) ->
		$.ajaxPrefilter (options, originalOptions, jqXHR) ->
			jqXHR.setRequestHeader("x-csrf-token", csrftoken)

	# position footer and jump to top
	position_footer:()->
		window_height = $(window).height()
		wrapper_height = $(".wrapper").height()
		buffer_height = window_height - wrapper_height + 39
		if window_height > wrapper_height
			$(".content-area").css("padding-bottom", buffer_height + "px")
		$(window).scrollTop(0)

	# show alert messages in the contact form
	show_alert:(alert_class, alert_message)->
		$(".alert-box").removeClass("hide")
		.addClass(alert_class)
		.find(".js-alert-message").text(alert_message)
		$(document).foundation('alert', 'reflow')

	# handle routing - set active element in menu
	handle_routing:(route, params) ->
		$("nav li").removeClass("active")
		element = $('a[href~="#' + route.split('(')[0] + '"]')
		element.parent().addClass("active")
		if element.closest("ul").hasClass("dropdown")
			element.closest("li.has-dropdown").addClass("active")

	scroll_top : () ->
		$(window).scroll () ->
			if $(this).scrollTop() > 100
				$("#scroll_top").fadeIn()
			else 
				$("#scroll_top").fadeOut()

		$("#scroll_top").on "click", (event) ->			
			event.preventDefault()
			$("body, html").animate(scrollTop : 0, 800)

module.exports = new Helper()