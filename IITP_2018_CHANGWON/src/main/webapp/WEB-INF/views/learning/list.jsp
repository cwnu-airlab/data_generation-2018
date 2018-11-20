<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/learning/list.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>학습데이터 생성</h2>
	<div class="location">
		<ul>
		<li>Home</li>
		<li class="loc_this">학습데이터 생성</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">
	<!-- full area start -->
	<div class="full_area">
		<div class="type_label01 clear2">
			<!-- 문서 집합 start -->
			<div class="label_01">
				<div class="cont_tit2">문서 검색</div>
				<div class="cont_gray type_01 clear2" style="position: initial !important;">
					<div class="cont_tit2 ml_5 mt_10 mb_5" style="font-size:12px;">대상 레이블 :
						<select id="searchGroupName" style="padding : 1px;" onchange="fn_searchGroupName(this);">
							<option value="namedentity" <c:if test="${doc.groupName == 'namedentity'}">selected</c:if>>개체명</option>
							<option value="simentic" <c:if test="${doc.groupName == 'simentic'}">selected</c:if>>의미역</option>
							<option value="simentic_analysis" <c:if test="${doc.groupName == 'simentic_analysis'}">selected</c:if>>의미분석</option>
							<option value="hate" <c:if test="${doc.groupName == 'hate'}">selected</c:if>>혐오발언</option>
						</select> 
						<label class="ml_10">문서 건수 :</label>
						<select id="boardtop01_right" style="padding : 1px;" onchange="javascript:fn_pageSizeEdit();">
							<option value="10" <c:if test="${doc.pageSize == '10'}">selected</c:if>>10</option>
							<option value="15" <c:if test="${doc.pageSize == '15'}">selected</c:if>>15</option>
							<option value="20" <c:if test="${doc.pageSize == '20'}">selected</c:if>>20</option>
							<option value="30" <c:if test="${doc.pageSize == '30'}">selected</c:if>>30</option>
						</select>
					</div>
					
					<select id="boardtop01_left" class="ml_5 mt_5 mb_10 " style="font-size:12px; padding : 1px;"  onchange="javascript:fn_searchTermOpt();">
						<option value="all" <c:if test="${doc.searchTermOpt == 'all'}">selected</c:if>>전체</option>
						<option value="domain" <c:if test="${doc.searchTermOpt == 'domain'}">selected</c:if>>도메인</option>
						<option value="subject" <c:if test="${doc.searchTermOpt == 'subject'}">selected</c:if>>문서제목</option>
					</select>
					<input type="text" id="inputTerm" class="white ml_5 mt_5 mb_10" style="width: 50.2%;font-size:12px;padding: 3px;"  title="검색어 입력" onkeydown="javascript:if(event.keyCode==13){fn_search();}" value="${doc.searchTerm}" />
					<a href="javascript:fn_search();" class="btn_tit_box mt_5 mb_10">검색</a>
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
				<form id="searchForm" action="${pageContext.request.contextPath}/learning/list.do?_format=json" method="post">
					<input type="hidden" id="pageSize" name="pageSize" value="${doc.pageSize}"/>
					<input type="hidden" id="colId" name="colId" value="${doc.colId}" />
					<input type="hidden" id="searchTerm" name="searchTerm" value="" />
					<input type="hidden" id="domain" name="domain" value=""/> 
					<input type="hidden" id="searchTermOpt" name="searchTermOpt" value="" />
					<input type="hidden" id="groupName" name="groupName" value="${doc.groupName}" />
				</form>	
				<!--// 검색 end -->

				<!-- 목록 start -->
				<div>
					<div class="cont_tit2">
						<c:if test="${not empty doc.domain}">"${doc.domain}"</c:if>
						<c:if test="${empty doc.domain}">전체</c:if> 문서목록
					</div>
					<div class="mb_10">
						<a href="javascript:alert('준비중입니다');" class="btn_tit_box">전체 학습 데이터 생성</a>					
						<a href="javascript:void(0);" id="btn_learning_start" class="btn_tit_box">선택항목 학습 데이터 생성</a>
						<a href="javascript:void(0);" id="btn_download_start" class="btn_tit_box">선택항목 학습 데이터 다운로드</a>				
					</div>	
					<form id="labeling_form" name="labeling_form" action="${pageContext.request.contextPath}/learning/start.do?_format=json">
						<input type="hidden" id="learningGroupName" name="groupName" value="${doc.groupName}"/>
						<table class="tbl_type02">
							<colgroup>
								<col style="width:40px;">
			                    <col style="width:70px;">
			                    <col style="width:70px;">
			                    <col style="width:70px;">
			                    <col >
			                    <col style="width:100px;">
			                    <col style="width:180px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" class="toggle_checkbox" title="전체 선택/해제" /></th>
			                		<th scope="col">학습상태</th>
			                		<th scope="col">레이블링 상태</th>
			                		<th scope="col">레이블명</th>
			                		<th scope="col">내용</th>
			                		<th scope="col">작업완료확인</th>
			                		<th scope="col">Action</th>
								</tr>
							</thead>
							<tbody>
								<c:if test="${not empty list}">
									<c:forEach var="result" items="${list}">
					                	<tr>
					                		<td><input type="checkbox" name="docIds" value="${result.docId}"/></td>
					                		<td>${result.learnStat}</td>
						                	<td>${result.rabelStat}</td>
				                			<td> 
					                			<c:if test="${result.groupName == 'namedentity'}">개체명</c:if>
					                			<c:if test="${result.groupName == 'simentic'}">의미역</c:if>
					                			<c:if test="${result.groupName == 'simentic_analysis'}">의미분석</c:if>
					                			<c:if test="${result.groupName == 'hate'}">혐오발언</c:if>
				                			</td>
			                				<td class="left">
				                				<div>
				                					${result.subject}  (${result.domain}, ${result.regId}, ${result.startDate}, ${result.endDate})
				                				</div>
				                				<div class="mt_15">
				                					${fn:substring(result.content, 0,195)}
				                				</div>
			                				</td>
					                		<td>${result.confId}</td>
						                	<td style="text-align:left">
					                			<a href="javascript:fn_learning('${result.docId}');" class="btn_labeling">데이터 생성</a>
					                			<c:if test="${ result.learnStat eq '자동' || result.learnStat eq '완료' }">
					                				<a href="javascript:fn_downloadPop('${result.docId}');" id="down_${result.docId}" class="btn_downalod">다운로드</a>
					                			</c:if>
					                		</td>
					                	</tr>
				                	</c:forEach>
				                </c:if>
				                <c:if test="${empty list}">
									<tr>
										<td colspan="7">결과가 없습니다.</td>
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
<!--// content end -->
<form id="popupForm" name="popupForm" action="" method="post">
	<input type="hidden" id="docId" name="docId" value="" />
	<input type="hidden" id="groupName" name="groupName" value="" />
</form>
