<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.svg-1.5.0/jquery.svg.min.js"></script> 
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery.svg-1.5.0/jquery.svgdom.min.js"></script>

<!-- brat setting -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/brat/style-vis.css"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/configuration.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/util.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/annotation_log.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/lib/webfont.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/dispatcher.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/url_monitor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/brat/client/src/visualizer.js"></script>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/work/document/detail.js"></script>

<script type="text/javascript">
$(function(){
	
	$('#btn_docu_history').click(function(){
		
		var element_this = $(this);
		
		if($(this).hasClass('on')){
			history_close(element_this);
		}else{
			history_show(element_this);
		};
		return false;
	});
	
	function history_show(element_this){
		element_this.addClass('on');
		element_this.next('.history_list').fadeIn();
		element_this.text('이력 닫기');
	};
	
	function history_close(element_this){
		element_this.removeClass('on');
		element_this.next('.history_list').hide();
		element_this.text('이력 보기');
	};
	

});
</script>

<!-- page title start -->
<div class="tit_page clear2">
	<h2>문서작업관리</h2><span>수정된 문서 이력을 관리할 수 있습니다.</span>
	<div class="location">
		<ul>
		<li>Home</li>
		<li>작업관리</li>
		<li class="loc_this">문서작업관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">
	<form id="docInfo">
		<input type="hidden" name="docId" id="docId" value="${doc.docId}"/> 
		<input type="hidden" name="colId" id="colId" value="${doc.colId}"/>
		<input type="hidden" name="domain" id="domain" value="${doc.domain}"/> 
		<input type="hidden" name="groupName" id="groupName" value="${doc.groupName}"/>
		<input type="hidden" name="recordSeq" id="recordSeq" value="${doc.recordSeq}"/>
		<input type="hidden" name="recordId" id="recordId" value="${doc.recordId}"/>
		<input type="hidden" name="lastRecordSeq" id="lastRecordSeq" value="${lastRecordSeq}"/>
	</form>
	<!-- full area start -->
	<div class="full_area">
	
		<!-- 기본정보 start -->
		<table class="tbl_type02 type_write2 mb_20">
			<colgroup>
				<col style="width:8%" />
				<col style="width:12%" />
				<col style="width:8%" />
				<col style="width:12%" />
				<col style="width:8%" />
				<col style="width:12%" />
				<col style="width:8%" />
				<col style="width:12%" />
				<col style="width:8%" />
				<col style="width:12%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">도메인명</th>
					<td>${doc.domainPath}</td>
					<th scope="row">문서제목</th>
					<td>${doc.subject}</td>
					<th scope="row">그룹</th>
					<td>
						<c:if test="${doc.groupName == 'namedentity'}">개체명</c:if>
               			<c:if test="${doc.groupName == 'simentic'}">의미역</c:if>
               			<c:if test="${doc.groupName == 'simentic_analysis'}">의미분석</c:if>
               			<c:if test="${doc.groupName == 'hate'}">혐오발언</c:if>
	                </td>
					<th scope="row">레이블링</th>
					<td>${doc.rabelStat}</td>
					<th scope="row">작업완료 확인자</th>
					<td>${doc.confId}</td>
				</tr>
			</tbody>
		</table>
		<!--// 기본정보 end -->

		<div class="type_label02 clear2">

			<!-- 좌측 영역 start -->
			<div class="label_01">
				<div class="cont_tit2">현재 <span class="font_l font_12"><fmt:formatDate value="${doc.lastDate}" pattern="yyyy-MM-dd HH:mm:ss"/> (최종작업 : ${doc.regId})</span></div>
				<div id="brat_scroll1"  class="cont_gray type_01" style="height:547px;">
					<div id="brat-loading1" style="opacity:0.5;width:100%;height:100%;top:0;left:0;position:static;display:none;z-index: 99;">
						<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:45%;left:23%;z-index:100;width:80px;"/>
					</div>
					<div id="brat_viewer1">
					</div>
				</div>
			</div>
			<!--// 좌측 영역 end -->

			<!-- 우측 영역 start -->
			<div class="label_02">
				<div class="cont_tit2">이력 
					<span id="lastBratRegDate" class="font_l font_12"></span>
					<div class="docu_history" style="margin-right:150px;">
						<a href="#" id="btn_docu_history" class="btn_tit_box">이력 보기</a>
						<div class="history_list">
							<ul id="jobList">
								<c:if test="${not empty job}">
								<c:forEach var="result" items="${job}" varStatus="status">
									<li id="history_${result.recordSeq}">
										<a href="javascript:fn_LastBratView('${result.recordSeq}')">
										<fmt:formatDate value="${result.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/> (최종 작업 : ${result.regId}) </a>
									</li>
								</c:forEach>
								</c:if>
								<c:if test="${empty job}">
									<li><a href="">이력없음</a></li>
								</c:if>
							</ul>
						</div>
					</div>			
				</div>
				<div id="brat_scroll2" class="cont_gray type_01" style="height:547px;">
					<c:if test="${empty job}">
						<div class="doc_history_none">이력이 존재하지않습니다.</div>
					</c:if>
					<c:if test="${not empty job}">
						<div id="brat-loading2" style="opacity:0.5;width:100%;height:100%;top:0;left:0;position:static;display:none;z-index: 99;">
							<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:45%;left:75%;z-index:100;width:80px;"/>
						</div>
						<div id="brat_viewer2">
						</div>
					</c:if>
				</div>
			</div>
			<!--// 우측 영역 end -->

		</div>
	

		<div class="align_r mt_10">
			<span class="float_l"><a href="${pageContext.request.contextPath}/work/document/list.do" class="btn b_gray medium">목록</a></span>
			<span class="float_r"><a href="javascript:fn_restore();" class="btn b_orange medium">복원</a></span>
		</div>
	</div>
	<!--// full area end -->
</div>
<!--// content end -->
<div id="div-loading" style="background-color:#fffff;opacity:0.5;width:100%;height:100%;top:0;left:15%;position:fixed;z-index: 99; display:none;">
	<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:40%;left:40%;z-index:100;width:80px;"/>
</div>

