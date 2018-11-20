<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Set" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts-6.1.1/highcharts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts-6.1.1/heatmap.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/highcharts-6.1.1/treemap.js"></script>
<script>
$(function (){
	Highcharts.chart('videoCatStatistics', {
	    colorAxis: {
	        minColor: '#ffffff',
	        maxColor: '#000000'
	    },
	    legend : {enabled:false},
	    series: [{
	        type: 'treemap',
	        layoutAlgorithm: 'squarified',
	        data: [{
	            name: '방송 클립',
	            value: 24,
	            colorValue: 2
	        }, {
	            name: '게임플레이',
	            value: 66,
	            colorValue: 7
	        }, {
	            name: '블랙박스',
	            value: 21,
	            colorValue: 1
	        }, {
	            name: '영화리뷰',
	            value: 55,
	            colorValue: 6
	        }, {
	            name: '게임리뷰',
	            value: 48,
	            colorValue: 3
	        }, {
	            name: '뷰티',
	            value: 50,
	            colorValue: 4
	        }, {
	            name: '놀이기구',
	            value: 53,
	            colorValue: 5
	        }]
	    }],
	    title: {
	        text: '동영상 카테도리별 Heatmap'
	    }
	});
	
	
	Highcharts.chart('videoLabeledStatistics', {
	    colorAxis: {
	    	minColor: '#ffffff',
	        maxColor: '#000000'
	    },
	    legend : {enabled:false},
	    series: [{
	        type: 'treemap',
	        layoutAlgorithm: 'squarified',
	        data: [{
	            name: '마리오',
	            value: 35,
	            colorValue: 1
	        }, {
	            name: '시승',
	            value: 39,
	            colorValue: 2
	        }, {
	            name: '우든코스터',
	            value: 40,
	            colorValue: 3
	        }, {
	            name: '플래닛 코스터',
	            value: 48,
	            colorValue: 4
	        }, {
	            name: '야간레이스',
	            value: 55,
	            colorValue: 5
	        }, {
	            name: '레이싱선수',
	            value: 60,
	            colorValue: 6
	        }, {
	            name: '스톡카',
	            value: 62,
	            colorValue: 7
	        }, {
	            name: '뷰티',
	            value: 65,
	            colorValue: 8
	        }, {
	            name: '내리막',
	            value: 70,
	            colorValue: 9
	        }, {
	            name: '주차티켓',
	            value: 75,
	            colorValue: 10
	        }, {
	            name: '자동차',
	            value: 79,
	            colorValue: 11
	        }]
	    }],
	    title: {
	        text: '동영상 레이블 Heatmap'
	    }
	});
	
// 	<c:if test="${fn:length(documentChartJson) gt 0}">
// 		var documentChartData = ${documentChartJson};
// 		Highcharts.chart("documentCharts", documentChartData);
// 	</c:if>
// 	<c:if test="${fn:length(groupNameChartJson) gt 0}">
// 		var groupNameChartData = ${groupNameChartJson};
// 		Highcharts.chart("labelingDocumentChart", groupNameChartData);
// 	</c:if>
});

$.views.converters("numToComma",function (number) {
    var parts = number.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");

});
</script>

<!-- page title start -->
<div class="tit_page clear2">
	<h2>동영상 레이블드 데이터</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>레이블드 데이터 현황</li>
		<li class="loc_this">동영상 레이블드 데이터</li>
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
					<div class="cont_tit2">동영상 카테도리별 통계정보</div>
					<div class="cont_gray clear2">
						<div class="float_l" style="width:49%">
							<div class="cont_tit2 mt_10 ml_15">동영상 카테도리별 통계 차트</div>
							<div id="videoCatStatistics">
							</div>
						</div>
						<div class="float_r mr_15" style="width:49%;">
							<div class="cont_tit2 mt_10">동영상 카테도리별 문서 통계</div>
							<table class="tbl_type01">
								<tbody>
									<tr>
										<th scope="col">전체 카테고리 건수</th>
										<td scope="col"></td>
									</tr>
								</tbody>
							</table>
							<div class="mt_10">
								<table class="tbl_type01">
									<colgroup>
										<col />
					                    <col style="width:150px;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">카테고리</th>
										<th scope="col">카테고리 건수</th>
										</tr>
									</thead>
								</table>
								<div class="tbl_body_wrap mr_15" style="top: 94px !important;">
									<table class="tbl_type01">
										<colgroup>
											<col />
						                    <col style="width:150px;" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col"></th>
											<th scope="col"></th>
										</tr>
										</thead>
										<tbody>
											<tr>
												<td>게임플레이</td>
												<td>60</td>
											</tr>
											<tr>
												<td>영화리뷰</td>
												<td>55</td>
											</tr>
											<tr>
												<td>놀이기구</td>
												<td>53</td>
											</tr>
											<tr>
												<td>뷰티</td>
												<td>50</td>
											</tr>
											<tr>
												<td>게임리뷰</td>
												<td>48</td>
											</tr>
											<tr>
												<td>방송 클립</td>
												<td>24</td>
											</tr>
											<tr>
												<td>블랙박스</td>
												<td>21</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!--// top-left end -->
					
				</div>

				<div class="clear2 mt_30">
					<!-- top-left start -->
					<div class="cont_tit2"><span name="selectCat">전체</span> 동영상 레이블 통계정보</div>
					<div class="cont_gray clear2">
						<div class="float_l" style="width:49%">
							<div class="cont_tit2 mt_10 ml_15"><span name="selectCat">전체</span> 동영상 레이블 통계 차트</div>
							<div id="videoLabeledStatistics">
							</div>
						</div>
						<div class="float_r mr_15" style="width:49%;">
							<div class="cont_tit2 mt_10"><span name="selectCat">전체</span> 동영상 레이블 통계</div>
							<div>
								<table class="tbl_type01">
									<colgroup>
										<col />
					                    <col style="width:150px;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">동영상 레이블</th>
										<th scope="col">레이블 건수</th>
										</tr>
									</thead>
								</table>
								<div class="tbl_body_wrap mr_15" style="top: 55px !important;">
									<table class="tbl_type01">
										<colgroup>
											<col />
						                    <col style="width:150px;" />
										</colgroup>
										<thead>
										<tr>
											<th scope="col"></th>
											<th scope="col"></th>
										</tr>
										</thead>
										<tbody>
											<tr>
												<td>자동차</td>
												<td>79</td>
											</tr>
											<tr>
												<td>주차티켓</td>
												<td>75</td>
											</tr>
											<tr>
												<td>내리막</td>
												<td>70</td>
											</tr>
											<tr>
												<td>뷰티</td>
												<td>65</td>
											</tr>
											<tr>
												<td>스톡카</td>
												<td>62</td>
											</tr>
											<tr>
												<td>레이싱선수</td>
												<td>60</td>
											</tr>
											<tr>
												<td>야간레이스</td>
												<td>55</td>
											</tr>
											<tr>
												<td>플래닛 코스터</td>
												<td>48</td>
											</tr>
											<tr>
												<td>우든코스터</td>
												<td>40</td>
											</tr>
											<tr>
												<td>시승</td>
												<td>39</td>
											</tr>
											<tr>
												<td>마리오</td>
												<td>35</td>
											</tr>
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
					<!--// top-left end -->
				</div>
			</div>
			<!--// 우측 영역 end -->
	</div>
	<!--// full area end -->

</div>
