jQuery(function($) {

	//Preloader
	var preloader = $('.preloader');
	$(window).load(function(){
		preloader.remove();
	});
	
	//Portfolio
	$(".portfolio-gallery:first a[rel^='prettyPhoto']").prettyPhoto({
		animation_speed:'normal',
		slideshow:3000, 
		autoplay_slideshow: true
	});
});