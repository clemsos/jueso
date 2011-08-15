//= require jquery
//= require jquery_ujs
//= require jquery-ui

jQuery(document).ready(function($) {

// popup login
$('#login-popup').dialog({autoOpen: false});
	
$('a.login').click(function(){
	$('#login-popup').dialog('open');
	return false;
})


//menu
$("#top-menu li").mouseover(function(){ 
       $(this).find("ul.sub-menu").show();
   });  
 
   $("#top-menu li").mouseout(function(){  
       $(this).find("ul.sub-menu").hide();
   });


$('.feat-utils a').click(function(){
	return false;
});




$("li.user").mouseover(function(){ 
       $(this).find(".details").show();
   });  
 
   $("li.user").mouseout(function(){  
       $(this).find(".details").hide();
   });

})