<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/check/labeling/list.js"></script>

<!-- page title start -->
<div class="tit_page clear2">
	<h2>레이블링 검증</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>텍스트 데이터 관리</li>
		<li class="loc_this">레이블링 검증</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<div class="cont">
	<!-- full area start -->
	<form id="docInfo">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="docId" id="docId" value=""/> 
		<input type="hidden" name="colId" id="colId" value=""/>
		<input type="hidden" name="domain" id="domain" value=""/> 
		<input type="hidden" name="groupName" id="groupName" value=""/>
		<input type="hidden" name="searchTerm" id="searchTerm" value=""/>
		<input type="hidden" name="userId" id="userId" value="${user.userId}"/> 
	</form>
	<form id="bratCurrentDoc">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="docType" id="docType" value=""/> 
		<input type="hidden" name="winNum" id="winNum" value=""/> 
	</form>
	<input type="hidden" name="labelGrade" id="labelGrade" value=""/> 
	<div class="full_area">
		<div class="type_label01 clear2">
			<!-- 데이터 분류 체계 start -->
			<div class="label_01">
				<div class="cont_tit2">데이터 분류 체계</div>
				<div id="domain_tree_list" class="cont_gray type_01 clear2">
					${domainJstreeHtml}
				</div>
			</div>
			<!--// 데이터 분류 체계 end -->


			<!-- 우측 영역 start -->
			<div class="label_02">
				<!-- 데이터 파일 start -->
				<div>
					<div class="cont_tit2">문서목록 (총 <span id="docCount">0</span>건)
						<div class="tit_opt">
							<input type="text" class="white" />
							<a href="#" class="btn_tit_box">검색</a>
						</div>							
					</div>
					<div class="tbl_wrap" style="height:187px;">
						<table class="tbl_type02">
							<colgroup>
								<col style="width:60%">
								<col style="width:15%">
								<col style="width:15%">
								<col >
							</colgroup>
							<thead>
								<tr>
									<th scope="col">문서제목</th>
									<th scope="col">문서분류</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
								</tr>
							</thead>
						</table>
						<div class="tbl_body_wrap">
							<table class="tbl_type02">
								<colgroup>
									<col style="width:60%">
									<col style="width:15%">
									<col style="width:15%">
									<col >
								</colgroup>
								<tbody id="docList">
									<tr>
										<td colspan="4">보고싶은 문서가 있는 도메인을 선택하세요.</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!--// 데이터 파일 end -->

				<!-- 개체명 레이블드 데이터 start -->
				<div class="mt_30">
					<div class="cont_tit2"><div id="labelingGroup" style="display:inline-block;">개체명</div> 레이블드 데이터
						<div class="tit_opt">
							<a href="#" class="btn_tit_box btn_modal" name="modal_type01">레이블 분류</a>
							<a href="javascript:fn_bratEdit()" class="btn_tit_box">편집</a>
						</div>
					</div>
					<div id="docContent" class="cont_gray clear2" style="height:395px;">
						<div id="brat-loading" style="opacity:0.5;width:100%;height:100%;top:0;left:0;position:static;display:none;z-index: 99;">
							<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:45%;left:45%;z-index:100;width:80px;"/>
						</div>
						<div id="brat_viewer1"></div>
					</div>
				</div>
				<!--// 개체명 레이블드 데이터 end -->
			</div>
			<!--// 우측 영역 end -->
		</div>
	</div>
	<!--// full area end -->
</div>
		
<!-- 모달 : 레이블 분류 start -->
<div class="modal" id="modal_type01">
	<div class="modal_in" style="width:400px;">
		<div class="modal_tit clear2">
			레이블 분류
			<a href="#" class="btn_modal_close" title="창 닫기">창 닫기</a>
		</div>

		<div class="modal_cont">

			<ul class="form_radio">
				<li><input type="radio" name="label_radio" value="namedentity" checked="checked" id="label_radio01" /><label for="label_radio01">개체명</label></li>
				<li><input type="radio" name="label_radio" value="simentic" id="label_radio02" /><label for="label_radio02">의미역</label></li>
				<li><input type="radio" name="label_radio" value="simentic_analysis" id="label_radio03" /><label for="label_radio03">의미분석</label></li>
				<li><input type="radio" name="label_radio" value="hate" id="label_radio04" /><label for="label_radio04">혐오발언</label></li>
			</ul>

			<div id="namedentity_tree_list_modal" class="pop_tree_wrap" style="display:none">
				${namedentityJstreeHtml}
			</div>
			<div id="simentic_tree_list_modal" class="pop_tree_wrap" style="display:none">
				${simenticJstreeHtml}
			</div>
			<div id="simentic_analysis_tree_list_modal" class="pop_tree_wrap" style="display:none">
				${simenticAanlysisJstreeHtml}
			</div>
			<div id="hate_tree_list_modal" class="pop_tree_wrap" style="display:none">
				${hateJstreeHtml}
			</div>

			<div class="pop_btnset_foot">
				<a href="javascript:modalConfirm();" class="btn_tit_box type_medium">확인</a>
				<a href="#" class="btn_tit_box type_medium type_cancel">취소</a>
			</div>
		</div>
	</div>
</div>
<!--// 모달 : 레이블 분류 end -->
<script id="tmpl_doc" type="text/x-jsrender">
{{if #data}}
	{{for docList}}
		<tr style="cursor:pointer;" onclick="javascript:fn_bratView('{{>docId}}', '{{>groupName}}')">
			<td class="left">{{>subject}}</td>
			{{if groupName == 'namedentity'}}
				<td>개채명</td>
			{{else groupName == 'simentic'}}
				<td>의미역</td>
			{{else groupName == 'simentic_analysis'}}
				<td>의미분석</td>
			{{else groupName == 'hate'}}
				<td>혐오발언</td>
			{{else}}
				<td>NONE</td>
			{{/if}}
			<td>{{>regId}}</td>
			<td>{{>date}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>