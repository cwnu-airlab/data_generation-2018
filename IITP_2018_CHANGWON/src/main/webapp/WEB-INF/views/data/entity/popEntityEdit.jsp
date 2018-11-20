<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<title>학습 코퍼스 구축 도구</title>
		<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-migrate-1.4.1.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jsrender.min.js"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jstree-3.3.4/jstree.min.js" />"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/jstree-3.3.4/themes/default/style.min.css"/>" />
		<script type="text/javascript">
		 var contextPath  = '<%=request.getContextPath()%>';
     	 var entityTree = $(opener.document).find('#${common.groupName}_tree_list');
		 opener.name = 'main_manager_info';
		 $(document).ready(function(){
			 $("#entityTree").html($(entityTree[0]).html());
			 
			 var enTree = $("#entityTree");
			 
			 enTree.jstree({
					'plugins': ["themes", "html_data", "sort", "ui","types"] ,
					'checkbox': {
			            'keep_selected_style': true
					} ,
					'types': {
			            'default': {
			                'icon': contextPath+'/resources/images/common/tag_blue.png'
			            }
			        },
				});
				
			 enTree.on("ready.jstree", function() {
				 enTree.jstree('open_all');
					
					var entId = enTree.jstree(true).get_selected();
					if (entId != '' && typeof entId != 'undefined') {
						var path = enTree.jstree().get_path(enTree.jstree(true).get_selected(),' > ');
						$("#path").html(path);
					}
				});
		 });
		 
		 
		 function fn_argAdd() {
				var groupName = '${common.groupName}';
				var enTree = $("#entityTree");
				
				var name = enTree.jstree(true).get_selected();
				
				$.ajax({
			    	url: contextPath+'/data/entity/entityList.do?_format=json'
			    	, dataType: 'json'
			    	, data: {'name' : name[0] , 'groupName' : groupName}
			    	, success: function (data) {
			    		var entList = data.entList;
					
			    		var html = "";
			    		
			    		var id = $("#relList > div:last").attr('id');
			    		var num = (id.replace("rel_","")*1)+1;
			    		
						html += '<div id="rel_'+num+'">';
						html += '<select class="select2" style="width: 200px;" id="startEnt" name="startRels['+num+']" required>';
						html += '<option value="" disabled selected>소스 선택</option>';
						
						for (var j=0; j<entList.length; j++) {
							html += '<option value="'+entList[j].name + '"';
							html += '>'+entList[j].name+'</option>';
						}
						
						html += '</select>';
						html += ' -> ';
						html += '<select class="select2" style="width: 200px;" id="endEnt" name="endRels['+num+']" required>';
						html += '<option value="" disabled selected>타겟 선택</option>';
						
						for (var j=0; j<entList.length; j++) {
							html += '<option value="'+entList[j].name + '"';
							html += '>'+entList[j].name+'</option>';
						}
						html += '</select>';
						html += '	<a name="btnArgDelete" href="javascript:fn_argDelete(\'rel_'+num+'\');" class="btn b_gray ssmall_pm valign_m" title="삭제">X</a>';
						html += '</div>';
						
						$("#relList > div:last").after(html);

						$("a[name=btnArgAdd]").remove();
						
						var html = '<a name="btnArgAdd" href="javascript:fn_argAdd();" class="btn b_gray ssmall_pm valign_m" title="추가">+</a>';
						
						$("#relList > div:last").append(html);
					    $('#relList > div:last > select').select2();
			    	}
			    });
				}

			function fn_argDelete(index) {
				var firstId = $("#relList > div:first").attr('id');
				var lastId = $("#relList > div:last").attr('id');
				
				if (firstId == lastId) {
					alert('마지막은 삭제할수없습니다.');
					return;
				}
				$("#"+index).remove();
				$("a[name=btnArgAdd]").remove();
				
				var html = '<a name="btnArgAdd" href="javascript:fn_argAdd();" class="btn b_gray ssmall_pm valign_m" title="추가">+</a>';
				
				$("#relList > div:last").append(html);
				
			    $('.select2').select2();
			}
			
			
			function fn_lowEntityAdd() {
				var entId = $("#entId").val();
				
				var lowEntity = $("#lowEntity").val();
				var lowbgColor = $("#chosen-color02").val();
				var groupName = '${common.groupName}';
				var parentEnt = $("#entityTree").jstree(true).get_selected();
				
				if (typeof lowEntity == 'undefined'|| lowEntity.length<1) {
					alert("하위 entity를 입력해주세요.");
					$("#lowEntity").focus();
					return;
				}
				
				if (typeof parentEnt == 'undefined'|| parentEnt.length<1) {
					alert("상위 entity를 선택해주세요.");
					return;
				}
				
				var checkName = $("#"+groupName).find("#"+lowEntity).text();
				if (checkName) {
					alert('['+lowEntity+']으로 이미 객체 혹은 관계가 존재합니다.');
					return;
				}
				
				$.ajax({
			    	url: contextPath+'/data/entity/insert.do?_format=json'
			    	, dataType: 'json'
			    	, data: {"groupName":groupName, "parentEnt":parentEnt[0], "name":lowEntity, "bgColor":lowbgColor}
			    	, success: function (data) {
			    		alert('추가가 완료되었습니다.');
			    		
			    		var form = $(opener.document.getElementById('searchForm'));
						form.children("input[name=pageNo]").val('1');
						form.children("input[name=selIds]").val(lowEntity);
						form.children("input[name=name]").val(lowEntity);
						form.action = contextPath + "/data/entity/list.do";
						form.target = opener.name
						form.submit();
						window.close();
			    	}
			    });
			}

			function fn_lowRelationAdd() {
				var lowRelation = $("#lowRelation").val();
				var groupName = '${common.groupName}';
				var parentEnt = $("#entityTree").jstree(true).get_selected();
				
				if (typeof lowRelation == 'undefined'|| lowRelation.length<1) {
					alert("하위 relation를 입력해주세요.");
					$("#lowRelation").focus();
					return;
				}
				
				if (typeof parentRel == 'undefined'|| parentRel.length<1) {
					alert("상위 relation를 선택해주세요.");
					return;
				}

				var checkName = $("#"+groupName).find("#"+lowRelation).text();
				if (checkName) {
					alert('['+lowEntity+']으로 이미 객체 혹은 관계가 존재합니다.');
					return;
				}
				
				$.ajax({
			    	url: contextPath+'/data/relation/insert.do?_format=json'
			    	, dataType: 'json'
			    	, data: {"groupName":groupName, "parentRel":parentRel[0], "name":lowRelation}
			    	, success: function (data) {
			    		alert('추가가 완료되었습니다.');
			    		var relId = data.relId;
			    		
			    		var form = $(opener.document.getElementById('searchForm'));
						form.children("input[name=pageNo]").val('1');
						form.children("input[name=selIds]").val(relId);
						form.action = contextPath+"/data/entity/list.do";
						form.target = opener.name;
						form.submit();
						window.close();
			    	}
			    });
			}
			
			
			function fn_delete() {
				if (confirm('정말 삭제하시겠습니까?')) {
					var count = $("#count").val();
					
					if (count>0) {
						alert('해당 객체/관계를 사용하는 문서가 존재합니다. \n 문서 목록에서 전부 삭제 후 다시 시도해주세요.');
						return;
					}
					
					var formName = $('#editEntityInfo').val();
					
					if (formName == 'entityTab') {
						var entId = $("#entityName").val();
						
						var entId = $("#entId").val();
						
						$.ajax({
					    	url: contextPath+'/data/entity/delete.do?_format=json'
					    	, dataType: 'json'
					    	, data: {"entId" : entId}
					    	, success: function (data) {
					    		alert('삭제가 완료되었습니다.');
					    		
					    		var form = $(opener.document.getElementById('searchForm'));
								form.action = contextPath+"/data/entity/list.do";
								form.target = opener.name
								form.submit();
								window.close();
					    	}
					    });
					} else {
						var relationForm = $('#relationForm').serialize();
						$.ajax({
					    	url: contextPath+'/data/relation/delete.do?_format=json'
					    	, dataType: 'json'
					    	, data: relationForm
					    	, success: function (data) {
					    		alert('삭제가 완료되었습니다.');
					    		
					    		var form = $(opener.document.getElementById('searchForm'));
								form.action = contextPath+"/data/entity/list.do";
								form.target = opener.name
								form.submit();
								window.close();
					    	}
					    });
					}
					
				}
			}

			function fn_edit() {
				var formName = $('#editEntityInfo').val();
				var relationName = $("#relationName").val();
				var entityName = $("#entityName").val();
				console.log(formName);
				if (relationName+entityName <= 0) {
					alert('');
					return;
				}
				
				if (formName == 'entityTab') {
					var entId = $("#entityName").val();
					var entityEditForm = $('#entityForm').serialize();
					
				    $.ajax({
				    	url:contextPath+ '/data/entity/update.do?_format=json'
				    	, dataType: 'json'
				    	, data: entityEditForm
				    	, success: function (data) {
				    		alert('수정이 완료되었습니다.');
			    			var form = $(opener.document.getElementById('searchForm'));
			    			form.children("input[name=pageNo]").val('1');
			    			form.children("input[name=selIds]").val(entId);
			    			form.action = contextPath+"/data/entity/list.do";
			    			form.target = opener.name
			    			form.submit();
							window.close();	
				    	}
				    });		
				} else {
					console.log(formName);
					var relationForm = $('#relationForm').serialize();
					var entId = $("#relationName").val();
					var result = true;
					$("#relList > div > select").each(function(index){
						if ($(this).val() == null) {
							alert('소스/타겟을 선택해주세요.');
							result = false;
							return false;
						}
					});
					
					if (result) {
						$.ajax({
					    	url: contextPath+'/data/relation/update.do?_format=json'
					    	, dataType: 'json'
					    	, data: relationForm
					    	, success: function (data) {
					    		alert('수정이 완료되었습니다.');
					    		var form = $(opener.document.getElementById('searchForm'));
				    			form.children("input[name=pageNo]").val('1');
				    			form.children("input[name=selIds]").val(entId);
				    			form.action = contextPath+"/data/entity/list.do";
				    			form.target = opener.name
				    			form.submit();
								window.close();	
					    	}
					    });
					}
				}
			}
		</script>
</head>
<body class="pop_body type_02">
	<div>
		<div class="pop_header"><h1 class="pop_h1">레이블링 객체 / 관계 태그 편집</h1></div>
		<div class="pop_content clear2" style="margin-top: 20px;">
		<c:if test="${not empty relation || not empty entity}">
			<c:if test="${not empty entity}">
				<!-- Entity start -->
				<input type="hidden" id="editEntityInfo" value="entityTab"/>
				<form id="entityForm" method="post">
					<input type="hidden" name="entId" id="entId" value="${entity.entId}"/>
					<input type="hidden" name="groupName" id="entGroupName" value="${entity.groupName}"/>
					<table class="tbl_type02 type_write mb_10">
		                <caption>Entity 관리 양식</caption>
		                <colgroup>
		                    <col style="width: 150px;">
		                    <col>
		                </colgroup>
		                <tbody>
		                	<tr>
								<th scope="row"><label for="lowEntity">신규 Entity 추가</label></th>
								<td>
									<span id="path"></span> > <input type="text" id="lowEntity" class="gray w100px " placeholder="개체명을 입력해주세요.">
									<a href="#" onclick="fn_lowEntityAdd(); return false;" class="btn b_gray ssmall valign_m">추가</a>
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="entityName">선택 항목</label></th>
								<td>
									<input type="text" name="name" id="entityName" class="white w250px" value="${entity.name}" readOnly>	
								</td>
							</tr>
							<tr>
								<th scope="row"><label for="entityLabel">라벨명</label></th>
								<td>
									<input type="text" name="label" id="entityLabel" class="white w150px" value="${entity.label}">
									<label for="color01" class="ml_10">배경 색상명</label>
									<input name="bgColor" id="chosen-color01" type="text" class="white w50px align_c ml_5" value="${entity.bgColor}"  readonly>
									<input id="color01" type="color" class="ml_5" value="${entity.bgColor}" onchange="javascript:document.getElementById('chosen-color01').value = document.getElementById('color01').value;">
									
									<label for="color02" class="ml_10">태그 텍스트 색상명</label>
									<input name="fgColor" id="chosen-color02" type="text" class="white w50px align_c ml_5" value="${entity.fgColor}"  readonly>
									<input id="color02" type="color" class="ml_5" value="${entity.fgColor}" onchange="javascript:document.getElementById('chosen-color02').value = document.getElementById('color02').value;">
								</td>
							</tr>
						</tbody>
					</table>
				</form>
				<!--// Entity end -->
			</c:if>
				
			<c:if test="${not empty relation}">
				<!-- Relation start -->	
				<input type="hidden" id="editEntityInfo" value="relationTab"/>
				<form id="relationForm" method="post">
					<input type="hidden" name="groupName" id="relGroupName" value="${relation[0].groupName}"/>
					<input type="hidden" name="parentRel" id="relParentRel" value="${relation[0].parentRel}"/>
						<table class="tbl_type02 type_write mb_10">
			                <caption>Relation 관리 양식</caption>
			                <colgroup>
			                    <col style="width: 150px;">
			                    <col>
			                </colgroup>
			                <tbody>
								<tr>
									<th scope="row"><label for="form03_01">신규 Relation</label></th>
									<td>
										<span id="path"></span> > <input type="text" id="lowRelation" class="white w200px" placeholder="관계명 입력">
										<a href="#" onclick="fn_lowRelationAdd();" class="btn b_gray ssmall valign_m">추가</a>		
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="relationName">선택 항목</label></th>
									<td>
										<input type="text" name="name" id="relationName" class="white w500px" value="${relation[0].name}" readOnly>
									</td>
								</tr>
								<tr>
									<th scope="row"><label for="relationLabel">라벨명</label></th>
									<td>
										<input type="text" name="label" id="relationLabel" class="white w300px" value="${relation[0].label}">
									 </td>
								</tr>
								<tr>
									<th scope="row"><label for="form03_03">소스 / 타겟</label></th>
									<td id="relList" >
									
									<c:set var="cnt" value="0"/>
									<c:forEach var="rel" items="${relation}" varStatus="relationStatus">
									<c:set var="endRelList" value="${fn:split(rel.endRel,'|')}" />
										<c:forEach var="endRel" items="${endRelList}" varStatus="endRelStatus">
										<div id="rel_${cnt}">
											<select style="width: 200px;" id="startEnt" name="startRels['${cnt}']">
												<option value="" disabled>소스 선택</option>
												<c:forEach var="result" items="${entList}">
													<option value="${result.name}" <c:if test="${result.name == rel.startRel}">selected</c:if>>${result.name}</option>
												</c:forEach>
											</select>
											->
											<select style="width: 200px;" id="endEnt" name="endRels['${cnt}']">
												<option value="" disabled>소스 선택</option>
												<c:forEach var="result" items="${entList}">
													<option value="${result.name}" <c:if test="${result.name == endRel}">selected</c:if>>${result.name}</option>
												</c:forEach>
											</select>
											<a name="btnArgDelete" href="#" onclick="fn_argDelete('rel_${cnt}');" class="btn b_gray ssmall_pm valign_m" title="삭제">X</a>
											<c:if test="${fn:length(relation) == relationStatus.count}">
												<c:if test="${fn:length(endRelList) == endRelStatus.count}">
													<a name="btnArgAdd" href="#" onclick="fn_argAdd();" class="btn b_gray ssmall_pm valign_m" title="추가">+</a>
												</c:if>
											</c:if>
										</div>
										<c:set var="cnt" value="${cnt+1}"/>
										</c:forEach>
										</c:forEach>				
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</c:if>
			<div class="align_r mb_20">
				<a href="#" onclick="fn_edit(); return false" class="btn_tit_box">수정</a>	
				<a href="#" onclick="window.close();" class="btn_tit_box">닫기</a>				
			</div>
			</c:if>
			<div id="entityTree" style="display:none;">
			</div>
		</div>
	</div>
</body>
</html>