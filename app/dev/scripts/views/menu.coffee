BaseView = require("./base.coffee")
$ = require("jquery")
Helper = require("../utils/helper.coffee")
UserModel = require("../models/user.coffee")
###
	MenuView extends from BaseView
	- just rendering the menu
	exports singleton
###
class MenuView extends BaseView
	template: "app/dev/templates/menu.html"
	events:
		# activate menu item after click
		"click a" : (event) -> 
			$("li", @$el).removeClass("active")
			$(event.currentTarget).closest("li").addClass("active")
			if($(event.currentTarget).closest("ul").hasClass("dropdown"))
				$(event.currentTarget).closest("ul").closest("li.has-dropdown").addClass("active")
	initialize: ->
		@$el = $(@regions.menu)
		
	show: () ->
		$(@$el).html(@render(@template, session_id: UserModel.get("session_id")))
		$(document).foundation()
		
module.exports = new MenuView()