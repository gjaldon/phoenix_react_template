gulp            = require 'gulp'
gutil           = require 'gulp-util'
browserify      = require 'browserify'
coffeereactify  = require 'coffee-reactify'
source          = require 'vinyl-source-stream'
del             = require 'del'
tiny_lr         = require 'tiny-lr'
express         = require 'express'

paths =
  css: ['frontend/css/**/*.sass']
  index_js: ['./frontend/app/initialize.cjsx']
  js: ['frontend/app/**/*.cjsx', 'frontend/app/**/*.coffee']
  build: ['./build/**/*']


## Tasks

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'js', ->
  browserify paths.index_js, extensions: ['.cjsx']
  .transform coffeereactify
  .bundle()
  .pipe source('app.js')
  .pipe gulp.dest('./build/')

gulp.task 'watch', ->
  servers = createServers(8080, 35729)
  gulp.watch paths.js, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'js'
  gulp.watch paths.build, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    servers.lr.changed
      body:
        files: [e.path]

gulp.task 'default', ['clean'], ->
  gulp.start 'js'


## Helpers

createServers = (port, lrport) ->
  lr = tiny_lr()
  lr.listen lrport, -> gutil.log "LiveReload listening on", lrport
  app = express()
  app.use express.static("./build")
  app.listen port, -> gutil.log "HTTP server listening on", port

  lr: lr
  app: app
