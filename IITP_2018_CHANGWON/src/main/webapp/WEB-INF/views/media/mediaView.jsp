<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.cont_white {
		position: relative;
		clear: both;
		background: #ffffff;
		border: 1px solid #ddd;
		border-radius: 6px;
	}
</style>
	<!-- page title start -->
<div class="tit_page clear2">
	<h2>동영상 레이블링 상세보기</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 레이블링 상세보기</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">

	<!-- full area start -->
	<div class="full_area">
		<!-- 개체명 레이블드 데이터 start -->
		<form action="${pageContext.request.contextPath}/media/mediaEdit.do" name="mediaEditForm" method="POST">
			<input type="hidden" name="mediaId" value="${mediaInfo.mediaId}"/>
		</form>
		<form name="mediaCategoryForm">
			<input type="hidden" name="catId" value=""/>
			<input type="hidden" name="catName" value=""/>
			<input type="hidden" name="mediaId" value="${mediaInfo.mediaId}"/>
		</form>
		<div>
			<div class="float_l mb_20">
				<div class="cont_tit2">동영상 정보
					<div class="tit_opt float_3">
						<a href="javascript:void(0);" onclick="document.mediaEditForm.submit();" class="btn_tit_box">편집</a>
					</div>	
				</div>
				<div class="cont_white clear2" style="height:400px;overflow-y: auto;">
					<div class="cont_tit2 ml_10 mt_10">Sample Info</div>
					<video src="${pageContext.request.contextPath}${mediaInfo.localFile}" poster="${pageContext.request.contextPath}${mediaInfo.thumbNail}" width="30%" controls="controls" class="float_l ml_10 mr_10">
					</video>
					<div class="float_l" style="width:65%">
						<table class="tbl_type02" style="font-size:13px;">
							<colgroup>
								<col style="width:20%">
								<col >
							</colgroup>
							<tbody id="changeInfo">
								<tr>
									<th scope="col">동영상 명</th>
									<td scope="col" class="left" style="font-size:13px;">${mediaInfo.fileName}</td>
								</tr>
								<tr>
									<th scope="col">카테고리</th>
									<td scope="col" class="left" style="font-size:13px;">
										<select id="categoryInfo">
											<c:forEach items="${categoryInfo}" var="cat">
												<c:choose>
													<c:when test="${mediaInfo.categoryName eq cat.catName}">
														<option value="${cat.catId}ⓐⓐⓐ${cat.catName}" selected="selected">${cat.catName}</option>
													</c:when>
													<c:otherwise>
														<option value="${cat.catId}ⓐⓐⓐ${cat.catName}">${cat.catName}</option>
													</c:otherwise>
												</c:choose>
											</c:forEach>
											<option value="CUSTOM">카테고리 추가</option>
										</select>
										<input type="text" id="category" style="display: none;" value="">
									</td>
								</tr>
								<tr>
									<th scope="col">동영상 경로</th>
									<td scope="col" class="left" style="font-size:13px;">${mediaInfo.localFile}</td>
								</tr>
								<tr>
									<th scope="col">섬네일 경로</th>
									<td scope="col" class="left" style="font-size:13px;">${mediaInfo.thumbNail}</td>
								</tr>
								<tr>
									<th scope="col">재생시간</th>
									<td scope="col" class="left" style="font-size:13px;">${mediaInfo.duration}</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!--// 개체명 레이블드 데이터 end -->
		<c:if test="${not empty mediaInfo.shotInfo}">
			<!-- 개체명 레이블드 데이터 start -->
			<div class="mt_30">
				<div>
					<div class="cont_tit2">동영상 샷 리스트</div>
					<div class="cont_white clear2" style="height:420px;overflow-y: auto;">
						<c:forEach items="${mediaInfo.shotInfo}" var="item">
							<div style="height: 370px;border-bottom: 1px solid #afafaf;">
								<div class="cont_tit2 ml_10 mt_10" style="font-size:20px;">Shot1 (${item.startTimeCode} ~ ${item.endTimeCode})</div>
								<div style="width:30%; text-align:center;" class="float_l ml_10 mt_10 mr_10">
									<span style="font-size:15px;">Start Frame :</span> <img src="${pageContext.request.contextPath}${item.startThumb}" width="40%"><br><br>
									<span style="margin-top : 25px;font-size:15px;">&nbsp;End Frame :</span> <img src="${pageContext.request.contextPath}${item.endThumb}" width="40%">
								</div>
								<div class="float_l mr_10" style="width:67%;">
									<div class="cont_tit2">샷 추출 정보</div>
									<table class="tbl_type02">
										<colgroup>
											<col style="width:20%">
											<col>
											<col style="width:20%">
											<col>
										</colgroup>
										<tbody>
											<tr>
												<th>샷 시작시간</th>
												<td>${item.startTimeInfo}</td>
												<th>샷 종료시간</th>
												<td>${item.endTimeInfo}</td>
											</tr>
											<tr>
												<th>샷 시작프레임</th>
												<td>${item.startFrame}</td>
												<th>샷 종료프레임</th>
												<td>${item.endFrame}</td>
											</tr>
											<tr>
												<th>샷 시작섬네일</th>
												<td>/uploads${item.startThumb}</td>
												<th>샷 종료섬네일</th>
												<td>/uploads${item.endThumb}</td>
											</tr>
										</tbody>
									</table>
									<div class="cont_tit2 mt_10">동영상 샷 이벤트 정보</div>
									<table class="tbl_type02">
										<colgroup>
											<col style="width:15%">
											<col>
											<col style="width:15%">
											<col>
											<col style="width:15%">
											<col>
										</colgroup>
										<tbody>
											<tr>
												<th>제목</th>
												<td colspan="5" class="left">${item.title}</td>
											</tr>
											<tr>
												<th>Who</th>
												<td class="left">${item.whoDesc}</td>
												<th>What Behavior</th>
												<td class="left">${item.whatBehaviorDesc}</td>
												<th>What Object</th>
												<td class="left">${item.whatObjectDesc}</td>
											</tr>
											<tr>
												<th>Where</th>
												<td class="left">${item.whereDesc}</td>
												<th>When</th>
												<td class="left">${item.whenDesc}</td>
												<th>why</th>
												<td class="left">${item.whyDesc}</td>
											</tr>
											<tr>
												<th>How</th>
												<td class="left">${item.howDesc}</td>
												<td colspan="4"></td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
			<!--// 개체명 레이블드 데이터 end -->
		</c:if>
	</div>
	<!--// full area end -->
	<script type="text/javascript">
		$(document).ready(function(){
			bindCategoryEditEvent();
		});
		
		function bindCategoryEditEvent(){
			$('#categoryInfo').change(function(){
				var catId = $(this).val();
				if(catId == "CUSTOM"){
					$('#category').show();
					return;	
				} else {
					$('#category').hide();
					var catInfo = $(this).val();
					var catInfos = catInfo.split('ⓐⓐⓐ');
					var form = document.mediaCategoryForm;
					form.catId.value = catInfos[0];
					form.catName.value = catInfos[1];
					$.ajax({
						url : contextPath+'/media/updateCategory.do',
						type : 'post',
						dataType : 'json',
						data : $(form).serialize(),
						success : function(data) {
							if(data.mediaInfo){
								alert('카테고리 수정을 완료하였습니다.');
							}
						},
						error : function(data){
							alert('카테고리 수정하는데 예외가 발생되었습니다.');
						},
						complete:function(){
							location.reload();
						}
					})
				}
			});
			
			$('#category').keydown(function (e) {
				if(e.keyCode == 13){
					var catName = $(this).val();
					var form = document.mediaCategoryForm;
					form.catId.value = '0';
					form.catName.value = catName;
					$.ajax({
						url : contextPath+'/media/updateCategory.do',
						type : 'post',
						dataType : 'json',
						data : $(form).serialize(),
						success : function(data) {
							if(data.mediaInfo){
								alert('카테고리 수정을 완료하였습니다.');
							} else {
								alert('카테고리 수정에 실패하였습니다.');
							}
						},
						error : function(data){
							alert('카테고리 수정중에 예외가 발생되었습니다.');
						},
						complete:function(){
							location.reload();
						}
					});
				}
			});
		}
	</script>
</div>

