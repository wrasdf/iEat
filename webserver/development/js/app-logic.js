$.mobile.defaultPageTransition = "slidefade";
$(function(){
    
    $('#timePicker').mobiscroll().time({
        theme: 'iOS',
        display: 'inline',
        mode: 'scroller',
        onChange:function(text,b){
        	setValue(b.values);
        }
    });
    
    function setValue(array){
    	$("#show-Time").html(array[0] + " : " + (array[1] == 0 ? ("0"+"0") : array[1] < 9 ? "0"+ array[1] : array[1]) + (array[2] == 1 ? " PM" : " AM"));
    }

    setValue($('#timePicker').mobiscroll("getValue"));

});