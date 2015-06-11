BaseModel = require("./base.coffee")
$ = require("jquery")

###
	ConfigModel extends from BaseModel
	- sharing config data
	exports singleton
###
class ConfigModel extends BaseModel
	defaults:
		api: $("body").attr("data-api") or "//api.megaphones.de/"
module.exports = new ConfigModel()