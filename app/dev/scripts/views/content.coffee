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
class ContentView extends BaseView
	template_path: "app/dev/templates/"

	show: (template) ->
		$(@regions.content).html @render(@template_path + template, images_collection: ImagesCollection.models, image_url: ConfigModel.get("api") + "images/")

		@position_footer()
		$(document).foundation
			equalizer:
				equalize_on_stack: true

module.exports = new ContentView()