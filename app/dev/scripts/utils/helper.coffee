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

	initialize_datepicker: (input_name) ->
		min_date = moment().format("DD.MM.YYYY")
		element = $("input[name=" + input_name + "]")[0]
		$("input[name=" + input_name + "]").val(min_date)
		picker = new Pikaday(
			field: element
			format: 'DD.MM.YYYY'
			#minDate: moment(min_date,  'DD.MM.YYYY').toDate()
			maxDate: moment("01.01.2015",  'DD.MM.YYYY').toDate()
			firstDay:1
			i18n:
				previousMonth : '',
				nextMonth     : '',
				months        : ['Januar','Februar','März','April','Mai','Juni','Juli','August','September','Oktober','November','Dezember'],
				weekdays      : ['Sonntag','Montag','Dienstag','Mittwoch','Donnerstag','Freitag','Samstag'],
				weekdaysShort : ['So','Mo','Di','Mi','Do','Fr','Sa']
		).setDate(min_date)

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