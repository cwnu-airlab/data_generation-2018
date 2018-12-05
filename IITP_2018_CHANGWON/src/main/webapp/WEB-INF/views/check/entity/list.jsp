<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/check/entity/list.js"></script>
<script type="text/javascript">
$.views.converters("dotrepl", function(val) {
	val = val.replace(/\./gi, '__');
	val = val.replace(/([\s]{1,})/gi, '_')
	val = val.replace(/(\+|\/)/gi, '__');
	val = val.replace(/\)|\(/gi,"--")
	val = val.replace(/(\\|\'|\"|\{|\})/gi, '_');
    return val.replace(/\./gi, '__')
});

$.views.converters("queteRepl", function(val) {
// 	val = encodeURIComponent(val);
	val = val.replace(/\'/gi, "\\'")
    return val;
});
</script>
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
			</div>
		</div>
	</div>
</div>
<!--// 모달 : 레이블 분류 end -->

<!-- page title start -->
<div class="tit_page clear2">
	<h2>객체 검증</h2>
		
		<div class="location">
			<ul>
				<li>Home</li>
				<li>텍스트 데이터 관리</li>
				<li class="loc_this">객체 검증</li>
			</ul>
		</div>
</div>
<!--// page title end -->



<div class="cont">
	<form id="bratCurrentDoc">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		<input type="hidden" name="docType" id="docType" value=""/> 
		<input type="hidden" name="winNum" id="winNum" value=""/> 
	</form>
	<input type="hidden" name="labelGrade" id="labelGrade" value=""/> 
	<!-- full area start -->
	<div class="full_area">
		<input type="hidden" name="groupName" id="groupName" value=""/>
		<input type="hidden" name="entityTag" id="entityTag" value=""/>
		<input type="hidden" name="searchTerm" id="searchTerm" value=""/>
		<!-- 검색 start -->
		<div class="search_area">
			<ul class="search_form">
				<li><a href="#" class="btn_modal btn_tit_box mr_20" name="modal_type01">레이블 분류</a></li>
				<li><label for="search_form01">개체명</label><input type="text" id="entity" class="white w250px" id="search_form01" readonly="readonly" /></li>
				<li><label for="search_form02">키워드</label><input type="text" id="searchTermInfo" onkeydown="javascript:if(event.keyCode==13){fn_search();}"  class="white w250px" id="search_form02" /></li>
				<li><a href="javascript:fn_search();" class="btn_search">검색</a></li>
			</ul>
		</div>
		<!--// 검색 end -->

		<div class="type_label01 clear2">

			<!-- 키워드 start -->
			<div class="label_01" style="width:22% !important;">
				<div class="cont_tit2">키워드 <span id="selectTag"></span> (총 <span id="keywordListCount">0</span>건)</div>
				<div class="cont_gray type_01 clear2">
					<div id="keyword-loading" style="opacity:0.5;width:100%;height:100%;top:0;left:0;position:static;display:none;z-index: 99;">
						<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:45%;left:45%;z-index:100;width:80px;"/>
					</div>
					<!-- 목록 start -->
					<table class="tbl_type01">
						<colgroup>
							<col >
							<col style="width:35%">
						</colgroup>
						<thead>
							<tr>
								<th>키워드</th>
								<th>레이블 개수 <a id="sort_count" href="javascript:fn_keywordSort('count')">▼</a></th>
							</tr>
						</thead>
					</table>
					<div class="tbl_body_wrap">
						<table class="tbl_type01">
							<colgroup>
								<col>
								<col style="width:35%">
							</colgroup>
							<tbody id="keywordList">
							</tbody>
						</table>
					</div>
					<!--// 목록 end -->

				</div>
			</div>
			<!--// 키워드 end -->


			<!-- 우측 영역 start -->
			<div class="label_02" style="padding-left: 22.5% !important;">

				<div class="clear2">
					<!-- top-left start -->
					<div class="label_left" style="width: 33% !important;">
						<div class="cont_tit2"><span id="labelingDocTag"></span> 레이블 된 문서 <span id="labelingListCount">0</span>건(키워드 <span id="labelingCount">0</span>개)
							<div class="tit_opt">
								<a href="javascript:fn_unlabeling();" class="btn_tit_box">언레이블링</a>
							</div>
						</div>
						<div class="cont_gray clear2" style="height:220px;">

							<!-- 목록 start -->
							<table class="tbl_type01">
								<colgroup>
									<col style="width:30px">
									<col>
									<col style="width:100px">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="toggleLablingDocCheck" title="전체 선택/해제"  /></th>
										<th>문서제목</th>
										<th>건수</th>
									</tr>
								</thead>
							</table>
							<div class="tbl_body_wrap">
								<table class="tbl_type01">
									<colgroup>
										<col style="width:30px">
										<col>
										<col style="width:100px">
									</colgroup>
									<tbody id="labelingList">
									</tbody>
								</table>
							</div>
							<!--// 목록 end -->
						</div>
					</div>
					<!--// top-center end -->
					<div class="label_left  ml_5" style="width: 35% !important;">
						<div class="cont_tit2"><span id="wLabelingDocTag"></span> 레이블되지 않은 문서 <span id="worngLabelingListCount">0</span>건(키워드 <span id="wLabelingCount">0</span>개)
							<div class="tit_opt">
								<a href="javascript:fn_worngUnlabeling();" class="btn_tit_box">언레이블링</a>
							</div>
						</div>
						<div class="cont_gray clear2" style="height:220px;">

							<!-- 목록 start -->
							<table class="tbl_type01">
								<colgroup>
									<col style="width:30px">
									<col>
									<col style="width:100px">
								</colgroup>
								<thead>
									<tr>
										<th><input type="checkbox" id="toggleWorngLablingDocCheck" title="전체 선택/해제"  /></th>
										<th>문서제목</th>
										<th>건수</th>
									</tr>
								</thead>
							</table>
							<div class="tbl_body_wrap">
								<table class="tbl_type01">
									<colgroup>
										<col style="width:30px">
										<col>
										<col style="width:100px">
									</colgroup>
									<tbody id="worngLabelingList">
									</tbody>
								</table>
							</div>
							<!--// 목록 end -->
						</div>
					</div>
					<!--// top-center end -->
					
					<!-- top-right start -->
					<div class="label_left ml_5" style="width: 30% !important;">
						<div class="cont_tit2">레이블을 하지 않은 문서 <span id="unlabelingListCount">0</span>건</div>
						<div class="cont_gray clear2" style="height:220px;">

							<!-- 목록 start -->
							<table class="tbl_type01">
								<colgroup>
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>문서제목</th>
									</tr>
								</thead>
							</table>
							<div class="tbl_body_wrap">
								<table class="tbl_type01">
									<colgroup>
										<col>
									</colgroup>
									<tbody id="unLabelingList">
									</tbody>
								</table>
							</div>
							<!--// 목록 end -->

						</div>
					</div>
					<!--// top-right end -->

				</div>

				<!-- 상세보기 start -->
				<div class="mt_30">
					<form id="docInfo">
						<input type="hidden" name="docId" id="docId" value=""/> 
						<input type="hidden" name="groupName" id="docGroupName" value=""/>
						<input type="hidden" name="keywords" id="keyword" value=""/>
						<input type="hidden" name="entityTag" id="entityTagInfo" value=""/>
						<input type="hidden" name="labelingType" id="labelingType" value=""/>
						<input type="hidden" name="userId" id="userId" value="${user.userId}"/> 
						<input type="hidden" name="winNum" id="winNum" value=""/>
					</form>
					<div class="cont_tit2">상세보기
						<div class="tit_opt type_label">
							<a href="javascript:fn_keywordPrev();" class="btn_tit_box type_prev">이전</a>
							<a href="javascript:fn_keywordNext();" class="btn_tit_box type_next">다음</a>
							<a href="javascript:fn_bratEdit();" class="btn_tit_box">편집</a>
						</div>
					</div>
					<div id="brat_scroll" class="cont_gray clear2" style="height:361px;">
						<div id="brat-loading" style="opacity:0.5;width:100%;height:100%;top:0;left:0;position:static;display:none;z-index: 99;">
							<img src="${pageContext.request.contextPath}/resources/images/common/loading.gif" style="position:absolute;top:45%;left:45%;z-index:100;width:80px;"/>
						</div> 
						<div id="brat_viewer1"></div>
					</div>
				</div>
				<!--// 상세보기 end -->
			</div>
			<!--// 우측 영역 end -->
		</div>
	</div>
	<!--// full area end -->
</div>
<script id="tmpl_keyword" type="text/x-jsrender">
{{if #data}}
	{{for keywordList}}
		<tr id="keyword_{{dotrepl:content}}" onclick="javascript:fn_LabelingDoc('{{queteRepl:content}}')">
			{{if content.length > 6}}
				<td class="left" title="{{>content}}">{{>content.substring(0, 6)}}...</td>
			{{else}}
				<td class="left">{{>content}}</td>
			{{/if}}
			<td class="right">{{>count}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>

<script id="tmpl_labelingDoc" type="text/x-jsrender">
{{if #data}}
	{{for labelingList}}
		<tr id="doc_{{>docId}}" onclick="javascript:fn_bratView('labeling','{{>docId}}','{{>recordId}}')">
			<td><input type="checkbox" name="labelingDoc" value="{{>docId}}|{{>recordId}}"/></td>
			<td class="left" title="레이블 건수 : {{>count}}">{{>subject}}</td>
			<td>{{>count}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>

<script id="tmpl_worngLabelingDoc" type="text/x-jsrender">
{{if #data}}
	{{for worngLabelingList}}
		<tr id="doc_{{>docId}}" onclick="javascript:fn_bratView('wlabeling','{{>docId}}','{{>recordId}}')">
			<td><input type="checkbox" name="worngLabelingDoc" value="{{>docId}}|{{>recordId}}"/></td>
			<td class="left">{{>subject}}</td>
			<td>{{>count}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>

<script id="tmpl_unLabelingDoc" type="text/x-jsrender">
{{if #data}}
	{{for unlabelingList}}
		<tr id="doc_{{>docId}}" onclick="javascript:fn_bratView('unlabeling','{{>docId}}','{{>recordId}}')">
			<td class="left" title="등록자 : {{>regId}}">{{>subject}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>

