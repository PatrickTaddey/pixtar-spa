BaseView = require("./base.coffee")
$ = require("jquery")
Helper = require("../utils/helper.coffee")
ActivateModel = require("../models/activate.coffee")
ConfigModel = require("../models/config.coffee")

###
	MenuView extends from BaseView
	- just rendering the menu
	exports singleton
###
class ActivateView extends BaseView
	template: "app/dev/templates/activate.html"
	initialize: ->
		@$el = $(@regions.content)
		
	show: (activation_key) ->
		ActivateModel.save null,
			url: ConfigModel.get("api") + "users/activate.json?activation_key=" + activation_key
			success: (model, response, options) =>
				$(@$el).html(@render(@template, success: true, message: ''))
			error: (model, response, options) =>
				$(@$el).html(@render(@template, success: false, message: response.responseJSON.message))
		
module.exports = new ActivateView()