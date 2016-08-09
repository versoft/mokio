// make console.log safe to use
window.console||(console={log:function(){}});

//window resize events
$(window).resize(function(){
	//get the window size
	var wsize =  $(window).width();
	if (wsize > 980 ) {
		$('.shortcuts.hided').removeClass('hided').attr("style","");
		$('.sidenav.hided').removeClass('hided').attr("style","");
	}

	var size ="Window size is:" + $(window).width();
	//console.log(size);
});

$(window).load(function(){
	var wheight = $(window).height();
	$('#sidebar.scrolled').css('height', wheight-63+'px');
});

$(window).load(function() {
  setTimeout('$(".loader-div").fadeOut("slow");',100);
});

//
// =============== Load animation using Rails Turbolinks ======================
//

	//prevent font flickering in some browsers 
	function prevent_font_flickering() {
		//if firefox 3.5+, hide content till load (or 3 seconds) to prevent FOUT
	  var d = document, e = d.documentElement, s = d.createElement('style');
	  if (e.style.MozTransform === ''){ // gecko 1.9.1 inference
	    s.textContent = 'body{visibility:hidden}';
	    e.firstChild.appendChild(s);
	    function f(){ s.parentNode && s.parentNode.removeChild(s); }
	    addEventListener('load',f,false);
	    setTimeout(f,500); 
	  }
	}

	function start_loadstate() {
		document.documentElement.className += 'loadstate';
		prevent_font_flickering();
	}

	function stop_loadstate() {
		setTimeout('$("html").removeClass("loadstate")',500);
	}

	// document.addEventListener("page:fetch", start_loadstate);
	// document.addEventListener("page:receive", stop_loadstate);

//
// ==============================================================================
//


// document ready page:load using Rails Turbolinks
$(document).on('ready page:load', function(){ 	

	//------------- Switcher code ( Remove it in production site ) -------------//
	// (function(){
	// 	supr_switcher = {
	// 		create : function () {
	// 			//create switcher and inject into html
	// 			$('body').append('<a href="#" id="switchBtn"><span class="icon24 icomoon-icon-cogs"></span></a>');
	// 			$('body').append('<div id="switcher"><h4>Header patterns</h4><div class="header-patterns"><ul><li><a href="#" class="hpat1"><img src="/assets/backend/patterns/header/1.png"></a></li><li><a href="#" class="hpat2"><img src="/assets/backend/patterns/header/2.png"></a></li><li><a href="#" class="hpat3"><img src="/assets/backend/patterns/header/3.png"></a></li><li><a href="#" class="hpat4"><img src="/assets/backend/patterns/header/4.png"></a></li></ul></div><h4>Sidebar patterns</h4><div class="sidebar-patterns"><ul><li><a href="#" class="spat1"><img src="/assets/backend/patterns/sidebar/1.png"></a></li><li><a href="#" class="spat2"><img src="/assets/backend/patterns/sidebar/2.png"></a></li><li><a href="#" class="spat3"><img src="/assets/backend/patterns/sidebar/3.png"></a></li><li><a href="#" class="spat4"><img src="/assets/backend/patterns/sidebar/4.png"></a></li></ul></div><h4>Body patterns</h4><div class="body-patterns"><ul><li><a href="#" class="bpat1"><img src="/assets/backend/patterns/body/1.png"></a></li><li><a href="#" class="bpat2"><img src="/assets/backend/patterns/body/2.png"></a></li><li><a href="#" class="bpat3"><img src="/assets/backend/patterns/body/3.png"></a></li><li><a href="#" class="bpat4"><img src="/assets/backend/patterns/body/4.png"></a></li></ul></div></div>');
	// 		},
	// 		init: function() {
	// 			supr_switcher.create();
	// 			$('#switcher a').click(function() {
	// 				if($(this).hasClass('hpat1')) {$('#header').css('background', 'url(/assets/backend/patterns/header/bedge_grunge.png)');}
	// 				if($(this).hasClass('hpat2')) {$('#header').css('background', 'url(/assets/backend/patterns/header/grid.png)');}
	// 				if($(this).hasClass('hpat3')) {$('#header').css('background', 'url(/assets/backend/patterns/header/nasty_fabric.png)');}
	// 				if($(this).hasClass('hpat4')) {$('#header').css('background', 'url(/assets/backend/patterns/header/natural_paper.png)');}
	// 				if($(this).hasClass('spat1')) {$('#sidebarbg').css('background', 'url(/assets/backend/patterns/sidebar/az_subtle.png)');}
	// 				if($(this).hasClass('spat2')) {$('#sidebarbg').css('background', 'url(/assets/backend/patterns/sidebar/billie_holiday.png)');}
	// 				if($(this).hasClass('spat3')) {$('#sidebarbg').css('background', 'url(/assets/backend/patterns/sidebar/grey.png)');}
	// 				if($(this).hasClass('spat4')) {$('#sidebarbg').css('background', 'url(/assets/backend/patterns/sidebar/noise_lines.png)');}
	// 				if($(this).hasClass('bpat1')) {$('#content').css('background', 'url(/assets/backend/patterns/body/cream_dust.png)');}
	// 				if($(this).hasClass('bpat2')) {$('#content').css('background', 'url(/assets/backend/patterns/body/dust.png)');}
	// 				if($(this).hasClass('bpat3')) {$('#content').css('background', 'url(/assets/backend/patterns/body/grey.png)');}
	// 				if($(this).hasClass('bpat4')) {$('#content').css('background', 'url(/assets/backend/patterns/body/subtle_dots.png)');}					
	// 			});

	// 			$('#switchBtn').click(function() {
	// 				if($(this).hasClass('toggle')) {
	// 					//hide switcher
	// 					$(this).removeClass('toggle').css('right', '-1px');
	// 					$('#switcher').css('display', 'none');

	// 				} else {
	// 					//expand switcher
	// 					$(this).animate({
	// 					    right: '135'
	// 					  }, 200, function() {
	// 					    // Animation complete.
	// 					    $('#switcher').css('display', 'block');
	// 					    $(this).addClass('toggle');
	// 					  });
	// 				}
	// 			});
	// 		}
	// 	}

	// 	supr_switcher.init();

	// })();
	
  	//Disable certain links
    $('a[href^=\\#]').click(function (e) {
      e.preventDefault()
    })

    $('.search-btn').addClass('nostyle');//tell uniform to not style this element

 
	//------------- Navigation -------------//

	mainNav = $('.mainnav>ul>li');
	mainNav.find('ul').siblings().addClass('hasUl').append('<span class="hasDrop icon16 icomoon-icon-arrow-down-2"></span>');
	mainNavLink = mainNav.find('a').not('.sub a');
	mainNavLinkAll = mainNav.find('a');
	mainNavSubLink = mainNav.find('.sub a').not('.sub li .sub a');
	mainNavCurrent = mainNav.find('a.current');

	/*Auto current system in main navigation */
	var domain = document.domain;
	var absoluteUrl = 0; //put value of 1 if use absolute path links. example http://www.host.com/dashboard instead of /dashboard

	function setCurrentClass(mainNavLinkAll, url) {
		mainNavLinkAll.each(function(index) {
			//convert href to array and get last element
			var href= $(this).attr('href');

			if(href == url) {
				//set new current class
				$(this).addClass('current');

				ulElem = $(this).closest('ul');
				if(ulElem.hasClass('sub')) {
					//its a part of sub menu need to expand this menu
					aElem = ulElem.prev('a.hasUl').addClass('drop');
					ulElem.addClass('expand');
				} 
			}
		});
	}


	if(domain === '') {
		//domain not found
		var pageUrl = window.location.pathname.split( '/' );
		var winLoc = pageUrl.pop(); // get last item

		setCurrentClass(mainNavLinkAll, winLoc);

	} else {
		if(absoluteUrl === 0) {
			//absolute url is disabled
			var afterDomain = window.location.pathname;
			
			setCurrentClass(mainNavLinkAll, afterDomain);
		
		} else {
			//absolute url is enabled
			var newDomain = 'http://' + domain + window.location.pathname;
			
			setCurrentClass(mainNavLinkAll, newDomain);
		}
	}

	//hover magic add blue color to icons when hover - remove or change the class if not you like.
	mainNavLinkAll.hover(
	  function () {
	    $(this).find('span.icon16').addClass('red');
	  }, 
	  function () {
	    $(this).find('span.icon16').removeClass('red');
	  }
	);

	//click magic
	mainNavLink.click(function(event) {
		$this = $(this);
		console.log($this)
		if($this.hasClass('hasUl')) {
			event.preventDefault();
			if($this.hasClass('drop')) {
				$(this).siblings('ul.sub').slideUp(500).siblings().removeClass('drop');
			} else {
				$(this).siblings('ul.sub').slideDown(500).siblings().addClass('drop');
			}			
		} 
	});
	mainNavSubLink.click(function(event) {
		$this = $(this);
		
		if($this.hasClass('hasUl')) {
			event.preventDefault();
			if($this.hasClass('drop')) {
				$(this).siblings('ul.sub').slideUp(500).siblings().removeClass('drop');
			} else {
				$(this).siblings('ul.sub').slideDown(250).siblings().addClass('drop');
			}			
		} 
	});

	//responsive buttons
	$('.resBtn>a').click(function(event) {
		$this = $(this);
		if($this.hasClass('drop')) {

			$('#header').css({'overflow-x': 'visible', 'width' : 'auto'});
			$('#header').animate({ 'margin-left' : '0'}, 300, function() {});
			$('#content').css({'overflow-x': 'visible', 'width' : 'auto'});
			$('#content').animate({ 'margin-left' : '0'}, 300, function() {});

			$('#sidebar>.shortcuts').slideUp(200).addClass('hided');
			$('#sidebar>.sidenav').slideUp(200).addClass('hided');
			$('#sidebar>.sidebar-widget').slideUp(200);

			$('#sidebar-right>.shortcuts').slideUp(200).addClass('hided');
			$('#sidebar-right>.sidenav').slideUp(200).addClass('hided');
			$('#sidebar-right>.sidebar-widget').slideUp(200);

			$('#sidebarbg').css('display', 'none');
			$('.resBtn').removeClass('offCanvas');

			$this.removeClass('drop');
		} else {
			if($('#sidebar').length) {
				$('#sidebar').css('display', 'block');
				if($('#sidebar-right').length) {
					$('#sidebar-right').css({'display' : 'block', 'margin-top' : '0'});
				}
			}
			if($('#sidebar-right').length) {
				$('#sidebar-right').css('display', 'block');
			}
			
			$('#header').css({'overflow-x': 'hidden', 'width' : '100%'});
			$('#header').animate({ 'margin-left' : '240px'}, 300, function() {});
			$('#content').css({'overflow-x': 'hidden', 'width' : '100%'});
			$('#content').animate({ 'margin-left' : '240px'}, 300, function() {});

			$('#sidebar>.shortcuts').slideDown(250);
			$('#sidebar>.sidenav').slideDown(250);
			$('#sidebar>.sidebar-widget').slideDown(250);

			$('#sidebar-right>.shortcuts').slideDown(250);
			$('#sidebar-right>.sidenav').slideDown(250);
			$('#sidebar-right>.sidebar-widget').slideDown(250);

			$('#sidebarbg').css('display', 'block');
			$('.resBtn').addClass('offCanvas');
			
			$this.addClass('drop');
		}
	});

	$('.resBtnSearch>a').click(function(event) {
		$this = $(this);
		if($this.hasClass('drop')) {
			$('.search').slideUp(500);
			$this.removeClass('drop');
		} else {
			$('.search').slideDown(250);
			$this.addClass('drop');
		}
	});
	
	//Hide and show sidebar btn

	$(function () {
		//var pages = ['grid.html','charts.html'];
		var pages = [];
	
		for ( var i = 0, j = pages.length; i < j; i++ ) {

		    if($.cookie("currentPage") == pages[i]) {
				var cBtn = $('.collapseBtn.leftbar');
				cBtn.children('a').attr('title','Show Left Sidebar');
				cBtn.addClass('shadow hide');
				cBtn.css({'top': '20px', 'left':'200px'});
				$('#sidebarbg').css('margin-left','-299'+'px');
				$('#sidebar').css('margin-left','-299'+'px');
				if($('#content').length) {
					$('#content').css('margin-left', '0');
				}
				if($('#content-two').length) {
					$('#content-two').css('margin-left', '0');
				}
		    }

		}
		
	});

	$( '.collapseBtn' ).bind( 'click', function(){
		$this = $(this);

		//left sidbar clicked
		if ($this.hasClass('leftbar')) {
			
			if($(this).hasClass('hide')) {
				//show sidebar
				$('#sidebarbg').css('margin-left','0');
				$('#content').css('margin-left', '240'+'px');
				$('#content-two').css('margin-left', '240'+'px');
				$('#sidebar').css({'left' : '0', 'margin-left' : '0'});

				$this.removeClass('hide');
				$('.collapseBtn.leftbar').animate({
						top: '125',
						left: '200'
					}, 500, 'easeInExpo', function() {
					$(this).removeClass('shadow');
				})

				$this.children('a').attr('title','Hide Left Sidebar');

			} else {
				//hide sidebar
				$('#sidebarbg').css('margin-left','-299'+'px');
				$('#sidebar').css('margin-left','-299'+'px');
				$('.collapseBtn.leftbar').animate({ //use .hide() if you experience heavy animation :)
 				    left: '20',
				    top: '87'
				  }, 500, 'easeInExpo', function() {
					    // Animation complete.
				  
				}).addClass('shadow');
				//expand content
				$this.addClass('hide');
				$this.children('a').attr('title','Show Left Sidebar');
				if($('#content').length) {
					$('#content').css('margin-left', '0');
				}
				if($('#content-two').length) {
					$('#content-two').css('margin-left', '0');
				}
							
			}

		}

		//right sidebar clicked
		if ($this.hasClass('rightbar')) {
			
			if($(this).hasClass('hide')) {
				//show sidebar
				$('#sidebarbg-right').css('margin-right','0');
				$('#sidebar-right').css({'right' : '0', 'margin-right' : '0'});
				if($('#content').length) {
					$('#content').css('margin-left', '213'+'px');
				}
				if($('#content-one').length) {
					$('#content-one').css('margin-right', '212'+'px');
				}
				if($('#content-two').length) {
					$('#content-two').css({'margin-right' : '212' + 'px'});
				}			
				/*if($('#sidebar').length) {
					$('#sidebar').css({'left' : '0', 'margin-left' : '0'});
				}*/
				$this.removeClass('hide');
				$('.collapseBtn.rightbar').css('top', '120'+'px').css('right', '18'+'px').removeClass('shadow');
				$this.children('a').attr('title','Hide Right Sidebar');
				
			} else {
				//hide sidebar
				$('#sidebarbg-right').css('margin-right','-299'+'px');			
				$('#sidebar-right').css('margin-right','-299'+'px');
				if($('#content').length) {
					$('#content').css('margin-right', '0');
				}
				if($('#content-one').length) {
					$('#content-one').css({'margin-left': '0', 'margin-right' : '0'});
				}
				if($('#content-two').length) {
					$('#content-two').css({'margin-right' : '0'});
				}	
				$('.collapseBtn.rightbar').animate({ //use .hide() if you experience heavy animation :)
				    right: '10',
				    top: '78'
				  }, 500, 'easeInExpo', function() {
				    // Animation complete.
				  
				}).addClass('shadow');
				//expand content
				$this.addClass('hide');
				$this.children('a').attr('title','Show Right Sidebar')
			}

		}
	});


	//------------- widget box magic -------------//

	var widget = $('div.box');
	var widgetOpen = $('div.box').not('div.box.closed');
	var widgetClose = $('div.box.closed');
	//close all widgets with class "closed"
	widgetClose.find('div.content').hide();
	widgetClose.find('.title>.minimize').removeClass('minimize').addClass('maximize');

	widget.find('.title>a').click(function (event) {
		event.preventDefault();
		var $this = $(this);
		if($this .hasClass('minimize')) {
			//minimize content
			$this.removeClass('minimize').addClass('maximize');
			$this.parent('div').addClass('min');
			cont = $this.parent('div').next('div.content')
			cont.slideUp(500, 'easeOutExpo'); //change effect if you want :)
			
		} else  
		if($this .hasClass('maximize')) {
			//minimize content
			$this.removeClass('maximize').addClass('minimize');
			$this.parent('div').removeClass('min');
			cont = $this.parent('div').next('div.content');
			cont.slideDown(500, 'easeInExpo'); //change effect if you want :)
		} 
		
	})

	//show minimize and maximize icons
	widget.hover(function() {
		    $(this).find('.title>a').show(50);	
		}
		, function(){
			$(this).find('.title>a').hide();	
	});

	//add shadow if hover box
	widget.not('.drag').hover(function() {
		    $(this).addClass('hover');	
		}
		, function(){
			$(this).removeClass('hover');	
	});

	//------------- placeholder fallback  -------------//
	$('input[placeholder], textarea[placeholder]').placeholder();

	//------------- Search forms  submit handler  -------------//
	$('#tipue_search_input').tipuesearch({
          'show': 5
     });
	$('#search-form').submit(function() {
	  return false;
	});

	//make custom redirect for search form in .heading
	$('#searchform').submit(function() {
        var sText = $('.top-search').val();
        var sAction = $(this).attr('action');
        if (! sAction == 'undefined') {
            var sUrl = sAction + '?q=' + sText;
            $(location).attr('href', sUrl);
        }
		return false;
	});

	//------------- To top plugin  -------------//
	$().UItoTop({ 
		//containerID: 'toTop', // fading element id
		//containerHoverID: 'toTopHover', // fading element hover id
		//scrollSpeed: 1200,
		easingType: 'easeOutQuart' 
	});

	//------------- Tooltips -------------//

	//top tooltip
	$('.home_page').qtip({
		content: false,
		position: {
			my: 'bottom center',
			at: 'top center',
			viewport: $(window)
		},
		style: {
			classes: 'qtip-tipsy'
		}
	});

	//tooltip in right
	$('.tipR').qtip({
		content: false,
		position: {
			my: 'left center',
			at: 'right center',
			viewport: $(window)
		},
		style: {
			classes: 'qtip-tipsy'
		}
	});

	//tooltip in bottom
	$('.tipB').qtip({
		content: false,
		position: {
			my: 'top center',
			at: 'bottom center',
			viewport: $(window)
		},
		style: {
			classes: 'qtip-tipsy'
		}
	});

	//tooltip in left
	$('.tipL').qtip({
		content: false,
		position: {
			my: 'right center',
			at: 'left center',
			viewport: $(window)
		},
		style: {
			classes: 'qtip-tipsy'
		}
	});

	$('.error input').css("border-color", "#ff3333");
  $('.activebtn').bootstrapSwitch()
             .bootstrapSwitch('setOnClass', 'success')
             .bootstrapSwitch('setOffClass', 'danger')
             .bootstrapSwitch('setSizeClass', 'switch-small');

	var inputWdith = '250px';
	var inputWdithReturn = '206px';
	$('#dTable_filter input').focus(function(){
	    //animate the box
	    $(this).animate({
	        width: inputWdith
	    }, 300 );
	}); 

	$('#dTable_filter input').blur(function(){
	    $(this).animate({
	        width: inputWdithReturn
	    }, 300 );
	});

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });
});

function decode_utf8(s) {
  return decodeURIComponent(s.replace(/\+/g, " "));
}

$(document).ajaxComplete(function(event, request) {
  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5();
  });

  var flash = JSON.parse(request.getResponseHeader('X-Flash-Messages'));

  if (!flash) return;

  if (flash.notice) {
		$.pnotify({
			type: 'success',
		    title: '',
    		text: decode_utf8(flash.notice),
		    icon: 'picon icon16 iconic-icon-check-alt white',
		    opacity: 0.95,
		    history: false,
		    sticker: false
		});
  }
  if (flash.error) {
		$.pnotify({
			type: 'error',
		    title: '',
    		text: decode_utf8(flash.error),
		    icon: 'picon icon24 typ-icon-cancel white',
		    opacity: 0.95,
		    history: false,
		    sticker: false
		}); 	
  }
  if (flash.info) {
		$.pnotify({
			type: 'info',
		    title: '',
   			text: decode_utf8(flash.info),
		    icon: 'picon icon16 brocco-icon-info white',
		    hide: false,
		    opacity: 0.95,
		    history: false,
		    sticker: false
		});	
  }
});
