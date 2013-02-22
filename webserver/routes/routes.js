var fs = require('fs');

module.exports = function(app){
	app.get('/',function(req, res){
		res.render('group-list',{'compressJs':"all.min.js","env":app.get("node-env")});
	});

	app.get('/editGroup',function(req, res){
		res.render('edit-group');
	});

	app.get('/success',function(req,res){
		res.render('success');
	});

	app.get('/mybills',function(req,res){
		res.render('mybills');
	});

	app.get('/billdetails',function(req,res){
		res.render('bill-details');
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
	app.get('/todayGroupList',function(req, res){
		res.set('Content-Type: application/json');
		fs.readFile(__dirname+'/../resource/todayGroupList.json','utf-8', function (err,data) {
		  if (err) {
		    return console.log(err);
		  }
		  res.send(200,data);
		});
	});
	app.get('/myOrder',function(req, res){
		res.set('Content-Type: application/json');
		fs.readFile(__dirname+'/../resource/myOrder.json','utf-8', function (err,data) {
		  if (err) {
		    return console.log(err);
		  }
		  res.send(200,data);
		});
	});
	app.get('/groupOrders',function(req, res){
		res.set('Content-Type: application/json');
		fs.readFile(__dirname+'/../resource/groupOrders.json','utf-8', function (err,data) {
		  if (err) {
		    return console.log(err);
		  }
		  res.send(200,data);
		});
	});
}