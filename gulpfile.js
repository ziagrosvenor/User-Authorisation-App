var gulp = require('gulp'),
	gutil = require('gulp-util'),
	uglify = require('gulp-uglify'),
	concat = require('gulp-concat'),
	sass = require('gulp-sass'),
	coffee = require('gulp-coffee'),
	nodemon = require('gulp-nodemon'),
	browserSync = require('browser-sync');

var coffeeServerSources = [
	'components/coffee/server/app.coffee',
	'components/coffee/server/server.coffee'
];

var coffeeDataSources = [
	'components/coffee/server/database.coffee',
	'components/coffee/server/models/user-model.coffee',
	'components/coffee/server/models/bind-models.coffee'
];

// var coffeeTestSources = [
//   'components/coffee/test/Routes-Spec.coffee'
// ];

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

gulp.task('coffee', function () {
	gulp.src(coffeeServerSources)
		.pipe(coffee({ bare: true })
			.on('error', gutil.log))
		.pipe(gulp.dest(__dirname));
	gulp.src(coffeeDataSources)
		.pipe(coffee({ bare: true })
			.on('error', gutil.log))
		.pipe(gulp.dest(__dirname + '/data'));
  // gulp.src(coffeeTestSources)
  //   .pipe(coffee({ bare: true })
  //     .on('error', gutil.log))
  //   .pipe(gulp.dest(__dirname + '/test'));
});

gulp.task('watch', function() {
	gulp.watch(sassSources, ['sass']);
	gulp.watch(coffeeServerSources, ['coffee']);
	gulp.watch(coffeeDataSources, ['coffee']);
});

gulp.task('default', ['sass', 'coffee', 'browser-sync', 'watch']);