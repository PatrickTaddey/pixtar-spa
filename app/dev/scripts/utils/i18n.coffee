_ = require("underscore")
Jed = require("jed")
nunjucks = require("../../vendor/nunjucks/browser/nunjucks-slim.js")
de = require("../../locale/de_DE/LC_MESSAGES/messages.json")

###
	class I18N 
	- render templates with nunjucks
	- add gettext/i18n support for localization
	exports singleton
###
class I18N

	i18n: null
	constructor: ->
		@locales = de: de
		@setLocale("de")

	setLocale: (lang) ->
		locale_data = {"":{}}
		if @locales[lang]
			locale_data =@locales[lang]
		@i18n = new Jed(locale_data)
		return

	gettext: (string) ->
		@i18n.gettext.call(@i18n, string)

	ngettext: (string, n) ->
		@i18n.ngettext.call(@i18n, string, n)

	render: (template, context={}) ->
		extra_context = i18n : @i18n
		_.defaults(context, extra_context)
		nunjucks.render(template, context)

module.exports = new I18N()