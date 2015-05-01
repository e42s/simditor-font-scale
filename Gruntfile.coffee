module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    coffee:
      src:
        options:
          bare: true
        files:
          'lib/simditor-small.js': 'src/simditor-small.coffee'
      spec:
        expand: true
        flatten: true
        src: 'spec/*.coffee'
        dest: 'spec'
        ext: '.js'

    umd:
      all:
        src: 'lib/simditor-small.js'
        template: 'umd'
        amdModuleId: 'simditor-small'
        objectToExport: 'SmallButton'
        globalAlias: 'SimditorSmall'
        deps:
          'default': ['$', 'Simditor']
          amd: ['jquery', 'simditor']
          cjs: ['jquery', 'Simditor']
          global:
            items: ['jQuery', 'Simditor']
            prefix: ''
    watch:
      src:
        files: ['src/*.coffee']
        tasks: ['coffee:src', 'umd', 'jasmine']
      spec:
        files: ['spec/**/*.coffee']
        tasks: ['coffee:spec', 'jasmine']

    jasmine:
      test:
        src: ['lib/**/*.js']
        options:
          outfile: 'spec/index.html'
          styles: [
            'styles/simditor.css'
          ]
          specs: 'spec/*.js'
          vendor: [
            'vendor/bower/jquery/dist/jquery.min.js'
            'vendor/bower/jasmine-jquery/lib/jasmine-jquery.js'
            'vendor/bower/simple-module/lib/module.js'
            'vendor/bower/simple-uploader/lib/uploader.js'
            'vendor/bower/simple-hotkeys/lib/hotkeys.js'
            'vendor/bower/simditor/lib/simditor.js'
          ]

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['coffee', 'umd', 'jasmine:test:build', 'watch']
  grunt.registerTask 'test', ['coffee', 'umd', 'jasmine']
