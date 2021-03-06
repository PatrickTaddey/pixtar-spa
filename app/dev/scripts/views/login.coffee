BaseView = require("./base.coffee")
LoginModel = require("../models/login.coffee")
Helper = require("../utils/helper.coffee")
User = require("../models/user.coffee")
$ = require("jquery")
Backbone = require("backbone")
require("backbone-validator")
require("jquery-serialize-object")

###
	LoginView extends from BaseView
	- used for sending contact messages
	- validation of the contact form
	exports singleton
###
class LoginView extends BaseView
	template: "app/dev/templates/login.html"
	events: 
		"click .close-alert": (event) ->
			event.preventDefault()
			$(".alert-box").addClass("hide")
			
		"submit #js-login-form": (event) ->
			event.preventDefault()
			LoginModel.set($('form').serializeObject())
			return if !LoginModel.isValid()
			LoginModel.save null,
				success: (model, response, options) =>
					$("form")[0].reset()
					User.set(
						"session_id": model.get("session_id")
						"username": model.get("username")
					)
					$.cookie("CAKEPHP", User.get("session_id"))
					window.location.href = ""

				error: (model, response, options) =>
					Helper.show_alert("warning", response.responseJSON.message)

		"blur .js-form-field": (event) ->
			name = $(event.target).attr("name")
			value = $(event.target).val()
			LoginModel.set(name, value).validate(name)

	initialize: ->
		@$el = $(@regions.content)
		@bindValidation(LoginModel)

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

module.exports = new LoginView()