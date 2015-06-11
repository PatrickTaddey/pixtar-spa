BaseModel = require("./base.coffee")
Helper = require("../utils/helper.coffee")

###
	UserModel extends from BaseModel
	exports singleton
###
class UserModel extends BaseModel
	initialize: () ->
		user = localStorage.getItem('user');
		if user?
			@set(JSON.parse(user))
			Helper.set_csrftoken(@get("csrftoken"))

module.exports = new UserModel()