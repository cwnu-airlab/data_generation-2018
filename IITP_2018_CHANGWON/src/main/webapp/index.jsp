<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
<%
if(session.getAttribute("userLoginInfo") != null){
%>
location.href="${pageContext.request.contextPath}/statistics/text/list.do";
<%
} else {
%>
location.href="${pageContext.request.contextPath}/login/loginForm.do";
<%
}
%>
</script>

