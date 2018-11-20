<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/data/domain/list.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>도메인/문서 관리</h2>
	<div class="location">
		<ul>
			<li>Home</li>
			<li>텍스트 데이터 관리</li>
			<li class="loc_this">도메인/문서 관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">

	<!-- full area start -->
	<div class="full_area">

		<div class="type_label01 clear2">

			<!-- 문서 집합 start -->
			<div class="label_01" style="width: 24%;">
				<div class="cont_tit2 sub_tit mb_5">문서 검색</div>
				<form id="searchForm" action="${pageContext.request.contextPath}/data/domain/list.do?_format=json" method="post">
					<input type="hidden" id="pageSize" name="pageSize" value="${doc.pageSize}"/>
					<input type="hidden" id="colId" name="colId" value="${doc.colId}"/>
					<div class="cont_gray type_01 clear2" style="position: initial !important;">
						<div class="cont_tit2 ml_5 mt_10 mb_5" style="font-size:12px;">문서 건수 :
							<select id="boardtop01_right" style="padding : 1px;" onchange="javascript:fn_pageSizeEdit();">
								<option value="10" <c:if test="${doc.pageSize == '10'}">selected</c:if>>10</option>
								<option value="15" <c:if test="${doc.pageSize == '15'}">selected</c:if>>15</option>
								<option value="20" <c:if test="${doc.pageSize == '20'}">selected</c:if>>20</option>
								<option value="30" <c:if test="${doc.pageSize == '30'}">selected</c:if>>30</option>
							</select>
						</div>
						<select name="searchTermOpt" id="searchTermOpt" class="ml_5 mt_5 mb_10 " style="font-size:12px; padding : 1px;" onchange="javascript:fn_searchTermOpt();">
							<option value="all" <c:if test="${doc.searchTermOpt == 'all'}">selected</c:if>>전체</option>
							<option value="labeling" <c:if test="${doc.searchTermOpt == 'labeling'}">selected</c:if>>레이블링</option>
							<option value="domain" <c:if test="${doc.searchTermOpt == 'domain'}">selected</c:if>>도메인</option>
							<option value="subject" <c:if test="${doc.searchTermOpt == 'subject'}">selected</c:if>>문서제목</option>
						</select>
						<input type="text" name="searchTerm" id="searchTerm" class="white ml_5 mt_5 mb_10"  style="width: 50.2%;font-size:12px;padding: 3px;" title="검색어 입력" onkeydown="javascript:if(event.keyCode==13){fn_search();}" value="${doc.searchTerm}" />
						<a href="javascript:fn_search();" class="btn_tit_box mt_5 mb_10">검색</a>	
					</div>
				</form>
				<div class="cont_tit2 mt_10" style="margin-bottom:15px !important;">
					문서 집합
					<a href="javascript:fn_domainDelete();" title="도메인 삭제" class="btn_icon_delete float_r ml_5"></a>				
					<a href="javascript:fn_domainEdit();" title="도메인 수정" class="btn_icon_edit float_r ml_5"></a>
					<a href="javascript:fn_DomainAdd();" title="도메인 추가" class="btn_icon_add float_r ml_5"></a>	
				</div>
				<div class="cont_gray type_01 clear2" style="top: 154px !important;">
					<div id="domain_tree_list">
						 ${domainJstreeHtml}
					</div>
				</div>
			</div>
			<!--// 문서 집합 end -->

			<!-- 우측 영역 start -->
			<div class="label_02" style="padding-left:25.5%;">
				<!-- 폼 start -->
				<div class="cont_tit2 sub_tit" style="margin-bottom:5px !important;">문서 추가</div>
				<form id="form_doc_insert" action="${pageContext.request.contextPath}/data/document/insert.do?_format=json" method="post" enctype="multipart/form-data">
					<div class="align_r"></div>
					<table class="tbl_type02 type_write mt_3 mb_10">
						<colgroup>
							<col style="width:170px;">
							<col>
							<col style="width:170px;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="domain">도메인 선택</label></th>
								<td colspan="2"><input type="text" style="padding:3px;font-weight:bold;" id="domain" name="domain" class="white w50p" placeholder="왼쪽  Tree 목록에서 도메인을 선택해 주세요." readonly="readonly" required/></td>
							</tr>
							<tr>
								<th scope="row"><label for="file">파일선택</label></th>
								<td style="border-right:none !important;"><input type="file" id="file" style="padding:3px;font-weight:bold;" class="white w50p" required multiple="multiple"/></td>
								<td><input type="submit" class="btn b_balck large" value="신규문서 추가"></td>
							</tr>
						</tbody>
					</table>
				</form>
				<!--// 폼 end -->
				
				
				<!-- 폼 start -->
				<input type="hidden" name="domainName" id="domainName" class="white w300px"/>
				<input type="hidden" name="name" id="name" class="white w300px" />
				<!-- 목록 start -->
				<div>
					<div class="cont_tit2 sub_tit" style="margin-bottom:5px !important;">문서목록</div>
					<!-- 목록 검색 start -->
					<div class="cont_tit2">
						<div class="tit_opt float_l">
							<a href="#" id="btn_doc_delete" class="btn_tit_box">선택항목 삭제</a>
						</div>								
					</div>
					
					<!--// 목록 검색 end -->
					<form id="delete_form" action="${pageContext.request.contextPath}/data/document/delete.do?_format=json">
						<table class="tbl_type02">
							<colgroup>
								<col style="width:40px;">
			                    <col>
			                    <col style="width:100px;">
			                    <col style="width:70px;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col"><input type="checkbox" class="toggle_checkbox" title="전체 선택/해제" /></th>
			                		<th scope="col">내용</th>
			                		<th scope="col">레이블링 유형</th>
			                		<th scope="col">레이블링</th>
								</tr>
							</thead>
							<tbody>
								<c:set value="" var="pre_docId"/>
				                <c:if test="${not empty list}">
									<c:forEach var="result" items="${list}" varStatus="status">
										<tr>
											<c:if test="${pre_docId!=result.docId}">
												<c:choose>
													<c:when test="${result.count gt 0}">
														<td rowspan="${result.count}"><input type="checkbox" name="docId" value="${result.docId}"/></td>
							                			<td rowspan="${result.count}" class="left">
							                				<div style="font-size:12px;">
							                					<img src="${pageContext.request.contextPath}/resources/images/common/blank-file.png"> <span  style="font-weight:bold;">${result.subject}</span> By <span style="color:#7FB1DE;">${result.regId}</span> @ <span style="color:#7FB1DE;">${result.domain}</span> <span style="color:#7FB1DE;"><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd"/></span>
							                				</div>
							                				<div class="mt_15">
							                					${fn:substring(result.content,0,195)}
							                				</div>
						                				</td>
							                		</c:when>
							                		<c:otherwise>
							                			<td><input type="checkbox" name="docId" value="${result.docId}"/></td>
						                				<td class="left">
							                				<div style="font-size:12px;">
							                					<img src="${pageContext.request.contextPath}/resources/images/common/blank-file.png"> <span  style="font-weight:bold;">${result.subject}</span> By <span style="color:#7FB1DE;">${result.regId}</span> @ <span style="color:#7FB1DE;">${result.domain}</span> <span style="color:#7FB1DE;"><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd"/></span>
							                				</div>
							                				<div class="mt_15">
							                					${fn:substring(result.content, 0,195)}
							                				</div>
						                				</td>
							                		</c:otherwise>
						                		</c:choose>
											</c:if>
											<td>
					                			<c:if test="${result.groupName == 'namedentity'}">개체명</c:if>
					                			<c:if test="${result.groupName == 'simentic'}">의미역</c:if>
					                			<c:if test="${result.groupName == 'simentic_analysis'}">의미분석</c:if>
					                			<c:if test="${result.groupName == 'hate'}">혐오발언</c:if>
					                		</td>
					                		<td>${result.rabelStat}</td>
				                			<c:set value="${result.docId}" var="pre_docId"/>
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
