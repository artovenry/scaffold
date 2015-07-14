module.exports= (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    bower:
      install:
        options:
          layout: "byType"
          cleanTargetDir: on
          cleanBowerDir: off
          targetDir: "public/vendor"
      
    bower_concat:
      all:
        dependencies:
          "backbone": "jquery"
          "bootstrap": "jquery"
        mainFiles:
          "jquery": "dist/jquery.min.js"
          "bootstrap": "dist/js/bootstrap.min.js"
          "moment": "min/moment-with-locales.min.js"
        dest: "public/js/vendor.js"

    compass:
      compile:
        src: "src/**/*.scss"
        options: 
          bundleExec: on
          config: "compass.rb"

    coffee:
      compile: 
        options: {bare: true}
        files: [
          expand: true
          cwd: 'src/coffee'
          src: ['**/*.coffee']
          dest: 'tmp/js'
          ext: '.js'
        ]

    jade: 
      compile_jst:
        options: {pretty: true}
        files: [
          expand: true
          cwd: 'src/jst'
          src: ['**/*.jade']
          dest: 'tmp/jst/html'
          ext: '.html'
        ]

    jst:
      compile:
        options:
          processName: (name)->
            name.match(/tmp\/jst\/html\/(.+)\.html$/)[1]
          processContent: (src)->
            src.replace(/(^\s+|\s+$)/gm, '')
        files: [
          expand: true
          cwd: 'tmp/jst/html'
          src: ['**/*.html']
          dest: 'tmp/jst/js'
          ext: '.js'
        ]
      

    concat:
      dist:
        src: ["tmp/js/app.js", "tmp/jst/js/**/*.js", "tmp/js/**/*.js"]
        dest: "public/js/site-dev.js"

    uglify:
      options:
        files:
          "public/js/site.js": "<%= concat.files.dest %>"

    esteWatch:
      options:
        dirs: ["src/**", "tmp/**"]
        livereload:
          enabled: on
          extensions: ['php', 'js', 'css', 'png', 'gif', 'jpg', 'jpeg', 'html']
      "coffee": (path)->
        ["newer:coffee", "concat"]
      "jade": (path)->
        ["jade"]
      "scss": (path)->
        ["compass"]
      "png": (path)->
        ["compass"]
      "js": (path)->
        ["newer:concat"]
      "html": (path)->
        ["jst"]

    php:
      server:
        options:
          port: 3000
          host: "localhost"
          base: "public"

    connect:
      front:
        options:
          port:30000
          host: "localhost"
          livereload: on
          open: off
          middleware: (connect)-> [
            require('grunt-connect-proxy/lib/utils').proxyRequest
          ]
      proxies: [
        context: "/"
        host: "localhost"
        port: 3000
        changeOrigin: off
      ]


  require("matchdep").filterDev("grunt-*").forEach(grunt.loadNpmTasks)
  grunt.registerTask "make", [
    "bower"
    "bower_concat"
    "newer:coffee"
    "jade"
    "jst"
    "compass"
    "newer:concat"
  ]
  grunt.registerTask "server", [
    'php:server'
    'configureProxies'
    'connect:front'
    'esteWatch'
  ]

  ###
  grunt.registerTask "production", [
    'bower:production'
    'bower_concat:production'
    'coffee'
    'jade'
    'jst'
    'compass:production'
    'concat'
    'uglify:production'
  ]
  ###

  grunt.registerTask "default", [
    "make"
    "server"
  ]
  
