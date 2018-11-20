<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/data/document/list.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>문서 추가</h2>
	
	<div class="location">
		<ul>
		<li>Home</li>
		<li>텍스트 데이터 관리</li>
		<li class="loc_this">문서 추가</li>
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
				<div class="cont_tit2">문서 집합</div>
				<div class="cont_gray type_01 clear2">
					<div id="domain_tree_list">
						 ${domainJstreeHtml}
					</div>
				</div>
			</div>
			<!--// 문서 집합 end -->

			<!-- 우측 영역 start -->
			<div class="label_02">

				<!-- 폼 start -->
				<form id="form_doc_insert" action="${pageContext.request.contextPath}/data/document/insert.do?_format=json" method="post" enctype="multipart/form-data">
					<div class="align_r"><input type="submit" class="btn b_orange medium" value="신규문서 추가"></div>
					<table class="tbl_type02 type_write mt_3 mb_20">
						<colgroup>
							<col style="width:170px;">
							<col>
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label for="domain">도메인 선택</label></th>
								<td><input type="text" id="domain" name="domain" class="white w50p" placeholder="왼쪽  Tree 목록에서 도메인을 선택해 주세요." readonly="readonly" required/></td>
							</tr>
							<tr>
								<th scope="row"><label for="file">파일선택</label></th>
								<td><input type="file" id="file" class="white w50p" required multiple="multiple"/></td>
							</tr>
						</tbody>
					</table>
				</form>
				<!--// 폼 end -->

				<!-- 목록 start -->
				<div>
					<div class="cont_tit2">추가된 문서목록</div>
					<div class="cont_tit2">
						<form id="searchForm" action="${pageContext.request.contextPath}/data/document/list.do?_format=json" method="post">
							<input type="hidden" id="docIds" name="docIds" value="${docIds}"/>
							<input type="hidden" id="pageSize" name="pageSize" value="${doc.pageSize}"/>
							<input type="hidden" id="colId" name="colId" value="${doc.colId}" />
							<div class="tit_opt float_l">
								<select name="searchTermOpt" id="searchTermOpt">
									<option value="all" <c:if test="${doc.searchTermOpt == 'all'}">selected</c:if>>전체</option>
									<option value="domain" <c:if test="${doc.searchTermOpt == 'domain'}">selected="selected"</c:if>>도메인</option>
									<option value="subject" <c:if test="${doc.searchTermOpt == 'subject'}">selected="selected"</c:if>>문서제목</option>
									<option value="content" <c:if test="${doc.searchTermOpt == 'content'}">selected="selected"</c:if>>내용</option>
								</select>
								<input type="text" name="searchTerm" id="searchTerm" class="white" title="검색어 입력" onkeydown="javascript:if(event.keyCode==13){fn_search();}" value="${doc.searchTerm}" required />
								<a href="javascript:fn_search();" class="btn_tit_box">검색</a>
								<a href="#" id="btn_doc_delete" class="btn_tit_box ml_10">선택항목 삭제</a>
							</div>							
							<div class="tit_opt">
								<select>
									<option value="10" <c:if test="${doc.pageSize == '10'}">selected</c:if>>10</option>
									<option value="15" <c:if test="${doc.pageSize == '15'}">selected</c:if>>15</option>
									<option value="20" <c:if test="${doc.pageSize == '20'}">selected</c:if>>20</option>
									<option value="30" <c:if test="${doc.pageSize == '30'}">selected</c:if>>30</option>
								</select>
								<a href="javascript:fn_pageSizeEdit();" class="btn_tit_box">확인</a>
							</div>
						</form>							
					</div>
					<form id="delete_form" action="${pageContext.request.contextPath}/data/document/delete.do?_format=json">
						<table class="tbl_type02">
							<colgroup>
								<col style="width:40px;">
			                    <col />
			                    <col style="width:100px;">
							</colgroup>
							<thead>
								<tr>
			                		<th scope="col"><input type="checkbox" class="toggle_checkbox" title="전체 선택/해제" /></th>
			                		<th scope="col">내용</th>
			                		<th scope="col">Action</th>
			                	</tr>
							</thead>
							<tbody>
								<c:if test="${not empty list}">
								  	<c:forEach var="result" items="${list}">
										<tr>
					                		<td><input type="checkbox" name="docId" value="${result.docId}"/></td>
					                		<td class="left">
				                				<div>
				                					${result.subject}  (${result.domain}, ${result.regId}, <fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd"/>)
				                				</div>
				                				<div class="mt_15">
				                					${fn:substring(result.content, 0,195)}
				                				</div>
			                				</td>
						                	<td><a href="javascript:fn_docDelete('${result.docId}');" class="btn_td btn_tbl_del">문서삭제</a></td>
						                </tr>
					                </c:forEach>
				                </c:if>
								<c:if test="${empty list}">
									<tr>
										<td colspan="3">결과가 없습니다.</td>
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
