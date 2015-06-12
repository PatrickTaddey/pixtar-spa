$ = require("jquery")
Backbone = require("backbone")
Backbone.$ = $
ConfigModel = require("../models/config.coffee")

###
	ImagesCollection extends from Backbone.Collection
	exports singleton
###
class ImagesCollection extends Backbone.Collection
	pagination:{}
	url: () ->
		ConfigModel.get("api") + "images.json"
	parse : (response) ->
		@pagination = response.pagination
		return response.data

module.exports = new ImagesCollection()