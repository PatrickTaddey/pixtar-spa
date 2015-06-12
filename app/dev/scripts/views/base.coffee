Backbone = require("backbone")
window.jQuery = require("jquery")

i18n = require("../utils/i18n.coffee")
Helper = require("../utils/helper.coffee")

# we need to require the precompiled nunjucks templates
templates = require("../../templates/templates.js")

# export window.Modernizr - dependency for foundation
window.Modernizr = require('browsernizr2')

# export window.Foundation
foundation = require("foundation")

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