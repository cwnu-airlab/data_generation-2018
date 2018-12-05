
var webFontURLs;
var dispatcher;
var bratWin = [];
var bratWinLength = 0;
var keywordLoc;
var keywordnum;

$(function () { 
	bindEntityTree("namedentity");
	bindEntityTree("simentic");
	bindEntityTree("simentic_analysis");
	bindEntityTree("hate");
	
	bindbratInit();
	bindAccrodianList();
	$('input[name=label_radio]').change();
	$('#searchTermInfo').keyup(function(e){
		var searchTerm = $(this).val();
		if($.trim(searchTerm) == ''){
			if($.trim($('#searchTerm').val()) != ''){
				$('#searchTerm').val('');
			}
			fn_getKeyword();
			fn_LabelingDoc(searchTerm);
		}
	})
});

function modalConfirm(){
	fn_getKeyword();
	if ($("#docId").val()) setTimeout("fn_bratView()" , 500);
	$('#modal_type01').fadeOut('fast');
}

function bindbratInit() {
	var bratLocation = contextPath+'/resources/js/brat';
	dispatcher = new Dispatcher();
	webFontURLs = [];
}

function bindEntityTree(groupName){
	var entityTree = $('#'+groupName+'_tree_list_modal');
	
	entityTree.jstree({
		'plugins': ["themes", "html_data", "sort", "ui", "checkbox","types"] ,
		'checkbox': {
            'keep_selected_style': false
		} ,
		'types': {
            'default': {
                'icon': contextPath+'/resources/images/common/tag_blue.png'
            }
        },
	});
	
	entityTree.on("ready.jstree", function() {
		entityTree.jstree('open_all');
	});
	
	entityTree.on('changed.jstree', function (e, data) {
		var i, j, r = [];
		
		if (data.selected.length == 0) {
			 $('#entity').val("");
		}
        for (i = 0, j = data.selected.length; i < j; i++) {
            r.push(data.instance.get_path(data.selected[i],'/'));
            $('#entity').val(r.join(', '));
        }
	});
	
}

function bindAccrodianList() {
	$('input[name=label_radio]').change(function(){
		if($(this).is(':checked')){
			var groupName = $(this).val();
			
			if (groupName == 'namedentity') {
				$("#labelingGroup").html("개체명");
			} else if (groupName == 'simentic') {
				$("#labelingGroup").html("의미역");
			} else if (groupName == 'simentic_analysis') {
				$("#labelingGroup").html("의미분석");
			} else if (groupName == 'hate') {
				$("#labelingGroup").html("혐오발언");
			}
			$('#groupName').val(groupName);
			$('div[id$=_tree_list_modal]').hide();
			$('#'+groupName+'_tree_list_modal').show();
			var tree = $("#"+groupName+"_tree_list_modal");
			var selectedData = tree.jstree('get_selected', true);
			var arr = []
			if(selectedData.length >= 1){
				for(var i = 0 ; i < selectedData.length ; i++) {
					arr.push(tree.jstree(true).get_path(selectedData[i],"/"))
				}
				$('#entity').val(arr.join(', '));
			} else {
				$('#entity').val('');
			}
		};
		return false;
	});
}

function fn_unlabeling() {
	if ($(":checkbox[name=labelingDoc]:checked").length==0) {
		alert("삭제할 항목을 하나이상 체크해주세요.");
	    return;
	}
	
	if (confirm('문서에 대한 언레이블링 처리를 하시겠습니까? 관련된 관계도 모두 언레이블링됩니다.')) {
		$("#div-loading").show();
		
		var docList = new Array();
	  	$(":checkbox[name='labelingDoc']:checked").each(function(i){
	  		docList.push($(this).val());
	    });
	  	fn_deleteLabeling(docId, 0);
	}
  
}

function fn_worngUnlabeling() {
	if ($(":checkbox[name=worngLabelingDoc]:checked").length==0) {
		alert("삭제할 항목을 하나이상 체크해주세요.");
	    return;
	}
	
	if (confirm('문서에 대한 언레이블링 처리를 하시겠습니까? 관련된 관계도 모두 언레이블링됩니다.')) {
		$("#div-loading").show();
		
		var docList = new Array();
	  	$(":checkbox[name=worngLabelingDoc]:checked").each(function(i){
	  		docList.push($(this).val());
	    });
	  	fn_deleteLabeling(docId, 1);
	}
}

function fn_deleteLabeling(docId, worngLabeled){
  	var keyword = $("#keyword").val();
  	var groupName = $("#groupName").val();
  	var entity = getEntity(groupName);
  	var url =contextPath+'/check/entity/unlabeling.do?_format=json';
	url += '&docId='+encodeURI(docList);
	url += '&keyword='+encodeURI(keyword);
	url += '&groupName='+encodeURI(groupName);
	url += '&name=' + encodeURI(entity);
	hrl += "&worngLabeled=" + encodeURI(worngLabeled);

	$.ajax({
		url: url,
		success: function (data) {
		   alert('언레이블링 처리가 완료되었습니다.');
		   fn_LabelingDoc(keyword);
		},
		error: function (request,status,error) {
			alert('에러가 발생하였습니다. 관리자에게 문의해주세요.');
	        console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		},
		complete:function () {
			$("#div-loading").hide();
		}
    });
}

function fn_keywordSort(field){
	
	var groupName = $("#groupName").val();
	var entity = getEntity(groupName);
	var searchTerm = $("#searchTerm").val();
	
	if (entity != '' && typeof entity != 'undefined') {
		var sortFlag = $('#sort_'+field).html();
		var sortOption = 'asc'
		if(sortFlag == '▲' || sortFlag == '-'){
			sortOption = 'desc'
		} else {
			sortOption = 'asc'
		}
		
		
		var url =contextPath+'/check/entity/keywordList.do?_format=json';
		url += '&groupName='+encodeURI(groupName);
		url += '&entity='+encodeURI(entity);
		
		if (searchTerm) {
			url += '&searchTerm='+encodeURI(searchTerm);
		}
		url += '&orderField='+encodeURI(field);
		url += '&orderOpt='+encodeURI(sortOption);
		$.ajax({
			url: url,
			beforeSend : function(){
				$("#keyword-loading").show();
			},
			success: function (data) {
//				data.searchTerm = searchTerm
				var tagInfo = data.selectEntityDesc;
			    var tagName = '';
			    var kTagName = '';
			    if(tagInfo.length == 1){
			    	tagName = tagInfo[0].name+'로';
			    	kTagName= tagInfo[0].name;
			    } else {
			    	tagName = tagInfo[0].name + '등으로';
			    	kTagName = tagInfo[0].name + '등';
			    }
				
			    $("#labelingDocTag").html(tagName);
		    	$("#wLabelingDocTag").html(tagName);
		    	$('#selectTag').html(' / '+kTagName);
			    var template =  $.templates("#tmpl_keyword");
			    var html = template.render(data);
			    
			    $("#keywordList").html(html);
			    $("#keywordListCount").text(data.keywordListCount);
			    if(searchTerm != ''){
		    		$('#keyword_'+replaceIdText(searchTerm)).addClass('on');
			    } else {
			    	searchTerm = $("#searchTermInfo").val()
			    	if(searchTerm != ''){
			    		$('#keyword_'+replaceIdText(searchTerm)).addClass('on');
			    	}
			    }
			},
			complete : function (){
				$('a[id^=sort]').html('-');
				
				if(sortOption == 'desc'){
					$('#sort_'+field).html('▼');
				} else {
					$('#sort_'+field).html('▲');
				}
				
				setTimeout(function(){
			    	$(".tbl_body_wrap").mCustomScrollbar('update');
			    	$("#keyword-loading").hide();
			    }, 1000);
			}
	    });
	} else {
		$("#labelingDocTag").html('');
	   	$("#wLabelingDocTag").html('');
	    $("#unLabelingList").html('');
	}
	
}


function fn_getKeyword() {
	$("#keywordList").html('');
	
	var groupName = $("#groupName").val();
	var entity = getEntity(groupName);
	var searchTerm = $("#searchTerm").val();
	
	if (entity != '' && typeof entity != 'undefined') {
		var url =contextPath+'/check/entity/keywordList.do?_format=json';
		url += '&groupName='+encodeURI(groupName);
		url += '&entity='+encodeURI(entity);
		
		if (searchTerm) {
			url += '&searchTerm='+encodeURI(searchTerm);
		}
		
		$.ajax({
			url: url,
			beforeSend : function(){
				$("#keyword-loading").show();
			},
			success: function (data) {
//				data.searchTerm = searchTerm
				var tagInfo = data.selectEntityDesc;
			    var tagName = '';
			    var kTagName = '';
			    if(tagInfo.length == 1){
			    	tagName = tagInfo[0].name+'로';
			    	kTagName= tagInfo[0].name;
			    } else {
			    	tagName = tagInfo[0].name + '등으로';
			    	kTagName = tagInfo[0].name + '등';
			    }
				
			    $("#labelingDocTag").html(tagName);
		    	$("#wLabelingDocTag").html(tagName);
		    	$('#selectTag').html(' / '+kTagName);
			    var template =  $.templates("#tmpl_keyword");
			    var html = template.render(data);
			    
			    $("#keywordList").html(html);
			    $("#keywordListCount").text(data.keywordListCount);
			    if(searchTerm != ''){
			    	$('#keyword_'+replaceIdText(searchTerm)).addClass('on');
			    }
			},
			complete : function (){
				setTimeout(function(){
			    	$(".tbl_body_wrap").mCustomScrollbar('update');
			    	$("#keyword-loading").hide();
			    }, 1000);
			}
	    });
	} else {
	    $("#labelingDocTag").html('');
	   	$("#wLabelingDocTag").html('');
	    $("#unLabelingList").html('');
	}
	
}

function fn_search() {
	var entity = $("#entity").val();
	if (entity == '' || typeof entity == 'undefined') {
		alert('개체명을 선택해주세요.');
		return;
	} 
	
	var content = $("#searchTermInfo").val();
	if (content == '' || typeof content == 'undefined') {
		alert('키워드를 입력해주세요');
		$("#searchTermInfo").focus();
		return;
	} 
	$('#searchTerm').val(content);
	fn_getKeyword();
	fn_LabelingDoc(content);
}

function fn_LabelingDoc(content) {
	var groupName = $("#groupName").val();
	var entity = getEntity(groupName);
	var url =contextPath+'/check/entity/docList.do?_format=json';
	url += '&groupName='+encodeURI(groupName);
	url += '&content='+encodeURI(content);
	url += '&name='+encodeURI(entity);
	url += '&searchKeyword='+encodeURI(content);
	
	$.ajax({
		url: url,
		beforeSend : function(){
			  $('tr[id^=keyword_]').removeClass('on');
			  $('#keyword_'+replaceIdText(content)).addClass('on');
			  $('#searchTermInfo').val(content);
		},
		success: function (data) {
		    var template =  $.templates("#tmpl_labelingDoc");
		    var html = template.render(data);
		    $("#labelingList").html(html);
		    $("#labelingListCount").text(data.labelingListCount);
		    setTimeout(function(){
		    	$(".tbl_body_wrap").mCustomScrollbar('update');
		    }, 1000);
		    
		    var template =  $.templates("#tmpl_worngLabelingDoc");
		    var html = template.render(data);
		    $("#worngLabelingList").html(html);
		    $("#worngLabelingListCount").text(data.worngLabelingListCount);
		    setTimeout(function(){
		    	$(".tbl_body_wrap").mCustomScrollbar('update');
		    }, 1000);
		    
		    
		    $("#toggleLablingDocCheck").click(function() {
				var value = $(this).is(":checked");

				$("input[name=labelingDoc]:checkbox").each(function() {
					$(this).prop("checked", value);
				});
			});
			
			$("input[name=labelingDoc]:checkbox").click(function(){
				if($("input[name=labelingDoc]:checkbox").length == $('input[name=labelingDoc]:checkbox:checked').length){
					$("#toggleLablingDocCheck").prop('checked', true);
				} else {
					$("#toggleLablingDocCheck").prop('checked', false);
				}
			})
			
			
			
			$("#toggleWorngLablingDocCheck").click(function() {
				var value = $(this).is(":checked");

				$("input[name=worngLabelingDoc]:checkbox").each(function() {
					$(this).prop("checked", value);
				});
			});
			
			$("input[name=worngLabelingDoc]:checkbox").click(function(){
				if($("input[name=worngLabelingDoc]:checkbox").length == $('input[name=worngLabelingDoc]:checkbox:checked').length){
					$("#toggleWorngLablingDocCheck").prop('checked', true);
				} else {
					$("#toggleWorngLablingDocCheck").prop('checked', false);
				}
			})
			
		    
		    template =  $.templates("#tmpl_unLabelingDoc");
		    html = template.render(data);
		    $("#unLabelingList").html(html);
		    $("#unlabelingListCount").text(data.unlabelingListCount);
		    $("#labelingCount").text(data.lableingCount);
		    $("#wLabelingCount").text(data.worngLabelingCount);
		    $("#keyword").val(content);
		    setTimeout(function(){
		    	$(".tbl_body_wrap").mCustomScrollbar('update');
		    }, 1000);
		}
    });
}

function fn_bratEdit() {
	var docId = $("#docId").val();
	if (docId) {
		$.ajax({
			url: contextPath+"/labeling/bratEdit.do",
			type: "POST",
			data: $("#docInfo").serialize(),
			success: function (data) {
				if(!openPopup()){
					
					var path = data.map.filePath;
					var idx = path.lastIndexOf("/");
					path = path.substring(0,idx);
					
					$.ajax({
						url: contextPath+"/labeling/deleteFile.do",
						type: "POST",
						data: {"path":path},
						success: function (data) {
						},
						complete: function () {
							//setTimeout("window.close();",200);
						}
					});
					return;
				}
				
				if (data.map.userId != '' && typeof data.map.userId != 'undefined') {
					if (!confirm("해당 파일은 [ID: "+data.map.userId+"]님이 편집중입니다. 읽기전용으로 열립니다."))
						return;
				}
							
				bratWin[bratWinLength] = window.open("about:blank", 'TEST_POPUP',"width=800,height=600");
				
				$("#winNum").val(bratWinLength);
				var bratPath = contextPath+"/brat/#/"+data.map.filePath;
				bratWin[bratWinLength].location.href = bratPath;
				if (data.map.userId != '' && typeof data.map.userId != 'undefined') {
					$("#docType").val("readOnly");
				} else {
					$("#docType").val("edit");
				}
				//2017.11.22 number40 레이블링 점수 추가
				$("#labelGrade").val(data.map.labelGrade);
				bratWinLength++;
			}
		});
	} else {
		alert("문서를 선택해주세요");
	}
}


function fn_bratView(type, docId, recordId){
	$("#brat-loading").show();
	var groupName = $("#groupName").val();
	var entity = getEntity(groupName);
	$.ajax({
		url: contextPath+"/labeling/bratView.do",
		type: "POST",
		data: {"docId":docId, "groupName":groupName, "recordId":recordId},
		success: function (data) {
			keywordnum = 0;
		    var visualizer = new Visualizer(dispatcher, 'brat_viewer1', webFontURLs);
		    
			var collData = {};	
			collData.entity_types = data.collData.entities;
			collData.relation_types = data.collData.relations;
			
			var docData = {};
			docData.text = data.docData.text;
			
			docData.entities = data.docData.entities;
			docData.relations = data.docData.relations;
			
			dispatcher.post('collectionLoaded', [collData]);
			dispatcher.post('requestRenderData', [docData]); 
			
			setTimeout("$('#brat-loading').hide()" , 500);
			$("#docSubject").text(""+$("#doc_"+docId).text()+".txt");
			
			$("#docId").val(docId);
			$("#docGroupName").val(groupName);
			
			
			$('#entityTagInfo').val(entity.join(','));
			$('#labelingType').val(type);
			
			$("#btn_keywordPrev").css("visibility","hidden");
			$("#btn_keywordNext").css("visibility","hidden");
			
			if (type == 'labeling' || type == 'wlabeling') {
				
				setTimeout("fn_keyowrdLoc();",1000);
			}
		}
    });
}

function fn_keyowrdLoc() {
	$.ajax({
		url: contextPath+"/labeling/entityLoc.do",
		type: "POST",
		data: $("#docInfo").serialize(),
		success: function (data) {
			keywordLoc = data.keywordLoc;
			
			if (keywordLoc.length > 0) {
				for (var i=0; i<keywordLoc.length; i++) {
					$("rect[id='H_"+keywordLoc[i]+"']").attr("stroke","red");
					$("rect[id='H_"+keywordLoc[i]+"']").attr("stroke-width","3");
				}
				fn_keywordScroll(keywordnum);
			}
			
		}
    });
}

function fn_keywordScroll(num) {

	$("#btn_keywordPrev").css("visibility","hidden");
	$("#btn_keywordNext").css("visibility","hidden");
	
	var bratHeight = $("#brat_viewer1").height();
	if (bratHeight <= 550) {
		return;
	}
	
	var offset = $("tspan[id*='"+keywordLoc[num]+"']").attr("y");
	$("#brat_scroll").animate({scrollTop : offset-150}, 400);
	
	if (num != 0) {
		$("#btn_keywordPrev").css("visibility","visible");
	}
	if (num != (keywordLoc.length-1)) {
		$("#btn_keywordNext").css("visibility","visible");
	}
}

function fn_keywordPrev() {
	if (keywordnum == 0) {
		alert("이동할 키워드가 없습니다.");
		return;
	}

	keywordnum--;
	fn_keywordScroll(keywordnum);
}

function fn_keywordNext() {
	if (keywordnum == (keywordLoc.length-1)) {
		alert("이동할 키워드가 없습니다.");
		return;
	}
	
	keywordnum++;
	fn_keywordScroll(keywordnum);
}

function fn_bratDetailView() {
	var docId = $("#docId").val();
	
	if (docId) {
		bratWin[bratWinLength] = window.open('about:blank');
		$.ajax({
			url: contextPath+"/check/entity/bratDetailView.do",
			type: "POST",
			data: $("#docInfo").serialize(),
			success: function (data) {
				var bratPath = contextPath+"/brat/#/"+data.map.filePath;

				$("#docType").val("readOnly");
				$("#winNum").val(bratWinLength);
				bratWin[bratWinLength].location.href = bratPath;
				bratWinLength++;
			}
		});
	} else {
		alert("문서를 선택해주세요");
	}
}


function fn_fileDelete(winNum,path) {
	if (!bratWin[winNum].closed) {
		return;
	}
	
	var idx = path.lastIndexOf("/");
	path = path.substring(0,idx);
	
	$.ajax({
		url: contextPath+"/labeling/deleteFile.do",
		type: "POST",
		data: {"path":path},
		success: function (data) {
		}
	});
}

function bratSetting(winNum,docType){
	if (!bratWin[winNum].closed) {
		$("#winNum").val(winNum);
		$("#docType").val(docType);
	}
}

function bratWindowClose(docInfo) {
	setTimeout("fn_fileDelete('"+docInfo.winNum+"','"+docInfo.path+"')",200);
	setTimeout("bratSetting('"+docInfo.winNum+"','"+docInfo.docType+"')",200);
}

function windowClose() {  
	for (var i=0;i<bratWin.length;i++) {
        if (bratWin[i] && !bratWin[i].closed) {
        	bratWin[i].bratClose();
        }
    }
}

function getEntity(groupName){
	console.log(groupName)
	var entity = "";
	if ($("#"+groupName+"_tree_list_modal").find("li").length > 0) {
		entity = $("#"+groupName+"_tree_list_modal").jstree(true).get_selected();
	}
	console.log(entity)
	return entity;
}
window.onunload = windowClose;