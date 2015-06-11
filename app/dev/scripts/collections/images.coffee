$ = require("jquery")
Backbone = require("backbone")
Backbone.$ = $
ConfigModel = require("../models/config.coffee")

###
	ImagesCollection extends from Backbone.Collection
	exports singleton
###
class ImagesCollection extends Backbone.Collection
	url: () ->
		ConfigModel.get("api") + "images.json"
	parse : (response) ->
		return response.data

module.exports = new ImagesCollection()