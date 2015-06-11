_ = require("underscore")
BaseView = require("./base.coffee")
ImageModel = require("../models/image.coffee")
Helper = require("../utils/helper.coffee")
ImagesCollection = require("../collections/images.coffee")

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
	template: "app/dev/templates/image.html"
	events: 
		"change input[type=file]" : "upload"
		"click .close-alert": (event) ->
			event.preventDefault()
			$(".alert-box").addClass("hide")
			
		"submit #js-form": (event) ->
			event.preventDefault()
			ImageModel.set
				"description": $('#description').val()
				"image": $('#image').val()
			return if !ImageModel.isValid()
			
			ImageModel.save null,
				success: (model, response, options) =>
					$("form")[0].reset()

					# refresh images collection
					ImagesCollection.fetch
						success: (model, response, options) =>
							Backbone.history.navigate("", trigger:true)
				error: (model, response, options) =>
					Helper.show_alert("warning", response.responseJSON.message)

	initialize: ->
		@$el = $(@regions.content)
		@bindValidation(ImageModel)

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
	upload : (event) ->
		files = event.target.files
		_.each(files, (element, index, list) =>
			imageReader = new FileReader()
			imageReader.onload = ((file) =>
				if file.type.toLowerCase() in ["image/jpeg", "image/jpg"] 
					(e) =>
						ImageModel.set(
							"file_content" : e.target.result
							"mime_type" : file.type
							"name" : file.name
						) 
						console.log ImageModel
						# todo: preview $("#js-preview-image").css("background-image", "url(" + e.target.result + ")")
				else
					ImageModel.unset("image")
					$("#image").val("")
					@onInvalidField("image", "", "Es sind nur JPEGs erlaubt.")

			)(element)

			imageReader.readAsDataURL(element)
		)


module.exports = new SignupView()