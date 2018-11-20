
$(function () { 
	bindDomainTree();
	bindToggleCheckbox();
	bindAutoLabeling();
	//bindAutoLabelingAll();
	
	$("input:radio[name=lableingGroupName]").change(function() {
		console.log($(this).val())
//		$("#searchForm").submit();
	 });
});

function bindDomainTree(){
	var domainTree = $('#domain_tree_list');
	
	domainTree.jstree({
		'plugins': ["themes", "html_data", "sort", "ui"]}); 
	
	domainTree.on("select_node.jstree", function(e, data){
        if (data == null || data.selected == null)
            return;
        $("#domain").val(data.instance.get_path(data.node,'/'));
        $("#colId").val(domainTree.jstree(true).get_selected());
        $("#searchForm").submit();
	});
	domainTree.jstree('open_all');
}

function bindToggleCheckbox() {
	$(".toggle_checkbox").click(function() {
		var value = $(this).is(":checked");

		$("input[name=docIds]:checkbox").each(function() {
			$(this).prop("checked", value);
		});
	});
	
	$("input[name=docIds]:checkbox").click(function(){
		if($("input[name=docIds]:checkbox").length == $('input[name=docIds]:checkbox:checked').length){
			$(".toggle_checkbox").prop('checked', true);
		} else {
			$(".toggle_checkbox").prop('checked', false);
		}
	})
}

function fn_pageSizeEdit() {
	var pageSize = $("#boardtop01_right").val();
	var selectValue = $('#searchGroupName').val();
	if(selectValue == 'ALL') {
		selectValue == "";
	}
	$('#groupName').val(selectValue);
	$("#pageSize").val(pageSize);
	$("#searchForm").submit();
}

function fn_search() {
	var searchTerm = $("#inputTerm").val();
	var searchTermOpt = $("#boardtop01_left").val();
	var selectValue = $('#searchGroupName').val();
	if(selectValue == 'ALL') {
		selectValue == "";
	} 
	$('#groupName').val(selectValue);
	
	if (searchTermOpt != 'confY' && searchTermOpt != 'confN') {
		if (searchTerm == '') {
			alert('검색어를 입력해주세요');
			return;
		}
	}
	$("#searchTerm").val(searchTerm);
	$("#searchTermOpt").val(searchTermOpt);
	
	$("#searchForm").submit();
}


function fn_startLabeling() {
	
	if($("#selectedDocIdFlag") == "ALL") {
		$('#lableingGroupName').val($("input[name=labelingGN]").val());
		
		if (!confirm('선택하신 문서에 대한 레이블링 작업을 시작하시겠습니까?'))
			return false;
		
		var labelingForm = $('#labeling_form').serialize();
		
		$.ajax({
			url: contextPath+'/auto/start.do?_format=json'
			, dataType: 'json'
				, data: labelingForm
				, success: function (data) {
					alert('선택한 문서에 대한 자동 레이블링을 시작합니다.');
					windowRefresh();
				}
		});
	} else {
		if (!confirm('문서에 대한 레이블링 작업을 시작하시겠습니까?'))
		        return false;
		var docID = $('#selectedDocId').val();
	    var groupName = $("input[name=labelingGN]").val();
	    $.ajax({
	    	url: contextPath+'/auto/start.do?_format=json'
	    	, dataType: 'json'
	    	, data: {"docIds" : docId, "groupName" : groupName}
	    	, success: function (data) {
	    		alert('요청한 문서에 대한 자동 레이블링을 시작합니다.');
	    		windowRefresh();
	    	}
	    });
	}
	
}

function bindAutoLabeling() {
    $("#btn_auto_labeling").click(function (e) {
    	var name = $(this).attr('name');
    	$('#selectedDocIdFlag').val('ALL')
    	open_modal(name);
    });
}

function fn_AutoLabeling(docId, ancher) {
	var name = $(ancher).attr('name');
	$('#selectedDocIdFlag').val('SINGLE');
	$('#selectedDocId').val(docId);
	open_modal(name);
}

function windowRefresh() {
	var pageNo = $("input[name=pageNo]").val();
	
	if(selectValue == 'ALL') {
		selectValue == "";
	} 
	$('#groupName').val(selectValue);
	
	var input = document.createElement('input');
	input.type = 'hidden';
	input.name = 'pageNo';
	input.value = pageNo;
	
	var form = $("#searchForm");
	form.append(input);
    form.submit();
}

function fn_searchGroupName(select){
	var selectValue = $(select).val();
	if(selectValue == 'ALL') {
		selectValue == "";
	} 
	$('#groupName').val(selectValue);
	$("#searchForm").submit();
}
