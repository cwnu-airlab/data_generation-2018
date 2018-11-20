$(function(){


// 메뉴
	$(".menu > ul > li:not(:has('div'))").addClass('no_sub');

	$('.btn_menu').click(function(e){
		if($(this).hasClass('on')){
			$(this).removeClass('on');		
			$('.menu').slideUp();
			$('.menu').find('.on').removeClass('on'); 
			$('.menu').find('div').slideUp();
		}else{
			$(this).addClass('on');
			$('.menu').slideDown();
		};
		e.preventDefault();
	});

	$('.menu > ul > li > a').click(function(){
		$('.menu').find('.on').not(this).removeClass('on'); 
		$('.menu').find('div').not(this).slideUp();

		if($(this).hasClass('on')){
			$(this).removeClass('on');
			$(this).next('div').slideUp();
		}else{
			$(this).addClass('on');
			$(this).next('div').slideDown();
		};
	});



// 모달 클릭
	$('.btn_modal').click(function(){
		var modal_name = $(this).attr('name');
		open_modal(modal_name);
		return false;
	});


//모달 열기
	open_modal = function(modal_name) {
		
		var modal_id = modal_name;
		$('#'+modal_id).fadeIn('fast');

		modal_position(modal_id);

		$(window).resize(function() {
			modal_position(modal_id);
		});
	};

	model_close = function () {
		('.btn_modal_close, .pop_btnset_foot .type_cancel').click();
	};
	
//모달 닫기
	$('.btn_modal_close, .pop_btnset_foot .type_cancel').click(function(){
		$(this).closest('.modal').fadeOut('fast');
		return false;
	});

//모달위치
	modal_position = function(modal_id) {
		var browser_height = $(window).height()-110;
		$('#'+modal_id).children('.modal_in').children('.modal_cont').css('max-height',browser_height+'px');
		
		var modal_width = $('#'+modal_id).children('.modal_in').outerWidth() / 2;
		var modal_height = $('#'+modal_id).children('.modal_in').outerHeight() / 2;
		$('#'+modal_id).children('.modal_in').css('margin-left','-'+modal_width+'px').css('margin-top','-'+modal_height+'px');
	};

//아코디언
//	$('.label_accordion li:first-child').addClass('on');
//	$('.label_accordion li:first-child .cont_gray').show();
//	$('.btn_label_onoff').click(function(){
//		if(!$(this).closest('li').hasClass('on')){
//			$(this).closest('.label_accordion').find('.cont_gray').slideUp('fast');
//			$(this).closest('.label_accordion').find('li').removeClass('on');
//			$(this).closest('.label_accordion').find('.btn_label_onoff').attr('title','펼치기');
//			$(this).closest('.label_accordion').find('.btn_icon_download_white').hide();
//			$(this).closest('li').addClass('on');
//			$(this).parent().next('.cont_gray').slideDown('fast');
//			$(this).attr('title','');
//			
//			if($(this).closest('li').hasClass('on'))
//			{
//			var info =$(this).closest('li').find('.cont_tit3').find('.btn_icon_download_white ');
//				info.show();
//			}
//			
//			var groupName = $(this).closest('li').attr('id');
//			$("#groupName").val(groupName);
//			$('#namedentity_tree_list').jstree(true).deselect_all();
//			$('#simentic_tree_list').jstree(true).deselect_all();
//			$('#simentic_analysis_tree_list').jstree(true).deselect_all();
//			$('#hate_tree_list').jstree(true).deselect_all();
//		};
//		return false;
//	});

});	

function openPopup(){
    var win = window.open('', 'win', 'width=1, height=1, scrollbars=yes, resizable=yes');
    console.log(win);
	if (win == null || typeof(win) == "undefined" || (win == null && win.outerWidth == 0) || (win != null && win.outerHeight == 0) || win.test == "undefined") {
		alert("팝업 차단 기능이 설정되어있습니다\n\n차단 기능을 해제(팝업허용) 한 후 다시 이용해 주십시오.\n\n만약 팝업 차단 기능을 해제하지 않으면\n정상적인 주문이 이루어지지 않습니다.");
	  if(win){
	    win.close();
	  }
	  return false;
	} else if (win)	{
	} else 	{
	    return false;
	}
	if(win){    // 팝업창이 떠있다면 close();
	    win.close();
	}
	return true;
}    // 함수 끝
