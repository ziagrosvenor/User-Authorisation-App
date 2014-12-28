var gulp = require('gulp'),
	gutil = require('gulp-util'),
	uglify = require('gulp-uglify'),
	concat = require('gulp-concat'),
	sass = require('gulp-sass'),
	coffee = require('gulp-coffee'),
  coffeelint = require('gulp-coffeelint'),
	nodemon = require('gulp-nodemon'),
	browserSync = require('browser-sync');

var coffeeServerSources = [
  'components/coffee/server/*.coffee'
];

var coffeeDataSources = [
	'components/coffee/server/database.coffee',
	'components/coffee/server/models/user-model.coffee',
	'components/coffee/server/models/bind-models.coffee'
];

var coffeeTestSources = [
  'components/coffee/test/*.coffee'
];

var coffeePublicSources = [
  
  'components/coffee/public/*.coffee'
];

var sassSources = [
	'components/sass/*.scss'
];

gulp.task('nodemon', function (cb) {
  var called = false;
  return nodemon({

    // nodemon our expressjs server
    script: 'server.js',

    // watch core server file(s) that require server restart on change
    watch: ['server.js']
  })
    .on('start', function onStart() {
      // ensure start only got called once
      if (!called) { cb(); }
      called = true;
    })
    .on('restart', function onRestart() {
      // reload connected browsers after a slight delay
      setTimeout(function reload() {
        browserSync.reload({
          stream: false   //
        });
      }, 500);
    });
});

gulp.task('browser-sync', ['nodemon'], function () {

  // for more browser-sync config options: http://www.browsersync.io/docs/options/
  browserSync.init({

    // watch the following files; changes will be injected (css & images) or cause browser to refresh
    files: ['public/**/*.*', 'views/*.jade'],

    // informs browser-sync to proxy our expressjs app which would run at the following location
    proxy: 'http://localhost:3000',

    // informs browser-sync to use the following port for the proxied app
    // notice that the default port is 3000, which would clash with our expressjs
    port: 4000,

    // open the proxied app in chrome
    browser: ['google chrome']
  });
});

gulp.task('sass', function () {
	gulp.src(sassSources)
		.pipe(sass())
		.pipe(gulp.dest('public/css'));
});

// Compiles CoffeeScript
gulp.task('coffee', function () {
	gulp.src(coffeeServerSources)
		.pipe(coffee({ bare: true })
			.on('error', gutil.log))
		.pipe(gulp.dest(__dirname));
	gulp.src(coffeeDataSources)
		.pipe(coffee({ bare: true })
			.on('error', gutil.log))
		.pipe(gulp.dest(__dirname + '/data'));
  gulp.src(coffeeTestSources)
    .pipe(coffee({ bare: true })
      .on('error', gutil.log))
    .pipe(gulp.dest(__dirname + '/test'));
  gulp.src(coffeePublicSources)
    .pipe(coffee({ bare: true })
      .on('error', gutil.log))
    .pipe(concat('global.js'))
    .pipe(uglify())
    .pipe(gulp.dest(__dirname + '/public/js/'));
});

gulp.task('watch', function() {
	gulp.watch(sassSources, ['sass']);
	gulp.watch(coffeeServerSources, ['coffee']);
  gulp.watch(coffeePublicSources, ['coffee']);
	gulp.watch(coffeeDataSources, ['coffee']);
  gulp.watch(coffeeTestSources, ['coffee']);
  gulp.watch('components/coffee/server/**/*.coffee', ['lint']);
});

gulp.task('lint', function() {
  gulp.src('./components/coffee/**/*.coffee')
    .pipe(coffeelint())
    .pipe(coffeelint.reporter());
});

gulp.task('default', ['lint', 'sass', 'coffee', 'browser-sync', 'watch']);