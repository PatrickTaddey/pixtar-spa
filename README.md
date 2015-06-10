Pixtar Single Page Application
============

Built with Bower, Browserify, Backbone, Foundation, Nunjucks, ...

This App uses my CakePHP3 based [REST-API](https://github.com/PatrickTaddey/pixtar-api/ "REST-API"). 

Installation
--------------
#### clone repository

```sh
git clone git@github.com:PatrickTaddey/pixtar-spa.git
```

#### Setup client

```sh
cd pixtar-spa/
npm install
bower install

# start development in app/dev/* Folders
# output is in app/build/*
grunt build

# start deployment
# output is in app/release/* Folders
grunt release
```