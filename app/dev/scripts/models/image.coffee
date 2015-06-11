$ = require("jquery")
BaseModel = require("./base.coffee")
ConfigModel = require("./config.coffee")
i18n = require("../utils/i18n.coffee")

###
	ImageModel extends from BaseModel
	exports singleton
###
class ImageModel extends BaseModel
	urlRoot: () ->
		ConfigModel.get("api") + "images.json"

	validation:
		description:
			required: true
			minLength: 2
			maxLength: 255
			message: i18n.gettext("Bitte gebe eine Beschreibung ein.")
		image:
			required: true
			message: i18n.gettext("Bitte wähle eine Datei aus.")

module.exports = new ImageModel()