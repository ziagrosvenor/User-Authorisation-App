var gulp = require('gulp'),
	gutil = require('gulp-util'),
	uglify = require('gulp-uglify'),
	concat = require('gulp-concat'),
	sass = require('gulp-sass'),
	coffee = require('gulp-coffee'),
	livereload = require('gulp-livereload'),
	lr = require('tiny-lr'),
	server = lr();

var coffeeServerSources = [
	'components/coffee/server/app.coffee',
	'components/coffee/server/server.coffee'
];

var coffeeDataSources = [
	'components/coffee/server/database.coffee',
	'components/coffee/server/models/user-model.coffee',
	'components/coffee/server/models/bind-models.coffee'
];

var sassSources = [
	'components/sass/*.scss'
];

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
});

gulp.task('watch', function() {
	gulp.watch(sassSources, ['sass']);
	gulp.watch(coffeeServerSources, ['coffee']);
	gulp.watch(coffeeDataSources, ['coffee']);
	gulp.watch('./gulpfile.js', ['default']);
});

gulp.task('default', ['sass', 'coffee', 'watch']);