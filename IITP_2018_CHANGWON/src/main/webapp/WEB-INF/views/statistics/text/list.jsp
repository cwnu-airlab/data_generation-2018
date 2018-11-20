<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts-6.1.1/highcharts.js"></script>
<script>
$(function (){
	<c:if test="${fn:length(documentChartJson) gt 0}">
		var documentChartData = ${documentChartJson};
		Highcharts.chart("documentCharts", documentChartData);
	</c:if>
	<c:if test="${fn:length(groupNameChartJson) gt 0}">
		var groupNameChartData = ${groupNameChartJson};
		Highcharts.chart("labelingDocumentChart", groupNameChartData);
	</c:if>
});

$.views.converters("numToComma",function (number) {
    var parts = number.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");

});
function fn_labelingTagPieChart(groupName){
	
	$.ajax({
		url : '<c:url value="/statistics/text/lableingChatJson.do"/>?_format=json',
		type : 'post',
		dataType : 'json',
		data : {"groupName" : groupName},
		success : function (data){
			if (groupName == 'namedentity') {
				$("span[name=groupName]").html("개체명");
			} else if (groupName == 'simentic') {
				$("span[name=groupName]").html("의미역");
			} else if (groupName == 'simentic_analysis') {
				$("span[name=groupName]").html("의미분석");
			} else if (groupName == 'hate') {
				$("span[name=groupName]").html("혐오발언");
			}
			Highcharts.chart("groupContentChart", data.chartJson);
			var template =  $.templates("#template_groupByTagTable");
		    var html = template.render(data);
		    $("#groupTableList").html(html);
			$("#groupByTagInfo").show();
			console.log(data);
			
		},
		error : function (data) {
			
		}
	});
	return false;
}

function fn_tagByContents(groupName, tagName, tagLabels){
	
	$.ajax({
		url : '<c:url value="/statistics/text/tagByContents.do"/>?_format=json',
		type : 'post',
		dataType : 'json',
		data : {"groupName" : groupName, "tagName" : tagName},
		success : function (data){
			var titleInfo = ''
			if (groupName == 'namedentity') {
				titleInfo = '개체명의 ' + tagLabels
			} else if (groupName == 'simentic') {
				titleInfo = '의미역의 ' + tagLabels
			} else if (groupName == 'simentic_analysis') {
				titleInfo = '의미분석의 ' + tagLabels
			} else if (groupName == 'hate') {
				titleInfo = '혐오발언의 ' + tagLabels
			}
			
			$("span[name=tagName]").html(titleInfo);
			var template =  $.templates("#template_tagByContentsTable");
		    var html = template.render(data.contentTagList);
		    $("#tagByContentTables").html(html);
			$("#tagByContents").show();
			console.log(data);
			
		},
		error : function (data) {
			
		}
	});
	return false;
}
</script>

<!-- page title start -->
<div class="tit_page clear2">
	<h2>Text 레이블드 데이터</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>레이블드 데이터 현황</li>
		<li class="loc_this">Text 레이블드 데이터</li>
		</ul>
	</div>
</div>
<!--// page title end -->



<div class="cont">

	<!-- full area start -->
	<div class="full_area">

			
			<!-- 우측 영역 start -->
			<div class="label_02">

				<div class="clear2">
					<!-- top-left start -->
					<div class="cont_tit2">문서 통계정보</div>
					<div class="cont_gray clear2">
						<div class="float_l" style="width:49%">
							<div class="cont_tit2 mt_10 ml_15">도메인 별 문서 통계 차트</div>
							<div id="documentCharts">
							</div>
						</div>
						<div class="float_r mr_15" style="width:49%;">
							<div class="cont_tit2 mt_10">도메인 별 문서 통계</div>
							<table class="tbl_type02 mr_10">
								<colgroup>
									<col />
				                    <col style="width:25%;" />
				                    <col style="width:100px;" />
				                    <col style="width:100px;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">최상위 도메인</th>
									<th scope="col">도메인</th>
									<th scope="col">문서건수</th>
									<th scope="col">비율</th>
								</tr>
								</thead>
								<tbody>
								<%
									Map<String, Map<String, Double>> resDocRate = (Map<String, Map<String, Double>>)request.getAttribute("resDocRate");
									Map<String, Map<String, Integer>> resDocCnt	 = (Map<String, Map<String, Integer>> )request.getAttribute("resDocCnt");
									Set<String> rootKeys = resDocRate.keySet();
									int i = 0;
									for(String rootKey : rootKeys){
										Map<String, Double> subDocRate = resDocRate.get(rootKey);
										Map<String, Integer> subDocCnt = resDocCnt.get(rootKey);
										Set<String> colKeys = subDocRate.keySet();
										int j = 0;
										for(String colKey : colKeys){
											out.println("<tr>");
											if(j == 0){
												out.println("<td rowspan=\""+colKeys.size()+"\">"+rootKey+"</td>");
												out.println("<td>"+colKey+"</td>");
											} else {
												out.println("<td>"+colKey+"</td>");
											}
											out.println("<td>"+NumberFormat.getInstance().format(subDocCnt.get(colKey))+"</td>");
											out.println("<td>"+NumberFormat.getInstance().format((subDocRate.get(colKey) * 100))+"%</td>");
											out.println("</tr>");
											j++;
										}
										i++;
									}
								%>
								</tbody>
							</table>
						</div>
					</div>
					<!--// top-left end -->
					
				</div>

				<div class="clear2 mt_30">
					<!-- top-left start -->
					<div class="cont_tit2">레이블 분류별 문서 통계정보</div>
					<div class="cont_gray clear2">
						<div class="float_l" style="width:49%">
							<div class="cont_tit2 mt_10 ml_15">레이블 별 문서 통계 차트</div>
							<div id="labelingDocumentChart">
							</div>
						</div>
						<div class="float_r mr_15" style="width:49%;">
							<div class="cont_tit2 mt_10">레이블 별 문서 통계</div>
							<table class="tbl_type02 mr_10 mb_10">
								<colgroup>
				                    <col />
				                    <col style="width:100px;" />
				                    <col style="width:100px;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">레이블</th>
									<th scope="col">문서건수</th>
									<th scope="col">비율</th>
								</tr>
								</thead>
								<tbody>
									<c:forEach var="item" items="${groupNameStatistics}">
										<tr>
											<td>
												<c:choose>
													<c:when test="${'namedentity' eq (fn:toLowerCase(item.groupName))}">
														<a href="javascript:fn_labelingTagPieChart('${item.groupName}')">개채명 레이블 분류 문서</a>
													</c:when>
													<c:when test="${'simentic' eq (fn:toLowerCase(item.groupName))}">
														<a href="javascript:fn_labelingTagPieChart('${item.groupName}')">의미역 레이블 분류 문서</a>
													</c:when>
													<c:when test="${'simentic_analysis' eq (fn:toLowerCase(item.groupName))}">
														<a href="javascript:fn_labelingTagPieChart('${item.groupName}')">의미 분석 레이블 분류 문서</a>
													</c:when>
													<c:when test="${'hate' eq (fn:toLowerCase(item.groupName))}">
														<a href="javascript:fn_labelingTagPieChart('${item.groupName}')">혐오발언</a>
													</c:when>
													<c:otherwise>
														 레이블 분류가 되지 않은 문서
													</c:otherwise>
												</c:choose>
											</td>
											<td><fmt:formatNumber value="${item.cnt}" /></td>
											<td><fmt:formatNumber value="${(item.rate * 100)}" />%</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!--// top-left end -->
				</div>
				<!-- 상세보기 start -->
				<div id="groupByTagInfo" class="clear2 mt_30" style="display: none;">
					<!-- top-left start -->
					<div class="cont_tit2"><span name="groupName"></span> 분류 레이블 태그 통계정보</div>
					<div class="cont_gray clear2">
						<div class="float_l" style="width:49%">
							<div class="cont_tit2 mt_10 ml_15"><span name="groupName"></span> 분류 레이블 태그 통계 차트</div>
							<div id="groupContentChart">
							</div>
						</div>
						<div class="float_r mr_15" style="width:49%;">
							<div class="cont_tit2 mt_10"><span name="groupName"></span> 분류 레이블 태그 통계</div>
							<table class="tbl_type02 mr_10 mb_10">
								<colgroup>
				                    <col />
				                    <col style="width:100px;" />
				                     <col style="width:100px;" />
								</colgroup>
								<thead>
								<tr>
									<th scope="col">태그</th>
									<th scope="col">태깅건수</th>
									<th scope="col">태깅비율</th>
								</tr>
								</thead >
								<tbody id="groupTableList">
								</tbody>
							</table>
						</div>
					</div>
					<!--// top-right end -->
				</div>
				<!--// 상세보기 end -->
				<!-- 상세보기 start -->
				<div id="tagByContents" class="clear2 mt_30" style="display: none;">
					<!-- top-left start -->
					<div class="cont_tit2"><span name="tagName"></span> 통계정보</div>
					<div class="cont_gray clear2">
						<div class="cont_tit2 mt_10 ml_15"><span name="tagName"></span> 레이블 키워드 통계 (Top 100)</div>
						<div id="tagByContentTables">
						</div>
					</div>
					<!--// top-right end -->
				</div>
				<!--// 상세보기 end -->
			</div>
			<!--// 우측 영역 end -->
	
	</div>
	<!--// full area end -->

</div>

<script id="template_groupByTagTable" type="text/javascript">
	{{if #data}}
		{{for tableJson}}
			<tr>
				<td><a href="javascript:fn_tagByContents('{{>groupName}}', '{{>name}}', '{{>tagName}}')">{{>tagName}}</a></td>
				<td>{{numToComma:cnt}}</td>
				<td>{{>(rate * 100).toFixed(2)}}%</td>
			</tr>
		{{/for}}
	{{/if}}
</script>

<script id="template_tagByContentsTable" type="text/javascript">
	{{if  #index > 0}}
		<table class="tbl_type02 mr_10 mb_10 float_l" style="width:24% !important;">
	{{else}}
		<table class="tbl_type02 ml_5 mr_10 mb_10 float_l" style="width:24%  !important;">
	{{/if}}
		<colgroup>
	        <col />
	        <col style="width:100px;" />
		</colgroup>
		<thead>
		<tr>
			<th scope="col">태그</th>
			<th scope="col">태깅건수</th>
		</tr>
		</thead >
		<tbody id="groupTableList">
			{{for}}
				<tr>
					<td><a href="#">{{>content}}</a></td>
					<td><a href="#">{{numToComma:cnt}}</td>
				</tr>
			{{/for}}
		</tbody>
	</table>
</script>