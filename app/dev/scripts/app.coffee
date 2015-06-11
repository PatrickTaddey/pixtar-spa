$ = require("jquery")
Backbone = require("backbone")
Backbone.$ = $
require("backbone.routefilter")
Helper = require("./utils/helper.coffee")
# require views
MenuView = require("./views/menu.coffee")
FooterView = require("./views/footer.coffee")
ContentView = require("./views/content.coffee")
SignupView = require("./views/signup.coffee")
LoginView = require("./views/login.coffee")
ActivateView = require("./views/activate.coffee")
ImageView = require("./views/image.coffee")

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
		"logout" : "logout"
		"activate/:activation_key" : "activate"
		"image" : "image"
		"impressum" : "legal_notice"
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
		if UserModel.get("session_id")? and !route
			Backbone.history.navigate("", {trigger: true})
		Helper.handle_routing(route, params)
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
	logout: () ->
		$.removeCookie('CAKEPHP')
		window.location.href = ""
	activate: (activation_key) ->
		ActivateView.show(activation_key)
	image: () ->
		ImageView.show()

# export a singleton of the AppRouter
module.exports = new AppRouter()