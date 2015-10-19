module.exports = (grunt) ->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    sass:
      styles:
        options:
          style: 'expanded'
          bundleExec: true
          sourcemap: 'none'
        files:
          'styles/simditor-font-scale.css': 'styles/simditor-font-scale.scss'
    coffee:
      src:
        options:
          bare: true
        files:
          'lib/simditor-font-scale.js': 'src/simditor-font-scale.coffee'
      spec:
        expand: true
        flatten: true
        src: 'spec/*.coffee'
        dest: 'spec'
        ext: '.js'

    umd:
      all:
        src: 'lib/simditor-font-scale.js'
        template: 'umd'
        amdModuleId: 'simditor-font-scale'
        objectToExport: 'FontScaleButton'
        globalAlias: 'SimditorFontScale'
        deps:
          'default': ['$', 'Simditor']
          amd: ['jquery', 'simditor']
          cjs: ['jquery', 'Simditor']
          global:
            items: ['jQuery', 'Simditor']
            prefix: ''
    watch:
      styles:
        files: ['styles/*.scss']
        tasks: ['sass', 'jasmine']
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
            'styles/simditor-font-scale.css'
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
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-umd'

  grunt.registerTask 'default', ['sass', 'coffee', 'umd', 'jasmine:test:build', 'watch']
  grunt.registerTask 'test', ['sass', 'coffee', 'umd', 'jasmine']
