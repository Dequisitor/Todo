var gulp = require('gulp');
var open = require('gulp-open');
var connect = require('gulp-connect');
var rename = require('gulp-rename');
var jade = require('gulp-pug');
var stylus = require('gulp-stylus');
//var coffeeify = require('gulp-coffeeify');
var browserify = require('gulp-browserify');
var livereload = require('gulp-livereload');

var config = {
	port: 3000,
	url: 'http://localhost',
	paths: {
		dist: './dist',
		mainJs: './src/main.coffee',
		mainHtml: './src/index.jade',
		js: './src/**/*.coffee',
		css: './src/*.stylus',
		html: './src/**/*.jade'
	}
};

gulp.task('connect', function() {
	connect.server({
		root: ['dist'],
		port: config.port,
		base: config.url,
		livereload: true
	});
});

gulp.task('html', function() {
	gulp.src([config.paths.html, config.paths.mainHtml])
		.pipe(jade())
		.on('error', console.error.bind(console))
		.pipe(gulp.dest(config.paths.dist))
		.pipe(connect.reload());
});

gulp.task('js', function() {
	gulp.src([config.paths.js, config.paths.mainJs], {read: false})
		.pipe(browserify({
			transform: ['coffee-reactify'],
			extensions: ['.coffee']
		}))
		.on('error', console.error.bind(console))
		.pipe(rename(function(path) {
			path.extname = '.js';
		}))
		.pipe(gulp.dest(config.paths.dist))
		.pipe(connect.reload());
});

gulp.task('css', function() {
	gulp.src(config.paths.css)
		.pipe(stylus())
		.on('error', console.error.bind(console))
		.pipe(gulp.dest(config.paths.dist))
		.pipe(connect.reload());
});

gulp.task('watch', function() {
	gulp.watch([config.paths.html, config.paths.mainHtml], ['html']);
	gulp.watch([config.paths.js, config.paths.mainJs], ['js']);
	gulp.watch(config.paths.css, ['css']);
	gulp.watch('./src/*.json', ['js']);
});

gulp.task('open', ['connect'], function() {
	gulp.src('./dist/index/html')
		.pipe(open({uri: config.url + ':' + config.port + '/'}));
});

gulp.task('default', ['html', 'js', 'css', 'open', 'watch']);
