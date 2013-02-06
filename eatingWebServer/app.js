
/**
 * Module dependencies.
 */

var express = require('express')
  , http = require('http')
  , path = require('path')
  , gzippo = require('gzippo');


var cacheTime = {
  oneYear : 31557600000,
  oneDay : 86400000,
  oneHour : 3600000
}

var app = express();

app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.engine('ejs',require('ejs-locals'));
  app.set('view engine', 'ejs');
  app.use(express.favicon());
  app.use(express.bodyParser());
  // app.use(express.cookieParser('your secret here'));
  // app.use(express.session({ secret: "iEating" }));
  app.use(app.router);
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions : true, showStack : true }));
  app.set('node-env', 'development');
  app.use(require('less-middleware')({
      src: __dirname + '/development',
      compress: false,
      debug: true,
      force: true
    }));
  app.use(express.static(__dirname+'/development'));
  app.use(express.compress());
});

app.configure( 'production', function (){
  app.use(express.errorHandler());
  app.set('node-env', 'production');
  app.use(gzippo.staticGzip(__dirname+'/public', { maxAge: cacheTime.oneDay }));
  app.use(gzippo.compress());
});

require('./routes/routes.js')(app);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port %d in %s mode.", app.get("port"), app.settings.env);
});



