$ = require("jquery")
BaseModel = require("./base.coffee")
ConfigModel = require("./config.coffee")
i18n = require("../utils/i18n.coffee")

###
	LoginModel extends from BaseModel
	exports singleton
###
class LoginModel extends BaseModel
	urlRoot: () ->
		ConfigModel.get("api") + "sessions.json"

	validation:
		username:
			required: true
			minLength: 8
			maxLength: 40
			format: "email"
			message: i18n.gettext("Bitte gebe deine E-Mail ein.")
		password: 
			required: true
			minLength: 8
			maxLength: 255
			message: i18n.gettext("Bitte gebe deine Passwort ein.")

module.exports = new LoginModel()