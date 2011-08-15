$(document).ready(function() {
	
	//slideshow
	$('.slideshow').cycle({ 
	    speed:  'fast', 
	    timeout: 0,
	 	startingSlide: 0,
	    next:   '#next', 
	    prev:   '#prev',
		pager:  '#thumbs',
		pagerAnchorBuilder: function(idx, slide) {					
			return '<div class="thumb"><a href="#"><img src="' + $(slide).find('img').attr('src') + '" width="84" height="84" /></a></div>';
					
		},
		onPrevNextEvent: function(isNext, zero, slide)  {
			var pic = $(slide).attr('rel');	
			$('span.current-pic').html(pic);
		},
		onPagerEvent: function(zero, slide)  {
			var pic = $(slide).attr('rel');	
			$('span.current-pic').html(pic);
		}
		
	});
	

	$('a.first-but').click(function() { 
		// $('#description').animate({width:'toggle'}); 
		$('#description').slideToggle('slow');
		return false;
	});
	
	var countpics =1;
	
	$('div.picture').each(function(){
		$(this).attr({ "rel": countpics});
		// console.log(countpics);
		countpics = countpics +1;
	});
		
	$('#thumbs div').click(function (){		
		$('.slideshow').toggle();
		$('#thumbs').toggle();
		return false;
	});
	
	$('#next, #prev').click(function (){			
		if( $('#thumbs').is(":visible")) {
			$('.slideshow').toggle();
			$('#thumbs').toggle();
		}
	});
	
	$('.thumbs-but').click(function (){			
		$('.slideshow').toggle();
		$('#thumbs').toggle();
		return false;
	});
			
	
	// sort serie list by class menu
	$('#menu').prepend($('li.top-item'));
	$('li.top-item').last().addClass('last');
	$('#menu li').eq(-2).addClass('last');	
	$('#menu li').last().addClass('last');	
	
});

$(document).bind('keypress', function(e) {
	
    if (e.keyCode == 37)
        $('.slideshow').cycle('prev');
     else if (e.keyCode == 39)
        $('.slideshow').cycle('next');
});