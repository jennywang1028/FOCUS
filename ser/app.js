var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');


var mongo = require('mongodb');
var monk = require('monk');
var util = require('util');
var async = require('async');
//var mongoose = require('mongoose');
var secret = require('./passwords')
var db = monk('mongodb://<dbuser>:<dbpassword>@ds061335.mongolab.com:61335/derp');
/*
////////////////////// Database
// var mongo = require('mongodb');
// //var monk = require('monk');
// var util = require('util');
// var async = require('async');
// var mongoose = require('mongoose');
// var Schema = mongoose.Schema;
// // var uri = "mongodb://janezd:<dbpassword>@ds061335.mongolab.com:61335/derp"
// //var db = monk('localhost:27017/nodetest2');
// // second:
// var database =  {
//   url: "ds061335.mongolab.com:61335",
//   name: "derp",
//   user : secret.un,
//   password : secret.pw
// };
// var loginCredentials = database.user + ":" + database.password;

// var db = mongoose;

// db.connect("mongodb://" + loginCredentials + "@" + database.url + "/" + database.name);


// var lineSchema = {
//   num: Number,
//   pun: String
// };

// var Line = mongoose.model('Line', bookingSchema);

// Line.find({}, function(err, lines) {
//     async.each(bookings, booking, function(line, next) {
//         console.log(util.format('yay something worked: %s', line.pun));
//     }, function(err) {
//         console.log('done reading records');
//     });
// });
//////////////////////////////////////////
*/
var routes = require('./routes/index');
var users = require('./routes/users');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Make our db accessible to our router
app.use(function(req,res,next){
    req.db = db;
    next();
});

app.use('/', routes);
app.use('/users', users);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;
