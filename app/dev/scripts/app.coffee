Backbone = require("backbone")
Backbone.$ = require("jquery")
require("backbone.routefilter")
Helper = require("./utils/helper.coffee")
# require views
MenuView = require("./views/menu.coffee")
FooterView = require("./views/footer.coffee")
ContentView = require("./views/content.coffee")
SignupView = require("./views/signup.coffee")
LoginView = require("./views/login.coffee")
ActivateView = require("./views/activate.coffee")

UserModel = require("./models/user.coffee")
ImagesCollection = require("./collections/images.coffee")

###
	AppRouter extends from Backbone.Router
	- fetch ProfileModel in initializer
	- handle routing
	- display views
	exports a singleton
###
class AppRouter extends Backbone.Router
	routes :
		"" : "index"
		"gutschein(/:voucher_id)" : "contact"
		"signup" : "signup"
		"login" : "login"
		"impressum" : "legal_notice"
		"activate/:activation_key" : "activate"
		"*undefined" : "content"

	# we have to fetch the ProfileModel once
	initialize: () ->
		ImagesCollection.fetch
			success: (model, response, options) =>
				MenuView.show()
				FooterView.show()
				Backbone.history.start()
		Helper.scroll_top()

	# handle routing - set active element in menu
	before: (route, params) ->
	index: () ->
		ContentView.show("main.html")
	legal_notice: () ->
		ContentView.show("legal_notice.html")
	content: () ->
		ContentView.show("404.html")
	signup: () ->
		SignupView.show()
	login: () ->
		LoginView.show()
	activate: (activation_key) ->
		ActivateView.show(activation_key)

# export a singleton of the AppRouter
module.exports = new AppRouter()