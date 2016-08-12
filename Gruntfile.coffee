module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            dist:
                options:
                    sourceMap: true
                files:
                    'dist/js/paraxify.js': 'paraxify.coffee'
        compass:
            dist:
                options:
                    sourcemap: true
                    cssPath: 'dist/css'
                    sassPath: '.'
        uglify:
            dist:
                options:
                    sourceMap: true
                files:
                    'dist/js/paraxify.min.js': 'dist/js/paraxify.js'

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-uglify'

    grunt.registerTask 'default', ['coffee', 'compass', 'uglify']
