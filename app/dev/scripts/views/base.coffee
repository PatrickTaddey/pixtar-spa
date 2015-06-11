Backbone = require("backbone")
i18n = require("../utils/i18n.coffee")
Helper = require("../utils/helper.coffee")

###
	BaseView extends from Backbone.View
	shares base functionality like 
	- rendering template files
	- positioning the footer
	- gettext translation
###
class BaseView extends Backbone.View
	regions:
		menu: "#js-menu-region"
		content: "#js-content-region"
		footer: "#js-footer-region"
	render:(template, context) ->
		i18n.render(template, context)
	position_footer:() ->
		Helper.position_footer()
	gettext:(string) ->
		i18n.gettext(string)
module.exports = BaseView