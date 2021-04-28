const {series, src, dest} = require('gulp');
const del = require('del')
const concat = require('gulp-concat');
const uglify = require('gulp-uglify');

// The `clean` function is not exported so it can be considered a private task.
// It can still be used within the `series()` composition.
function clean(cb) {
  console.log('Cleaning...');
  del(['dist/**'])
  cb();
}

// The `build` function is exported so it is public and can be run with the `gulp` command.
// It can also be used within the `series()` composition.
function build(cb) {
  console.log('Building...');
  src(['!node_modules/', 'node_modules/jsdom/lib/api.js', 'src/*.js'])
  .pipe(concat('app.js'))
  // .pipe(uglify())
  .pipe(dest('./dist/'))
  cb();
}

exports.build = build;
exports.default = series(clean, build);
