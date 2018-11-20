<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="${pageContext.request.contextPath}/resources/js/moment.js-2.17.1/moment-with-locales.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/work/document/list.js"></script>	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>

<!-- page title start -->
<div class="tit_page clear2">
	<h2>문서이력관리</h2><span>수정된 문서 이력을 관리할 수 있습니다.</span>
	<div class="location">
		<ul>
		<li>Home</li>
		<li>작업관리</li>
		<li class="loc_this">문서이력관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">

	<!-- full area start -->
	<div class="full_area">

		<div class="cont_tit2">
			<form id="searchForm" action="${pageContext.request.contextPath}/work/document/list.do?_format=json" method="post">
				<input type="hidden" id="pageSize" name="pageSize" value="${doc.pageSize}"/>
				<div class="tit_opt float_l">
					<label class="mr_3">기간</label>
					<select name="dateSearchOpt" id="dateSearchOpt">
						<option value="all" <c:if test="${doc.dateSearchOpt == 'all'}">selected</c:if>>전체</option>
						<option value="regDate" <c:if test="${doc.dateSearchOpt == 'regDate'}">selected</c:if>>등록일</option>
						<option value="lastDate" <c:if test="${doc.dateSearchOpt == 'lastDate'}">selected</c:if>>수정일</option>
					</select>
					<input type="text" title="시작날짜 입력" name="startDate" id="startDate" value="${doc.startDate}" class="gray w80px align_c date_time mr_3" readonly /> ~ <input type="text" title="마지막날짜 입력" name="endDate" id="endDate" value="${doc.endDate}"  class="gray w80px align_c date_time mr_3" readonly />
					<label class="mr_3 ml_30">검색</label>
					<select>
						<option value="all" <c:if test="${doc.searchTermOpt == 'all'}">selected</c:if>>전체</option>
						<option value="labeling" <c:if test="${doc.searchTermOpt == 'labeling'}">selected</c:if>>레이블링</option>
						<option value="domain" <c:if test="${doc.searchTermOpt == 'domain'}">selected</c:if>>도메인</option>
						<option value="subject" <c:if test="${doc.searchTermOpt == 'subject'}">selected</c:if>>문서제목</option>
						<option value="regId" <c:if test="${doc.searchTermOpt == 'regId'}">selected</c:if>>등록자</option>
					</select>
					<input type="text" name="searchTerm" id="searchTerm" class="white" title="검색어 입력" value="${doc.searchTerm}"/>
					<input type="submit" class="btn_tit_box" value="검색" />
				</div>				
			</form>			
			<div class="tit_opt">
				<select id="boardtop01_right">
					<option value="10" <c:if test="${doc.pageSize == '10'}">selected</c:if>>10</option>
					<option value="15" <c:if test="${doc.pageSize == '15'}">selected</c:if>>15</option>
					<option value="20" <c:if test="${doc.pageSize == '20'}">selected</c:if>>20</option>
					<option value="30" <c:if test="${doc.pageSize == '30'}">selected</c:if>>30</option>
				</select>
				<a href="javascript:fn_pageSizeEdit();" class="btn_tit_box">확인</a>
			</div>							
		</div>
		<div class="tbl_wrap">
			<table class="tbl_type02">
				<colgroup>
					<col style="width:6%;" />
                    <col style="width:5%;" />
                    <col style="width:5%;" />
                    <col style="width:10%;" />
                    <col />
                    <col style="width:80px;" />
                    <col style="width:80px;" />
                    <col style="width:130px;" />
                    <col style="width:130px;" />
                    <col style="width:80px;" />
                    <col style="width:100px;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">도메인</th>
                		<th scope="col">Entity</th>
                		<th scope="col">레이블링</th>
                		<th scope="col">문서제목 (파일명)</th>
                		<th scope="col">내용</th>
                		<th scope="col">작업완료 확인자</th>
                		<th scope="col">최종 수정자</th>
                		<th scope="col">최종 수정일</th>
                		<th scope="col">등록일</th>
                		<th scope="col">이력 횟수</th>
                		<th scope="col"></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty list}">
						<c:forEach var="result" items="${list}">
							<tr>
								<td>${result.domain}</td>
								<td>
									<c:if test="${result.groupName == 'namedentity'}">개체명</c:if>
		                			<c:if test="${result.groupName == 'simentic'}">의미역</c:if>
		                			<c:if test="${result.groupName == 'simentic_analysis'}">의미분석</c:if>
		                			<c:if test="${result.groupName == 'hate'}">혐오발언</c:if>
		                		</td>
		                		<td>${result.rabelStat}</td>
		                		<td title="${result.subject}"><div class="of_hidden">${result.subject}</div></td>
		                		<td class="left"><div class="of_hidden">${result.content}</div></td>
		                		<td>${result.confId}</td>
		                		<td>${result.regId}</td>
		                		<td><fmt:formatDate value="${result.lastDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                		<td><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
		                		<td>${result.recordSeq}</td>
		                		<td>
		                			<c:if test="${result.recordSeq > 1}"><a href="javascript:fn_detail(${result.recordId})" class="btn_td btn_tbl_labeling">이력 비교</a></c:if>
		                		</td>
	                		</tr>
			            </c:forEach>
	                </c:if>
					<c:if test="${empty list}">
						<tr>
							<td colspan="11">결과가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<t:pagination ref="${pagination}" />	
	</div>
	<!--// full area end -->
</div>
