$ = require("jquery")
require("jquery-cookie")
Helper = require("./utils/helper.coffee")
Helper.set_ajax_prefilter()
# require Backbone and route extension routefilter
Backbone = require("backbone")
require("backbone.routefilter")

# require views
MenuView = require("./views/menu.coffee")
FooterView = require("./views/footer.coffee")
ContentView = require("./views/content.coffee")
LoginView = require("./views/login.coffee")
SignupView = require("./views/signup.coffee")
ActivateView = require("./views/activate.coffee")
ImageView = require("./views/image.coffee")
ImageListView = require("./views/image_list.coffee")

UserModel = require("./models/user.coffee")

###
	AppRouter extends from Backbone.Router
	- handle routing
	- display views
	exports a singleton
###
class AppRouter extends Backbone.Router
	routes :
		"(images)(/page/:page)(/filter/:filter)" : "index"
		"signup" : "signup"
		"login" : "login"
		"logout" : "logout"
		"activate/:activation_key" : "activate"
		"image" : "image"
		"impressum" : "legal_notice"
		"*undefined" : "content"

	# we have to fetch the ProfileModel once
	initialize: () ->
		MenuView.show()
		FooterView.show()
		Backbone.history.start()
		Helper.scroll_top()

	# handle routing - set active element in menu
	before: (route, params) ->
		if route is "*undefined"
			Backbone.history.navigate("images", {trigger: true})
		Helper.handle_routing(route, params)
	index: (page, filter) ->
		ImageListView.show(page, filter)
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