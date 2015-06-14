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
	url: (page, filter) ->
		url = ConfigModel.get("api") + "images.json"
		url += "?page="+page if page?

		if filter?
			url += if page? then "&filter="+filter else "?filter="+filter

		return url
	parse : (response) ->
		@pagination = response.pagination
		return response.data

module.exports = new ImagesCollection()