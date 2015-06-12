$ = require("jquery")
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
	show: (page) =>
		if page?
			ImagesCollection.url = ConfigModel.get("api") + "images.json?page=" + page
		ImagesCollection.fetch
			success: (collection, response, options) =>
				$(@regions.content).html @render @template, 
					collection: collection.models, 
					image_url: ConfigModel.get("api") + "images/"
					pagination: ImagesCollection.pagination

				$(document).foundation
					equalizer:
						equalize_on_stack: true
				@position_footer()


module.exports = new ImageListView()