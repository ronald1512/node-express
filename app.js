var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const nodemailer = require('nodemailer');
const creds = require('./config/config');


var app = express();
var router = require('./services/router');
// view engine setup

var cors = require('cors')

app.use(cors());


app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
//app.use(express.static(path.join(__dirname, 'public')));

app.use(router);




//all following code is for email sending...
var transport = {
  host: 'smtp.gmail.com', // e.g. smtp.gmail.com
  port: 587,
  secure: false,
  auth: {
    user: creds.USER,
    pass: creds.PASS
  }
}

var transporter = nodemailer.createTransport(transport)

app.use(express.json()); app.post('/send', (req, res, next) => {
  const name = req.body.name
  const email = req.body.email
  const message = req.body.messageHtml


  var mail = {
    from: name,
    to: email,  
    subject: 'Solucitud de recuperación de contraseña',

    html: message
  }

  transporter.sendMail(mail, (err, data) => {
    if(err){
        res.status(404).json({mensaje: err});
    }else{
        res.status(201).json({mensaje: "success"});
    }
  })
});













// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});


module.exports = app;
