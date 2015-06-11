$ = require("jquery")
require("jquery-cookie")
BaseModel = require("./base.coffee")
Helper = require("../utils/helper.coffee")

###
	UserModel extends from BaseModel
	exports singleton
###
class UserModel extends BaseModel
	initialize: () ->
		session_id = $.cookie("CAKEPHP")
		if session_id?
			@set("session_id", session_id)

module.exports = new UserModel()