module.exports = (grunt) ->

	grunt.initConfig
		pkg: grunt.file.readJSON("package.json")

		nunjucks:
			precompile:
				src: ["app/dev/**/*.html", "!app/dev/templates/index.html", "!app/dev/vendor/**/*.html"]
				dest: "app/dev/templates/templates.js"

		browserify:
			app:
				src: ["app/dev/**/*.coffee", "app/dev/templates/templates.js"]
				dest: "app/build/scripts/app.js"
				options:
					extensions: [".coffee"]
					transform: ["coffeeify", "debowerify"]
					browserifyOptions:
						debug: true
					watch: true

		sass:
			build:
				options:
					sourcemap: true
				files:
					"app/build/stylesheets/app.css": "app/dev/stylesheets/app.scss"
			release:
				options:
					outputStyle: "compressed"
				files:
					"app/release/stylesheets/app.min.css": "app/dev/stylesheets/app.scss"

		connect:
			build:
				options:
					livereload: true
					port: 9000
					base: "app/build"

		clean: 
			build:
				["app/build"]
			release:
				["app/release"]

		injector:
			options:
				addRootSlash: false
			build:
				options:
					ignorePath: "app/build/"
					template: "app/dev/templates/index_build.html"
				files:
					"app/build/index.html": ["app/build/scripts/vendor.js", "app/build/scripts/app.js", "app/build/stylesheets/app.css"]
			release:
				options:
					ignorePath: "app/release/"
					template: "app/dev/templates/index_release.html"
				files:
					"app/release/index.html": ["app/release/scripts/app.min.js", "app/release/stylesheets/app.min.css"]

		asset_cachebuster:
			options:
				buster: Date.now()
			release:
				files:
					"app/release/index.html":["app/release/index.html"]

		copy:
			build:
				files: [
					{expand: true, cwd: "app/dev/vendor/components-font-awesome/fonts/", src: ["**"], dest: "app/build/fonts"}
					{expand: true, cwd: "app/dev/images/", src: ["**"], dest: "app/build/images"}
				]
			release:
				files: [
					{expand: true, cwd: "app/dev/vendor/components-font-awesome/fonts/", src: ["**"], dest: "app/release/fonts"}
					{expand: true, cwd: "app/dev/images/", src: ["**"], dest: "app/release/images"}
				]

		uglify:
			release:
				files: 'app/release/scripts/app.min.js': ['app/build/scripts/app.js']

		watch:
			build_js:
				files: [
					"app/build/scripts/app.js"
				]
				tasks: []
				options:
					livereload: true
			build_css:
				files: [
					"app/dev/**/*.scss"
				]
				tasks: ["sass:build"]
				options:
					livereload: true
			build_templates:
				files: [
					"app/dev/**/*.html"
				]
				tasks: ["nunjucks", "injector"]

		focus:
			build:
				include: ["build_templates", "build_js", "build_css"]

		shell:
			gettext:
				command: "find app/dev/templates/  app/dev/scripts/ -iname '*.html' -o -iname '*.coffee' | xargs xgettext --language=Python --from-code=utf-8 -c -o app/dev/locale/messages.pot"
				options:
					stdout: true
					stderr: true
			msgmerge_de_DE:
				command: "msgmerge de_DE/LC_MESSAGES/messages.po messages.pot -o de_DE/LC_MESSAGES/messages.po"

				options:
					execOptions:
						cwd: "app/dev/locale/"
					stdout: true
					stderr: true


		grunt.registerTask "po2json", ->
			po2json = require("po2json")
			for locale in ["de_DE"]
				json_data = po2json.parseFileSync "app/dev/locale/#{locale}/LC_MESSAGES/messages.po", format: "jed"
				grunt.file.write("app/dev/locale/#{locale}/LC_MESSAGES/messages.json", JSON.stringify(json_data))

		require('load-grunt-tasks')(grunt)

		grunt.registerTask "default", [
			"clean:build",
			"nunjucks"
			"browserify:app",
			"sass:build",
			"injector:build",
			"copy:build",
			"connect:build",
			"focus:build"
		]
		
		grunt.registerTask "release", [
			"clean",
			"nunjucks"
			"browserify:app",
			"sass:release",
			"uglify:release",
			"copy:release",
			"injector:release",
			"asset_cachebuster"
		]

		grunt.registerTask "locale", [
			"shell",
			"po2json"
		]