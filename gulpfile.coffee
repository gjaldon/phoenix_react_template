gulp            = require 'gulp'
gutil           = require 'gulp-util'
watchify        = require 'watchify'
browserify      = require 'browserify'
coffeereactify  = require 'coffee-reactify'
source          = require 'vinyl-source-stream'
del             = require 'del'
tiny_lr         = require 'tiny-lr'
express         = require 'express'
sass            = require 'gulp-sass'
uglify          = require 'gulp-uglify'
buffer          = require 'gulp-buffer'
sourcemaps      = require 'gulp-sourcemaps'

paths =
  sass: ['frontend/sass/**/*.sass']
  index_js: ['./frontend/app/initialize.cjsx']
  js: ['frontend/app/**/*.cjsx', 'frontend/app/**/*.coffee']
  build: ['./build/**/*']
  images: ['frontend/assets/images']


## Tasks

gulp.task 'clean', (cb) ->
  del ['build'], cb

gulp.task 'copy', ['clean'], ->
  gulp.src(['frontend/*.html']).pipe(gulp.dest('./build'))

gulp.task 'jsWatch', ->
  bundler = watchify(browserify paths.index_js,
    cache: {}
    packageCache: {}
    fullPaths: true
    extensions: ['.cjsx']
    debug: !gulp.env.production
  ).transform coffeereactify

  rebundle = ->
    bundler
    .bundle()
    .pipe source('app.js')
    .pipe buffer()
    .pipe if gulp.env.production then sourcemaps.init(loadMaps: true) else gutil.noop()
    .pipe if gulp.env.production then uglify() else gutil.noop()
    .pipe if gulp.env.production then sourcemaps.write './' else gutil.noop()
    .pipe gulp.dest('./build')

  bundler.on 'update', rebundle
  bundler.on 'log', (msg) -> gutil.log(msg)

  rebundle()

gulp.task 'css', ->
  gulp.src(paths.sass).pipe(sass
    errLogToConsole: true
    sourceComments : 'normal'
  )
  .pipe if gulp.env.production then minifyCSS() else gutil.noop()
  .pipe gulp.dest('./build')

gulp.task 'watch', ->
  servers = createServers(8080, 35729)

  gulp.watch paths.sass, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'css'

  gulp.watch paths.build, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    servers.lr.changed
      body:
        files: [e.path]

gulp.task 'default', ['copy', 'jsWatch', 'css'], ->
  gulp.start 'watch'


## Helpers

createServers = (port, lrport) ->
  lr = tiny_lr()
  lr.listen lrport, -> gutil.log "LiveReload listening on", lrport
  app = express()
  app.use express.static("./build")
  app.listen port, -> gutil.log "HTTP server listening on", port

  lr: lr
  app: app
