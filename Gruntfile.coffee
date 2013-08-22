module.exports = (grunt) ->
  grunt.initConfig
    bowerDirectory: require('bower').config.directory
    less:
      compile:
        options:
          compress: false
          paths: ['less', 'tmp', '<%= bowerDirectory %>/bootstrap/less']
        files:
          'dist/css/bootstrap.css': ['less/theme.less']
    watch:
      less:
        files: ['less/*.less']
        tasks: ['copy', 'less:compile', 'clean']
        options:
          livereload: true
      cssmin:
        files: ['dist/css/bootstrap.css']
        tasks: ['cssmin:minify']
    cssmin:
      minify:
        expand: true
        cwd: 'dist/css'
        src: ['*.css', '!*.min.css']
        dest: 'dist/css'
        ext: '.min.css'
    concat:
        dist:
            src: [
                '<%= bowerDirectory %>/jquery/jquery.js',
                '<%= bowerDirectory %>/bootstrap/js/transition.js',
                '<%= bowerDirectory %>/bootstrap/js/alert.js',
                '<%= bowerDirectory %>/bootstrap/js/button.js',
                '<%= bowerDirectory %>/bootstrap/js/carousel.js',
                '<%= bowerDirectory %>/bootstrap/js/collapse.js',
                '<%= bowerDirectory %>/bootstrap/js/dropdown.js',
                '<%= bowerDirectory %>/bootstrap/js/modal.js',
                '<%= bowerDirectory %>/bootstrap/js/tooltip.js',
                '<%= bowerDirectory %>/bootstrap/js/popover.js',
                '<%= bowerDirectory %>/bootstrap/js/scrollspy.js',
                '<%= bowerDirectory %>/bootstrap/js/tab.js',
                '<%= bowerDirectory %>/bootstrap/js/affix.js'
                '<%= bowerDirectory %>/FitVids/jquery.fitvids.js',
            ],
            dest: 'dist/js/script.js'
    uglify:
        my_target:
            files:
                'dist/js/script.min.js' : [ 'js/script.js', ]
    connect:
      serve:
        options:
          port: grunt.option('port') || '8000'
          hostname: grunt.option('host') || 'localhost'
    copy:
      bootstrap:
        files: [
          { expand: true, cwd: '<%= bowerDirectory %>/bootstrap/less', src: ['bootstrap.less'], dest: 'tmp/' },
          { expand: true, cwd: '<%= bowerDirectory %>/bootstrap/fonts', src: ['*'], dest: 'dist/fonts' }
        ]
    clean: ['tmp']

  grunt.loadNpmTasks('grunt-contrib-less')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-cssmin')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-text-replace')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-connect')
  grunt.loadNpmTasks('grunt-contrib-uglify')
  grunt.loadNpmTasks('grunt-contrib-concat')

  grunt.registerTask('default', ['copy', 'less', 'cssmin', 'concat', 'uglify', 'clean'])
  grunt.registerTask('serve', ['connect', 'watch'])
