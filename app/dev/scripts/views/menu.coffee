BaseView = require("./base.coffee")
$ = require("jquery")
Helper = require("../utils/helper.coffee")

###
	MenuView extends from BaseView
	- just rendering the menu
	exports singleton
###
class MenuView extends BaseView
	site: null
	template: "app/dev/templates/menu.html"
	initialize: ->
		@$el = $(@regions.menu)
		
	show: () ->
		$(@$el).html(@render(@template))
		$(document).foundation()
		
module.exports = new MenuView()