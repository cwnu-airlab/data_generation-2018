
var webFontURLs;
var dispatcher;
var bratWin = [];
var bratWinLength;

$(function () { 
	bindDomainTree();
	
	bindEntityTree("namedentity");
	bindEntityTree("simentic");
	bindEntityTree("simentic_analysis");
	bindEntityTree("hate");
	bindbratInit();
	bindAccrodianList();
	$('input[name=label_radio]').change();
//	bratWinLength = 1;
});

function modalConfirm(){
	if ($("#docId").val()) setTimeout("fn_bratView()" , 500);
	$('#modal_type01').fadeOut('fast');
}

function bindbratInit() {
	var bratLocation = contextPath+'/resources/js/brat';
	dispatcher = new Dispatcher();
	
	webFontURLs = [];
}

function bindDomainTree(){
	var domainTree = $('#domain_tree_list');
	
	domainTree.jstree({
		'plugins': ["themes", "html_data", "sort", "ui"]}); 
	domainTree.on("changed.jstree", function(e, data){
        if (data == null || data.selected == null)
            return;
        
        $("#docId").val("");
//        $('#brat_viewer1').removeClass('hasSvg');
//        $("#brat_viewer1").empty();
        $("#domain").val(data.instance.get_path(data.node,'/'));
        $("#colId").val(domainTree.jstree(true).get_selected());
        fn_docList();
	});
	domainTree.jstree('open_all');
	
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
		};
		return false;
	});
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
		
	    var session = sessionStorage.getItem(groupName);
	    
	    if (session) {
	    	entityTree.jstree(true).check_node(session.split(","));
	    } else {
	    	entityTree.jstree('check_all');
	    }
	});
	
	entityTree.on('select_node.jstree', function (e, data) {
		fn_selectEntity();
    });
	
	entityTree.on('deselect_node.jstree', function (e, data) {
		fn_selectEntity();
    });
}

function fn_docList(){
	var searchTerm = $("#docSearchTerm").val();
	var url = contextPath+'/check/labeling/docList.do?_format=json';
	url += '&colId=' + $("#colId").val();
	if (searchTerm) url += '&searchTerm='+encodeURI(searchTerm);
	
	$.ajax({
		url: url,
		success: function (data) {
		    var template =  $.templates("#tmpl_doc");
		    var html = template.render(data);
		    $("#docList").html(html);
		    $("#docCount").html(data.count);
		    setTimeout(function(){
		    	$(".tbl_body_wrap").mCustomScrollbar('update');
		    }, 1000);
		}
    });
}

function fn_bratView(id, groupName){
	$("#brat-loading").show();
	
	if(!groupName){
		groupName = '';
	}
	
	if(groupName == ''){
		groupName = $('input[name=label_radio]:checked').val();
		$("#groupName").val(groupName);
		$('input[name=label_radio]').change();
	} else {
		$('input[name=label_radio]').each(function(){
			if($(this).val() == groupName){
				$(this).attr('checked', 'checked');
			} else {
				$(this).removeAttr('checked')
			}
		});
		$('input[name=label_radio]').change();
	}
	
	var searchTerm = getEntity();
	$("#searchTerm").val(searchTerm);
	
	if (id) {
		$("#docId").val(id);
	}
	
	$.ajax({
		url: contextPath+"/labeling/bratView.do",
		type: "POST",
		data: $("#docInfo").serialize(),
		success: function (data) {
		    var visualizer = new Visualizer(dispatcher, 'brat_viewer1', webFontURLs);
		    
			var collData = {};	
			collData.entity_types = data.collData.entities;
			collData.relation_types = data.collData.relations;
			dispatcher.post('collectionLoaded', [collData]);
			
			var docData = {};
			docData.text = data.docData.text;
			
			docData.entities = data.docData.entities;
			docData.relations = data.docData.relations;
			dispatcher.post('requestRenderData', [docData]); 
			
			setTimeout("$('#brat-loading').hide()" , 500);
		}
    });
}

function fn_selectEntity() {
	var entity = getEntity();
	var groupName = $("#groupName").val();
	
	sessionStorage.setItem(groupName, entity);
	
	var docId = $("#docId").val();
	if (docId.length > 0) {
		fn_bratView(docId);
	}
}

function getEntity(){
	var groupName = $("#groupName").val();
	var entity = "";

	if ($("#"+groupName+"_tree_list_modal").find("li").length > 0) {
		entity = $("#"+groupName+"_tree_list_modal").jstree(true).get_selected();
	}
	
	return entity;
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

window.onunload = windowClose;