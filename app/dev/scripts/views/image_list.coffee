$ = require("jquery")
Backbone = require("backbone")
BaseView = require("./base.coffee")
ImagesCollection = require("../collections/images.coffee")
ConfigModel = require("../models/config.coffee")

###
	ContentView extends from BaseView
	shares base functionality like 
	- rendering main content template files
	exports singleton
###
class ImageListView extends BaseView
	template: "app/dev/templates/main.html"
	events:
		"keypress #js-filter-form" : (event) ->
			value = $(event.currentTarget).val()
			if event.which is 13 and value.length > 2
				Backbone.history.navigate("images/filter/" + value, trigger:true)

	initialize: ->
		@$el = $(@regions.content)

	show: (page, filter) =>		
		ImagesCollection.fetch
			url: ImagesCollection.url(page, filter)
			success: (collection, response, options) =>
				$(@$el).html @render @template, 
					collection: collection.models
					image_url: ConfigModel.get("api") + "images/"
					pagination: ImagesCollection.pagination
					filter: filter

				$(document).foundation
					equalizer:
						equalize_on_stack: true
				@position_footer()


module.exports = new ImageListView()