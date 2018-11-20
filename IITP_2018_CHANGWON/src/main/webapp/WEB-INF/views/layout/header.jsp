<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
	function logout() {
		$("#logoutForm").submit();
	}
</script>
<div class="head_top clear">
	<!-- menu start -->
	<c:url value="/logout" var="logoutUrl" /> 
	<form id="logoutForm" name="frm" action="${logoutUrl}" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	</form>
	<a href="#" class="btn_menu">메뉴</a>
	<div class="menu">
		<tiles:insertAttribute name="menu" />
	</div>
	<!--// menu end -->

	<h1>딥러닝용 학습데이터 구축/관리도구<span>(2018년 SW컴퓨팅산업원천기술개발사업)</span></h1>
</div>