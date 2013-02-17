var fs = require('fs');

module.exports = function(app){
	app.get('/',function(req, res){
		res.render('app',{'compressJs':"all.min.js","env":app.get("node-env")});
	});
	app.get('/restaurants',function(req, res){
		res.set('Content-Type: application/json');
		fs.readFile(__dirname+'/../resource/restaurant.json','utf-8', function (err,data) {
		  if (err) {
		    return console.log(err);
		  }
		  res.send(200,data);
		});
	});
}