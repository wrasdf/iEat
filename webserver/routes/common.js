var $ = (function(){

	function guid() {
	    function S4() {
	       return (((1 + Math.random()) * 0x10000) | 0).toString(16).substring(1);
	    }
	    return (S4() + S4() + "-" + S4() + "-" + S4() + "-" + S4() + "-" + S4() + S4() + S4());
	}

	function extend(target,source){
		target = target || {};
		for (var prop in source) {
			target[prop] = source[prop];
		}
		return target;
	}

	function readJson(path,callback){
		
	}

	return {
		guid : guid,
		extend : extend
	}

})();

module.exports = {
	$ : $
};