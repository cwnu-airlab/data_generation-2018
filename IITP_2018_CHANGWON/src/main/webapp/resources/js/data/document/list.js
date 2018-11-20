
$(function () { 
	bindToggleCheckbox();
	bindDomainTree();
	bindDocDelete();
});

function bindDomainTree(){
	var domainTree = $('#domain_tree_list');
	
	domainTree.jstree({
		'plugins': ["themes", "html_data", "sort", "ui"]}); 
	domainTree.on("changed.jstree", function(e, data){
        if (data == null || data.selected == null)
            return;
        $("#domain").val(data.instance.get_path(data.node,'/'));
        $("input[name=colId]").val(domainTree.jstree(true).get_selected());
	});
	domainTree.jstree('open_all');
	
}


function fn_pageSizeEdit() {
	var pageSize = $("#boardtop01_right").val();
	$("#pageSize").val(pageSize);
	$("#searchForm").submit();
}

function fn_search() {
	$("#searchForm").submit();
}

function fn_recordDelete(recordId) {
    if (!confirm('정말 삭제하시겠습니까?'))
        return false;

    $.ajax({
    	url: contextPath+'/data/document/recordDelete.do?_format=json'
    	, dataType: 'json'
    	, data: {'recordId' : recordId }
    	, success: function (data) {
    		alert('삭제가 완료되었습니다.');
    		
    		var form = $("#searchForm");
    	    form.submit();
    	},error: function(request,status,error){
        	alert('문서 삭제에 실패하였습니다. 관리자에게 문의해주세요.');
        	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
}

function fn_docDelete(docId) {
    if (!confirm('문서를 정말 삭제하시겠습니까?'))
        return false;

    $.ajax({
    	url:contextPath+ '/data/document/delete.do?_format=json'
    	, dataType: 'json'
    	, data: {'docId' : docId }
    	, success: function (data) {
    		alert('삭제가 완료되었습니다.');
    		
    		var form = $("#searchForm");
    	    form.submit();
    	}
    });
}

function bindDocDelete() {
    $("#btn_doc_delete").click(function (e) {
    	e.preventDefault();
        if (!confirm('체크된 문서를 삭제하시겠습니까?'))
            return false;

        var deleteForm = $('#delete_form').serialize();

        $.ajax({
        	url: contextPath+'/data/document/delete.do?_format=json'
        	, dataType: 'json'
        	, data: deleteForm
        	, success: function (data) {
        		alert('삭제가 완료되었습니다.');
        		
        		var form = $("#searchForm");
        	    form.submit();
        	},error: function(request,status,error){
            	alert('문서 삭제에 실패하였습니다. 관리자에게 문의해주세요.');
            	console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
            }
        });
    });
}

function bindToggleCheckbox() {
	$(".toggle_checkbox").click(function() {
		
		var value = $(this).is(":checked");

		$("input[name=docId]:checkbox").each(function() {
			$(this).prop("checked", value);
		});
	});
}
