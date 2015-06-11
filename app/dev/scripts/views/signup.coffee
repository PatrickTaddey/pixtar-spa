BaseView = require("./base.coffee")
SignupModel = require("../models/signup.coffee")
Helper = require("../utils/helper.coffee")

$ = require("jquery")
Backbone = require("backbone")
require("backbone-validator")
require("jquery-serialize-object")

###
	SignupView extends from BaseView
	- used for sending contact messages
	- validation of the contact form
	exports singleton
###
class SignupView extends BaseView
	template: "app/dev/templates/signup.html"
	events: 
		"click .close-alert": (event) ->
			event.preventDefault()
			$(".alert-box").addClass("hide")
			
		"submit #js-form": (event) ->
			event.preventDefault()
			SignupModel.set($('form').serializeObject())
			return if !SignupModel.isValid()
			SignupModel.save null,
				success: (model, response, options) =>
					Helper.show_alert("success", @gettext("Danke. Eine E-Mail ist zu dir unterwegs."))
					$("form")[0].reset()
					setTimeout ( ->
						window.location.href = ""
					), 3000					

				error: (model, response, options) =>
					Helper.show_alert("warning", response.responseJSON.message)

		"blur .js-form-field": (event) ->
			name = $(event.target).attr("name")
			value = $(event.target).val()
			SignupModel.set(name, value).validate(name)

	initialize: ->
		@$el = $(@regions.content)
		@bindValidation(SignupModel)

	show: () ->
		$(@$el).html(@render(@template))
		@position_footer()

	onValidField: (attrName, attrValue, model) ->
		element = $('[name=' + attrName + ']')
		element.parent().removeClass("error")
		element.parent().next("small").addClass("hide")

	onInvalidField: (attrName, attrValue, errors, model) ->
		element = $('[name=' + attrName + ']')
		element.parent().addClass("error")
		element.parent().next("small").html(errors).removeClass("hide")

module.exports = new SignupView()