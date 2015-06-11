BaseModel = require("./base.coffee")
ConfigModel = require("./config.coffee")

###
	ActivateModel extends from BaseModel
	exports singleton
###
class ActivateModel extends BaseModel
	urlRoot: () ->
		ConfigModel.get("api") + "users/activate.json"

module.exports = new ActivateModel()