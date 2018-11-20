<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/auto/list.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>자동 레이블링</h2>
	<div class="location">
		<ul>
			<li>Home</li>
			<li>텍스트 데이터 관리</li>
			<li class="loc_this">자동 레이블링</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<!-- 모달 : 레이블 분류 start -->
<div class="modal" id="modal_autoLabeling">
	<div class="modal_in" style="width:400px;">
		<div class="modal_tit clear2">
			레이블 분류
			<a href="#" class="btn_modal_close" title="창 닫기">창 닫기</a>
		</div>

		<div class="modal_cont">

			<ul class="form_radio">
				<li><input type="radio" name="labelingGN" id="radio_form01" value="namedentity" checked/><label for="radio_form01" class="font_n">개체명</label></li>
				<li><input type="radio" name="labelingGN" id="radio_form02" value="simentic" /><label for="radio_form02" class="font_n">의미역</label></li>
				<li><input type="radio" name="labelingGN" id="radio_form03" value="simentic_analysis" /><label for="radio_form03" class="font_n">의미분석</label></li>
				<li><input type="radio" name="labelingGN" id="radio_form04" value="hate" /><label for="radio_form04" class="font_n">혐오발언</label></li>
			</ul>
			<input type="hidden" id="selectedDocIdFlag" value="">
			<input type="hidden" id="selectedDocId" value="">
			<div class="pop_btnset_foot">
				<a href="javascript:fn_startLabeling();" class="btn_tit_box type_medium">확인</a>
				<a href="#" class="btn_tit_box type_medium type_cancel">취소</a>
			</div>
		</div>
	</div>
</div>
<!--// 모달 : 레이블 분류 end -->



<div class="cont">
	<!-- full area start -->
	<c:if test="${not empty entity}">
		<input type="hidden" id="editEntityInfo" value="entityTab"/>
		<form id="entityForm" method="post">
			<input type="hidden" name="entId" id="entId" value="${entity.entId}"/>
			<input type="hidden" name="groupName" id="entGroupName" value="${entity.groupName}"/>
			<input type="hidden" id="entityName" value="${entity.name}">
		</form>
	</c:if>
	<c:if test="${not empty relation}">
		<input type="hidden" id="editEntityInfo" value="relationTab"/>
		<form id="relationForm" method="post">
			<input type="hidden" name="groupName" id="relGroupName" value="${relation[0].groupName}"/>
			<input type="hidden" name="parentRel" id="relParentRel" value="${relation[0].parentRel}"/>
			<input type="hidden" name="name" id="relationName" value="${relation[0].name}" readOnly>
		</form>
	</c:if>
	<div class="full_area">
		<div class="type_label01 clear2">
			<!-- 문서 집합 start -->
			<div class="label_01">
				<div class="cont_tit2">문서 검색</div>
				<div class="cont_gray type_01 clear2" style="position: initial !important;">
<!-- 					<div class="tit_opt float_l mt_10 ml_5"> -->
						<div class="cont_tit2 ml_5 mt_10 mb_5" style="font-size:12px;">레이블링 : 
							<select id="searchGroupName" style="padding : 1px;" onchange="fn_searchGroupName(this);">
								<option value="ALL" <c:if test="${doc.groupName == 'ALL'}">selected</c:if>>전체</option>
								<option value="namedentity" <c:if test="${doc.groupName == 'namedentity'}">selected</c:if>>개체명</option>
								<option value="simentic" <c:if test="${doc.groupName == 'simentic'}">selected</c:if>>의미역</option>
								<option value="simentic_analysis" <c:if test="${doc.groupName == 'simentic_analysis'}">selected</c:if>>의미분석</option>
								<option value="hate" <c:if test="${doc.groupName == 'hate'}">selected</c:if>>혐오발언</option>
							</select>
							<label class="ml_20">문서 건수 :</label>
							<select id="boardtop01_right" style="padding : 1px;" onchange="javascript:fn_pageSizeEdit();">
								<option value="10" <c:if test="${doc.pageSize == '10'}">selected</c:if>>10</option>
								<option value="15" <c:if test="${doc.pageSize == '15'}">selected</c:if>>15</option>
								<option value="20" <c:if test="${doc.pageSize == '20'}">selected</c:if>>20</option>
								<option value="30" <c:if test="${doc.pageSize == '30'}">selected</c:if>>30</option>
							</select>
						</div>
<!-- 					</div> -->
<!-- 					<div class="tit_opt float_l mt_5 ml_5 mb_10"> -->
						<select id="boardtop01_left"  class="ml_5 mt_5 mb_10 " style="font-size:12px; padding : 1px;" onchange="javascript:fn_searchTermOpt();">
							<option value="all" <c:if test="${doc.searchTermOpt == 'all'}">selected</c:if>>전체</option>
							<option value="domain" <c:if test="${doc.searchTermOpt == 'domain'}">selected</c:if>>도메인</option>
							<option value="subject" <c:if test="${doc.searchTermOpt == 'subject'}">selected</c:if>>문서제목</option>
						</select>
						<input type="text" id="inputTerm" class="white ml_5 mt_5 mb_10" style="width: 50.2%;font-size:12px;padding: 3px;" title="검색어 입력" onkeydown="javascript:if(event.keyCode==13){fn_search();}" value="${doc.searchTerm}" />
						<a href="javascript:fn_search();" class="btn_tit_box mt_5 mb_10">검색</a>
<!-- 					</div> -->
				</div>		
				<div class="cont_tit2 mt_10">문서 집합</div>
				<div class="cont_gray type_01 clear2" style="top: 150px !important;">
					<div id="domain_tree_list">
						 ${domainJstreeHtml}
					</div>
				</div>
			</div>
			<!--// 문서 집합 end -->
			<!-- 우측 영역 start -->
			<div class="label_02">
				<!-- 검색 start -->
				<form id="searchForm" action="${pageContext.request.contextPath}/auto/list.do?_format=json" method="post">
					<input type="hidden" id="pageSize" name="pageSize" value="${doc.pageSize}"/>
					<input type="hidden" id="colId" name="colId" value="${doc.colId}" />
					<input type="hidden" id="domain" name="domain" value=""/> 
					<input type="hidden" id="searchTerm" name="searchTerm" value="" />
					<input type="hidden" id="searchTermOpt" name="searchTermOpt" value="" />
					<input type="hidden" id="groupName" name="groupName" value="${doc.groupName}" />
					<input type="hidden" id="lableingGroupName" name="labelingGroupName" value="" />
					<!-- 레이블링  대상 항목 start -->				 
				</form>
				<!--// 검색 end -->
				<!-- 목록 start -->
				<div>
					<div class="cont_tit2">
						<div class="float_l mb_10">
							<a href="javascript:alert('준비중입니다');" class="btn_tit_box">전체 자동레이블링 시작</a>					
							<a href="javascript:void(0);" name="modal_autoLabeling" id="btn_auto_labeling" class="btn_tit_box">선택항목 자동레이블링 시작</a>					
						</div>
					</div>
					<form id="labeling_form" action="/auto/start.do?_format=json">
						<table class="tbl_type02">
							<colgroup>
								<col style="width:40px;">
			                    <col style="width:100px;">
			                    <col style="width:100px;">
			                    <col>
			                    <col style="width:120px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" class="toggle_checkbox" title="전체 선택/해제" /></th>
									<th scope="col">레이블링 상태</th>
									<th scope="col">레이블명</th>
									<th scope="col">내용</th>
									<th scope="col">action</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty list}">
									<c:forEach var="result" items="${list}">
				                	<tr>
				                		<td><input type="checkbox" name="docIds" value="${result.docId}"/></td>
					                	<td>${result.rabelStat}</td>
			                			<td> 
				                			<c:if test="${result.groupName == 'namedentity'}">개체명</c:if>
				                			<c:if test="${result.groupName == 'simentic'}">의미역</c:if>
				                			<c:if test="${result.groupName == 'simentic_analysis'}">의미분석</c:if>
				                			<c:if test="${result.groupName == 'hate'}">혐오발언</c:if>
			                			</td>
				                		<td class="left">
		                					<div style="font-size:12px;">
			                					<img src="${pageContext.request.contextPath}/resources/images/common/blank-file.png"> <span  style="font-weight:bold;">${result.subject}</span> By <span style="color:#7FB1DE;">${result.regId}</span> @ <span style="color:#7FB1DE;">${result.domain}</span> <span style="color:#7FB1DE;">${result.startDate}, ${result.endDate}</span>
			                				</div>
			                				<div class="mt_15">
			                					${fn:substring(result.content, 0,195)}
			                				</div>
		                				</td>
					                	<td>
				                			<a href="javascript:void(0)" onclick="fn_AutoLabeling('${result.docId}', this);" name="modal_autoLabeling" class="btn_labeling">자동 레이블링</a>
				                		</td>
				                	</tr>
				                	</c:forEach>
				                </c:if>
				                <c:if test="${empty list}">
									<tr>
										<td colspan="4">결과가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</form>
					<t:pagination ref="${pagination}" />
				</div>
				<!--// 목록 end -->
			</div>
			<!--// 우측 영역 end -->
		</div>
	</div>
	<!--// full area end -->
</div>
