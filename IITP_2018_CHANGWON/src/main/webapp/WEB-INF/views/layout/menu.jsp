<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul>
	<li><a href="#" <c:if test="${currentMenu == 'statistics'}">class="on"</c:if>>레이블드 데이터 현황</a>
		<div>
			<ul>
				<li><a href="${pageContext.request.contextPath}/statistics/text/list.do">Text 레이블드 데이터</a></li>
				<li><a href="${pageContext.request.contextPath}/statistics/media/list.do">동영상 레이블드 데이터</a></li>
			</ul>
		</div>
	</li>
	<li><a href="#" <c:if test="${currentMenu == 'dataManage'}">class="on"</c:if>>텍스트 데이터 관리</a>
		<div>
			<ul>
				<li><a href="${pageContext.request.contextPath}/data/domain/list.do">도메인/문서관리</a></li>
				<li><a href="${pageContext.request.contextPath}/data/entity/list.do">레이블링 관리</a></li>
				<li><a href="${pageContext.request.contextPath}/auto/list.do" <c:if test="${currentMenu == 'auto'}">class="on"</c:if>>자동 레이블링</a></li>
				<li><a href="${pageContext.request.contextPath}/check/labeling/list.do">레이블링 검증</a></li>
				<li><a href="${pageContext.request.contextPath}/check/entity/list.do">객체 검증</a></li>
				<li><a href="${pageContext.request.contextPath}/check/relation/list.do">관계 검증</a></li>
			</ul>
		</div>
	</li>
	<li><a href="#" <c:if test="${currentMenu == 'mediaManage'}">class="on"</c:if>>동영상 데이터 관리</a>
		<div>
			<ul>
				<li><a href="${pageContext.request.contextPath}/media/mediaList.do">동영상 리스트</a></li>
				<li><a href="${pageContext.request.contextPath}/media/mediaRegist.do">동영상 등록</a></li>
			</ul>
		</div>
	</li>
	<li><a href="${pageContext.request.contextPath}/work/user/list.do" <c:if test="${currentMenu == 'workManage'}">class="on"</c:if>>계정관리</a></li>
	<li><a href="#" <c:if test="${currentMenu == 'workManage'}">class="on"</c:if>>로그인 사용자 : ${ sessionScope.userLoginInfo.userId }</a>
		<div>
			<ul>
				<li><a href="${pageContext.request.contextPath}/work/user/edit.do?userId=${ sessionScope.userLoginInfo.userId }&mode=M">정보 변경</a></li>
				<li><a href="javascript:logout();">로그아웃</a></li>
			</ul>
		</div>
	</li>
</ul>