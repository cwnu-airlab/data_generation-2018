<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
		<title>학습데이터 관리도구</title>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/style.css" />" />
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-1.9.0.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-ui.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery-migrate-1.4.1.js"/>"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/datepicker_kr.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/common.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jquery.mCustomScrollbar.concat.min_3x.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jsrender.min.js" />"></script>
		<script type="text/javascript" src="<c:url value="/resources/js/jstree-3.3.4/jstree.min.js" />"></script>
		<link rel="stylesheet" type="text/css" href="<c:url value="/resources/js/jstree-3.3.4/themes/default/style.min.css"/>" />
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/moment.js-2.17.1/moment-with-locales.min.js"></script>
		<script>
		var contextPath = '${pageContext.request.contextPath}';
		$(function(){
			$(".tbl_body_wrap").mCustomScrollbar({
				theme:"dark-thin"
			});
		});
		</script>
	</head>
	<body>
		<div id="wrapper">
			<!-- header start -->
			<div class="header">
				<tiles:insertAttribute name="header" />
			</div>
			<!--// header end -->
			<!-- content start -->
			<div id="content">
				<tiles:insertAttribute name="content" />
			</div>
			<!--// content end -->
			<!-- footer start -->
			<tiles:insertAttribute name="footer" />
			<!--// footer end -->
		</div>
	</body>
</html>
