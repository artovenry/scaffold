module.exports= (grunt)->
  PROJECT_NAME= "Artovenry ウェブサイト"
  HOSTNAME= "showtarow.local"
  PORT= 3000
  PORT_LIVERELOAD= 30000
  THEME_PATH= "theme"
  ASSETS_PATH= "#{THEME_PATH}/assets"
  JS_PATH= "#{ASSETS_PATH}/js"
  CSS_PATH= "#{ASSETS_PATH}/css"

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    notify_hooks:
      options: enabled: on, success: on, title: PROJECT_NAME

    php:
      server: options: port:PORT, hostname: '0.0.0.0', base: 'wp'
    composer: options: cwd: THEME_PATH
    connect:
      front:
        options: port: PORT_LIVERELOAD, hostname: HOSTNAME, livereload: on, open: off, middleware: ->
          [require('grunt-connect-proxy/lib/utils').proxyRequest]
      proxies: [context: "/", host: HOSTNAME, port:PORT]
    esteWatch:
      options:
        dirs: [
          'theme/**/'
          'src/**/'
        ]
        livereload: enabled: on, extensions: [
          'php', 'haml', 'coffee', 'scss', 'jade', 'png', 'jpg', 'css', 'js'
        ]
      "coffee": ->["newer:coffee", "concat"]
      "jade": ->["newer:jade", "newer:jst", "concat"]
      "scss": ->["compass"]

    clean: ["#{ASSETS_PATH}/js", "#{ASSETS_PATH}/css", "#{ASSETS_PATH}/vendor"]

    bower:
      dist:
        options:
          layout: "byComponent", targetDir: "#{ASSETS_PATH}/vendor"
          cleanTargetDir: on, cleanBowerDir: off
    bower_concat:
      dist:
        dest: "#{JS_PATH}/vendor.js"
        exclude: ["fontawesome"]
        bowerOptions: relative: off
        dependencies:
          "underscore": "jquery"
          "bootstrap": "jquery"
        mainFiles:
          "jquery":"dist/jquery.min.js"
          "underscore":"underscore-min.js"
          "backbone":"backbone.js"
          "bootstrap":"dist/js/bootstrap.min.js"
          "moment":"min/moment-with-locales.min.js"

    coffee:
      dist: 
        options: bare: true
        files:[
          {expand: true, cwd: "src/coffee", src:["**/*.coffee"], dest: "tmp/js", ext: ".js"}
        ]
    jade:
      dist:
        options: pretty: true
        files:[
          {expand: true, cwd: 'src/jst', src: ['**/*.jade'], dest: 'tmp/jst/html', ext: '.html'}
        ]
    jst:
      dist:
        options:
          processName: (name)-> name.match(/tmp\/jst\/html\/(.+)\.html$/)[1]
          processContent: (src)->src.replace(/(^\s+|\s+$)/gm, '')
        files: [
          {expand: true, cwd: 'tmp/jst/html', src: ['**/*.html'], dest: 'tmp/jst/js', ext: '.js'}
        ]
    concat:
      dist:
        files:[
          {src:["tmp/jst/js/**/*.js"], dest:"tmp/jst/jst.js"}
          {src:["tmp/jst/jst.js","tmp/js/**/*.js"], dest:"#{JS_PATH}/site.js"}
        ]
    compass: dist: options: bundleExec: on, config: "compass.rb"

  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)
  grunt.task.run 'notify_hooks'

  grunt.registerTask 'js',[
    "coffee"
    "jade"
    "jst"
    "concat"
  ]

  grunt.registerTask 'make', [
    "clean"
    "bower"
    "bower_concat"
    "js"
    "compass"
  ]
  grunt.registerTask 'server', [
    'php:server'
    'configureProxies'
    'connect:front'
    'esteWatch'
  ]
  grunt.registerTask 'default', [
    'make'
    'server'
  ]