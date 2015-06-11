$ = require("jquery")
Backbone = require("backbone")
Backbone.$ = $
BaseModel = require("./base.coffee")
ConfigModel = require("./config.coffee")
i18n = require("../utils/i18n.coffee")

###
	SignupModel extends from BaseModel
	exports singleton
###
class SignupModel extends Backbone.Model
	urlRoot: () ->
		ConfigModel.get("api") + "users.json"

	validation:
		username:
			required: true
			minLength: 8
			maxLength: 40
			format: "email"
			message: i18n.gettext("Bitte gebe deine E-Mail ein.")
		password: [
			{
				required: true
				minLength: 8
				maxLength: 255
				message: i18n.gettext("Mindestens 8 Zeichen. ")
			}, {
				fn: (value) ->
					if @get("password_confirm") isnt value and @get("password_confirm")?
						return i18n.gettext("Beide Passwörter müssen übereinstimmen.")
					else
						return true
			}
		]
		password_confirm: [
			{
				required: true
				minLength: 8
				maxLength: 255
				message: i18n.gettext("Mindestens 8 Zeichen. ")
			}, {
				fn: (value) ->
					if @get("password") isnt value and @get("password")?
						return i18n.gettext("Beide Passwörter müssen übereinstimmen.")
					else
						return true
			}
		]

module.exports = new SignupModel()