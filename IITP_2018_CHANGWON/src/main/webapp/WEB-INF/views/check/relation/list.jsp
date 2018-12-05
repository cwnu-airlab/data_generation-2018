<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/check/relation/list.js"></script>
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
	val = encodeURIComponent(val);
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
				<li><input type="radio" name="label_radio" value="simentic" id="label_radio02" checked="checked" /><label for="label_radio02">의미역</label></li>
			</ul>

			<div id="simentic_tree_list_modal" class="pop_tree_wrap" style="display:none">
				${simenticJstreeHtml}
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
	<h2>관계 검증</h2>
	<div class="location">
		<ul>
		<li>Home</li>
		<li>텍스트 데이터 관리</li>
		<li class="loc_this">관계 검증</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">
	<!-- full area start -->
	<div class="full_area">
		<!-- 검색 start -->
		<input type="hidden" name="groupName" id="groupName" value=""/>
		<input type="hidden" name="searchTerm" id="searchTerm" value=""/>
		<div class="search_area">
			<ul class="search_form">
				<li><a href="#" class="btn_modal btn_tit_box mr_20" name="modal_type01">레이블 분류</a></li>
				<li><label for="relation">관계 검증</label><input type="text" class="white w200px" id="relation" readonly="readonly"/></li>
				<li><label for="keywordInput1">키워드 1</label><input type="text" id="keywordInput1" onkeyup="javascript:fn_keywordSearch('start');" onkeydown="javascript:if(event.keyCode==13){fn_search();}" class="white w200px ml_10 mr_30" title="키워드1 입력" /></li>
				<li><label for="keywordInput2">키워드 2</label><input type="text" id="keywordInput2" onkeyup="javascript:fn_keywordSearch('end');" onkeydown="javascript:if(event.keyCode==13){fn_search();}" class="white w200px ml_10 mr_30" title="키워드2 입력"   /></li>
				<li><a href="javascript:fn_search();" class="btn_search">검색</a></li>
			</ul>
		</div>
		<!--// 검색 end -->

		<div class="type_label03 clear2">

			<!-- 키워드 start -->
			<div class="label_01" style="width: 16% !important;">
				<div class="cont_tit2">키워드 1(총 <span id="keywordListCount1">0</span>건)</div>
				<div class="cont_gray type_01 clear2">

					<!-- 목록 start -->
					<table class="tbl_type01">
						<colgroup>
							<col style="width:70%">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>키워드</th>
								<th>건수</th>
							</tr>
						</thead>
					</table>
					<div class="tbl_body_wrap">
						<table class="tbl_type01">
							<colgroup>
								<col style="width:70%">
								<col>
							</colgroup>
							<tbody id="keywordList1">
							</tbody>
						</table>
					</div>
					<!--// 목록 end -->
				</div>
			</div>
			<!--// 키워드 end -->
			<div class="label_02" style="width: 16% !important;left: 16.5% !important;">
				<div class="cont_tit2">키워드 2(총 <span id="keywordListCount2">0</span>건)</div>
				<div class="cont_gray type_01 clear2">

					<!-- 목록 start -->
					<table class="tbl_type01">
						<colgroup>
							<col style="width:70%">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th>키워드</th>
								<th>건수</th>
							</tr>
						</thead>
					</table>
					<div class="tbl_body_wrap">
						<table class="tbl_type01">
							<colgroup>
								<col style="width:70%">
								<col>
							</colgroup>
							<tbody id="keywordList2">
							</tbody>
						</table>
					</div>
					<!--// 목록 end -->

				</div>
			</div>
			<!--// 키워드 end -->


			<!-- 우측 영역 start -->
			<div class="label_03" style="padding-left: 34% !important;">

				<div class="clear2">
					<!-- top-left start -->
					<div class="label_left" style="width: 49.5% !important;">
						<div class="cont_tit2"><span name="keyword"></span> 레이블링 된 문서(총 <span id="labelingListCount">0</span>건)</div>
						<div class="cont_gray clear2" style="height:220px;">

							<!-- 목록 start -->
							<table class="tbl_type01">
								<colgroup>
									<col style="width:70%">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>문서제목</th>
										<th>건수</th>
									</tr>
								</thead>
							</table>
							<div class="tbl_body_wrap">
								<table class="tbl_type01">
									<colgroup>
										<col style="width:70%">
										<col>
									</colgroup>
									<tbody id="labelingList">
									</tbody>
								</table>
							</div>
							<!--// 목록 end -->
						</div>
					</div>
					<!--// top-left end -->
					
					<!-- top-right start -->
					<div class="label_right" style="width: 49.5% !important;">
						<div class="cont_tit2"><span name="keyword"></span> 레이블링 안된 문서(총 <span id="unlabelingListCount">0</span>건)</div>
						<div class="cont_gray clear2" style="height:220px;">

							<!-- 목록 start -->
							<table class="tbl_type01">
								<colgroup>
									<col style="width:75%">
									<col>
								</colgroup>
								<thead>
									<tr>
										<th>문서제목</th>
										<th>등록자</th>
									</tr>
								</thead>
							</table>
							<div class="tbl_body_wrap">
								<table class="tbl_type01">
									<colgroup>
										<col style="width:75%">
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
						<input type="hidden" name="groupName" id="docGroupName" value=""/>
						<input type="hidden" name="docId" id="docId" value=""/>
						<input type="hidden" name="recordId" id="recordId" value=""/>
						<input type="hidden" name="userId" id="userId" value="${user.userId}"/> 
						<input type="hidden" name="winNum" id="winNum" value=""/>
						<input type="hidden" name="startPoint" id="keyword1" value=""/>
						<input type="hidden" name="endPoint" id="keyword2" value=""/>
					</form> 
					<input type="hidden" name="labelGrade" id="labelGrade" value=""/> 
					<div class="cont_tit2">상세보기
						<div class="tit_opt type_label">
							<a href="javascript:fn_keywordPrev();" class="btn_tit_box type_prev">이전</a>
							<a href="javascript:fn_keywordNext();" class="btn_tit_box type_next">다음</a>
							<a href="javascript:fn_bratEdit();" class="btn_tit_box">편집</a>
						</div>
					</div>
					<div  id="brat_scroll" class="cont_gray clear2" style="height:361px;">
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
<script id="tmpl_keyword1" type="text/x-jsrender">
{{if #data}}
	{{for keywordList}}
	<tr id="keyword_{{dotrepl:content}}" onclick="javascript:setKeyword1('{{>typeOpt}}','{{queteRepl:content}}')">
			{{if content.length > 15}}
				<td class="left" title="{{>content}}">{{>content.substring(0, 15)}}...</td>
			{{else}}
				<td class="left">{{>content}}</td>
			{{/if}}
			<td class="right">{{>count}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>
<script id="tmpl_keyword2" type="text/x-jsrender">
{{if #data}}
	{{for keywordList}}
	<tr id="keyword_{{dotrepl:content}}" onclick="javascript:setKeyword2('{{>typeOpt}}','{{queteRepl:content}}')">
			{{if content.length > 15}}
				<td class="left" title="{{>content}}">{{>content.substring(0, 15)}}...</td>
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
			<td class="left">{{>subject}}</td>
			<td class="right">{{>count}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>

<script id="tmpl_unLabelingDoc" type="text/x-jsrender">
{{if #data}}
	{{for unlabelingList}}
		<tr id="doc_{{>docId}}" onclick="javascript:fn_bratView('unlabeling','{{>docId}}','{{>recordId}}')">
			<td class="left">{{>subject}}</td>
			<td>{{>regId}}</td>
		</tr>
	{{/for}}
{{/if}}
</script>