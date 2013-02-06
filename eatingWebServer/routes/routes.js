module.exports = function(app){
	app.get('/',function(req, res){
		res.render('app',{'compressJs':"all.min.js","env":app.get("node-env")});
	});
}