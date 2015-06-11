$ = require("jquery")
Backbone = require("backbone")
Backbone.$ = $

###
	BaseModel extends from Backbone.Model
	- parsing the api response
###
class BaseModel extends Backbone.Model
	parse : (response) ->
		return response.data

module.exports = BaseModel