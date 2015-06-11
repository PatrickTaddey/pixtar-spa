BaseView = require("./base.coffee")
Helper = require("../utils/helper.coffee")

###
	FooterView extends from BaseView
	- just rendering the footer
	exports singleton
###
class FooterView extends BaseView
	template: "app/dev/templates/footer.html"
	show: () ->
		window.jQuery(@regions.footer).html(@render(@template))
		
module.exports = new FooterView()