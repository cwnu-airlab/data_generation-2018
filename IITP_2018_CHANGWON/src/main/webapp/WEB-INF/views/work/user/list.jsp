<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/data/document/list.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<script>
	function deleteUser(userId) {
		if(confirm("'"+userId+"' 계정을 삭제하시겠습니까?")) {
			$.ajax({
				url: "${pageContext.request.contextPath}/work/user/deleteUser.do",
				method: "post",
				data: {userId:userId},
				success:function(data){
					if(data.result == "success") {
						alert("계정 삭제가 되었습니다.");
						window.location.href = "${pageContext.request.contextPath}/work/user/list.do";
					} else if(data.result == "fail") {
						alert("계정 삭제를 실패하였습니다.");
					}
				},
			    error:function(request,status,error){
			        
			    },
				complete:function(){
					
				}
			});	
		}
	}
</script>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>계정관리</h2><span>사용자 계정을 관리할 수 있습니다.</span>

	<div class="location">
		<ul>
		<li>Home</li>
		<li>작업관리</li>
		<li class="loc_this">계정관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<div class="cont">
	<!-- full area start -->
	<div class="full_area">

		<div class="cont_tit2">
			<div class="tit_opt float_r">
				<c:if test="${ sessionScope.userLoginInfo.type eq 'SUPER' }">
					<a href="${pageContext.request.contextPath}/work/user/edit.do?mode=C" class="btn_tit_box">추가</a>
				</c:if>
			</div>							
		</div>
		<div class="tbl_wrap">
			<table class="tbl_type02">
				<colgroup>
					<col style="width:100px;" />
                    <col />
                    <col />
                    <col style="width:150px;" />
                    <col style="width:150px;" />
                    <col style="width:150px;" />
                    <col style="width:150px;" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">번호</th>
                		<th scope="col">아이디</th>
                		<th scope="col">이름</th>
                		<th scope="col">구분</th>
                		<th scope="col">최종 변경일</th>
                		<th scope="col">등록일</th>
                		<th scope="col">관리</th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${not empty list}">
						<c:forEach var="result" items="${list}" varStatus="status">
							<tr>
								<td>${status.index+1}</td>
								<td>${result.userId}</td>
								<td>${result.username}</td>
								<td>
									<c:choose>
										<c:when test="${result.type eq 'SUPER'}">최고 관리자</c:when>
										<c:when test="${result.type eq 'ADMIN'}">관리자</c:when>
										<c:when test="${result.type eq 'USER'}">사용자</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</td>
								<td><fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${result.modDate}" pattern="yyyy-MM-dd"/></td>
								<td>
									<c:choose>
										<c:when test="${ result.userId eq 'super' }">
										</c:when>
										<c:when test="${ sessionScope.userLoginInfo.type eq 'SUPER' }">
											<a href="${pageContext.request.contextPath}/work/user/edit.do?userId=${result.userId}&mode=M" class="btn_edit">수정</a>
											<a href="javascript:deleteUser('${result.userId}');" class="btn_delete">삭제</a>
										</c:when>
										<c:when test="${ sessionScope.userLoginInfo.userId eq result.userId }">
											<a href="${pageContext.request.contextPath}/work/user/edit.do?userId=${result.userId}&mode=M" class="btn_edit">수정</a>
											<a href="javascript:deleteUser('${result.userId}');" class="btn_delete">삭제</a>
										</c:when>
									</c:choose>
		                		</td>
		               		</tr>
						</c:forEach>
					</c:if>
					<c:if test="${empty list}">
						<tr>
							<td colspan="7">검색결과가 없습니다.</td>
	               		</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<t:pagination ref="${pagination}" />	
	</div>
	<!--// full area end -->
</div>
<!--// content end -->
<div id="div-loading" style="background-color:#fffff;opacity:0.5;width:100%;height:100%;top:0;left:15%;position:fixed;z-index: 99; display:none;">
	<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:40%;left:40%;z-index:100;width:80px;"/>
</div>
