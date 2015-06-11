###
	here we start the app as singleton
###

# export window.jQuery once so we can use it in the App
window.jQuery = require("jquery")
$ = window.jQuery

# activate cookie support
require("jquery-cookie")
$.ajaxPrefilter ( options, originalOptions, jqXHR ) ->
	options.xhrFields =
		withCredentials: true

# export window.Modernizr - dependency for foundation
window.Modernizr = require('browsernizr2')

# export window.Foundation
foundation = require("foundation")

# we need to require the precompiled nunjucks templates
templates = require("../templates/templates.js")

# initialize singleton app
window.App = require("./app.coffee")