<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags/"%>

<div class="tit_page clear2">
	<h2>동영상 관리</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 데이터 관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<div class="cont">
	<!-- full area start -->
	<div class="full_area">
		<div class="type_label01 clear2">
			<!-- 검색 start -->
			<form id="searchForm" action="${pageContext.request.contextPath}/media/mediaList.do?_format=json" method="POST">
				<div class="label_01">
					<div class="cont_tit2 sub_tit">미디어 검색</div>
					<div class="cont_gray type_01 clear2" style="position: initial !important;">
						<div class="cont_tit2 ml_5 mt_10 mb_5" style="font-size:12px;">검색 대상 필드 : 
						<select id="search_form01" name="searchTermOpt" style="padding : 1px;">
							<option value="ALL" <c:if test="${mediaVo.searchTermOpt eq 'ALL'}">selected</c:if>>전체</option>
							<option value="CATEGORY" <c:if test="${mediaVo.searchTermOpt eq 'CATEGORY'}">selected</c:if>>카테고리</option>
							<option value="FILE" <c:if test="${mediaVo.searchTermOpt eq 'FILE'}">selected</c:if>>파일명</option>
						</select>
						</div>
						<input type="text" id="searchTermInput" value="${fn:trim(mediaVo.searchTerm)}" name="searchTerm" class="white ml_5 mt_5 mb_10" style="width: 74.2%;font-size:12px;padding: 3px;" id="search_form02" placeholder="검색어를 입력해주세요." />
						<a href="#" id="searchBtn" class="btn_tit_box mt_5 mb_10">검색</a>
					</div>
				</div>
				<input type="hidden" id="pageSize" name="pageSize" value="${mediaVo.pageSize}"/>
				<input type="hidden" id="pageNo" name="pageNo" value="1"/>
			</form>
			<!--// 검색 end -->
			<div class="label_02">
				<div class="cont_tit2 sub_tit" style="margin-bottom:5px;">
					미디어 목록
					<div class="float_r">
						<a href="javascript:void(0)" onclick="fn_deleteMediaChk();" class="btn btn_delete">선택된 영상삭제</a>
					</div>
				</div>
				
				<table class="tbl_type02">
					<colgroup>
						<col style="width:3%">
						<col style="width:10%">
						<col>
						<col style="width:10%">
						<col style="width:15%">
						<col style="width:10%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" name="mediaCheckAll" id="mediaCheckAll" value="ALL"/></th>
							<th scope="col">카테고리</th>
							<th scope="col">파일명</th>
							<th scope="col">담당자</th>
							<th scope="col">최종수정일</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${not empty results}">
								<c:forEach var="result" items="${results}">
									<tr>
										<td><input type="checkbox" name="mediaCheck"  value="${result.mediaId}"/></td>
										<td>${result.categoryName}</td>
										<td class="left"><a href="${pageContext.request.contextPath}/media/mediaView.do?mediaId=${result.mediaId}">${result.fileName}</a></td>
										<td>${result.registedUser}</td>
										<td><fmt:formatDate value="${result.regDt}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td><a href="javascript:void(0)" onclick="fn_deleteMedia(${result.mediaId})" class="btn btn_delete">영상삭제</a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6">업로드된 영상정보가 없습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<t:paginationMedia ref="${pagination}" />
		<!--// 페이징 end -->
			</div>
		</div>
	<!--// full area end -->
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#searchBtn').click(function(){
				$("#searchForm").submit();
			});
		});
		
		
		$('#mediaCheckAll').change(function(){
			if($(this).is(':checked')){
				$("input[name=mediaCheck]").prop('checked', true);
			} else {
				$("input[name=mediaCheck]").prop('checked', false);
			}
		});
		
		$('input[name=mediaCheck]').change(function () {
			if($("input[name=mediaCheck]").length == $("input[name=mediaCheck]:checked").length){
				$("#mediaCheckAll").prop('checked', true);
			} else {
				$("#mediaCheckAll").prop('checked', false);
			}
		});
		
		function fn_deleteMedia(mediaId){
			if(!confirm('동영상 정보를 삭제하시겠습니까?\n기존에 저장된 샷정보도 같이 삭제됩니다.')){
				return;
			}
			$.ajax({
				url : contextPath + '/media/mediaDelete.do',
				type : 'post',
				data : {selectMediaId : mediaId},
				success : function(data){
					if(data.deleteRes != 0){
						alert('동영상 삭제에 성공하였습니다.');
						$("#searchForm").submit();
					}
				}, error : function (){
					alert('동영상 삭제중 예외가 발생되었습니다.\n다시시도 해주세요.');
				}
			})
		}
		
		function fn_deleteMediaChk(){
			var mediaIds = []
			$('input[name=mediaCheck]:checked').each(function(){
				mediaIds.push($(this).val());
			});

			if(mediaIds.length > 0){
				if(!confirm('선택한 동영상 정보를 삭제하시겠습니까?\n기존에 저장된 샷정보도 같이 삭제됩니다.')){
					return;
				}
				
				$.ajax({
					url : contextPath + '/media/mediaDelete.do',
					type : 'post',
					traditional:true,
					data : {selectMediaId : mediaIds},
					success : function(data){
						if(data.deleteRes != 0){
							alert('동영상 삭제에 성공하였습니다.');
							$("#searchForm").submit();
						}
					}, error : function(){
						alert('동영상 삭제중 예외가 발생되었습니다.\n다시시도 해주세요.');
					}
				})
			}
		}
		
	</script>
</div>
