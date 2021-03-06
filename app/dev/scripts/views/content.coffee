$ = require("jquery")
BaseView = require("./base.coffee")

###
	ContentView extends from BaseView
	shares base functionality like 
	- rendering main content template files
	exports singleton
###
class ContentView extends BaseView
	template_path: "app/dev/templates/"

	show: (template) ->
		$(@regions.content).html @render(@template_path + template)
		@position_footer()

module.exports = new ContentView()