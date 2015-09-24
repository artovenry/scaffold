module.exports= (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    notify_hooks: options: enabled: on, success: on, title: "Grunt通知"
    bower:
      install:
        options:
          layout: "byComponent", targetDir: "theme/assets/vendor"
          cleanTargetDir: on, cleanBowerDir: off
    bower_concat:
      all:
        dest: 'theme/assets/js/vendor.js'
        bowerOptions: {relative: false}
        dependencies:
          "backbone": "jquery"
          "bootstrap": "jquery"
        mainFiles:
          "jquery":"dist/jquery.min.js"
          "underscore":"underscore-min.js"
          "backbone":"backbone.js"
          "bootstrap":"dist/js/bootstrap.min.js"
          "moment":"min/moment-with-locales.js"

    coffee:
      compile:
        options: bare: true
        files: [{expand: true, cwd: 'src/coffee', src: ['**/*.coffee'], dest: 'tmp/js', ext: '.js'}]
    jade: 
      compile_jst:
        options: pretty: true
        files: [{expand: true, cwd: 'src/jst', src: ['**/*.jade'], dest: 'tmp/jst/html', ext: '.html'}]
    jst:
      compile:
        options:
          processName: (name)-> name.match(/tmp\/jst\/html\/(.+)\.html$/)[1]
          processContent: (src)->src.replace(/(^\s+|\s+$)/gm, '')
        files: [{expand: true, cwd: 'tmp/jst/html', src: ['**/*.html'], dest: 'tmp/jst/js', ext: '.js'}]
    concat:
      dist:
        files:[
          {src:["tmp/jst/js/**/*.js"], dest:"tmp/jst/jst.js"}
          {src:["tmp/jst/jst.js","tmp/js/**/*.js"], dest:"theme/assets/js/site-dev.js"}
        ]

    compass: compile: options: bundleExec: on, config: "compass.rb"

    php:
      server: options: port: 3000, hostname: '0.0.0.0', base: "wp"
    connect:
      hostname: 'localhost'
      front:
        options: port:30000, hostname: '<%= connect.hostName %>', livereload: on, open: off, middleware: ->
            [require('grunt-connect-proxy/lib/utils').proxyRequest]
      proxies: [context: "/",host: '<%= connect.hostName %>', port: 3000, changeOrigin: on]
    esteWatch:
      options:
        dirs: ["theme/**/"]
        livereload: enabled: on, extensions: ['haml','php','png', 'gif', 'jpg','js', 'html', 'css']
      "coffee": ->["newer:coffee", "concat"]
      "jade": ->["newer:jade", "newer:jst", "concat"]
      "scss": ->["compass"]


  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)
  grunt.task.run('notify_hooks')
  grunt.registerTask "make", [
    "bower"
    "bower_concat"
    "compass"
    "coffee"
    "jade"
    "jst"
    "concat"
  ]

  grunt.registerTask "server", [
    'php:server'
    'configureProxies'
    'connect:front'
    "esteWatch"
  ]

  grunt.registerTask "default", [
    "make"
    "server"
  ]
 
