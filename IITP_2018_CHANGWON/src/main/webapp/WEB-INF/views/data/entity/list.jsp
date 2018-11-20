<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/data/domain/list.js"></script>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/lib/select2-4.0.3/css/select2-custom.css"/> --%>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/data/entity/list.js"></script>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>레이블링</h2>
	<div class="location">
		<ul>
		<li>홈</li>
		<li>텍스트 데이터 관리</li>
		<li class="loc_this">레이블링 관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">

	<!-- full area start -->
	<div class="full_area">
	
		<div class="type_label01 clear2">
<!-- 	javascript:fn_upload(); -->
			<!-- 아코디언 start -->
			<div class="label_01">
				<div class="cont_tit2">
					<input type="file" id="uploadFile" placeholder="파일을 선택해 주세요" style="display:none;" class="white w100px">
					<input type="hidden" id="uploadOpt"/>
						
					레이블링 객체 / 관계 목록 
					<a href="#" class="btn_icon_download_black float_r ml_5"  title="양식 다운로드"></a>
					<a href="#" onclick="fn_delete(); return false;" title="선택한 객체 제거" class="btn_icon_delete float_r ml_5"></a>				
					<a href="#" onclick="fn_editEntity(); return false;" title="선택한 객체 편집" class="btn_icon_edit float_r ml_5"></a>
				</div>
				<ul class="label_accordion">
					<li id="namedentity">
						<p class="cont_tit3 clear2">개체명
							<a href="#" class="btn_label_onoff" title="펼치기"></a>
							<a href="javascript:fn_excelDown('namedentity')" class="btn_icon_download_white float_r mr_25" title="개체명 설정 다운로드"></a>
							<a href="javascript:fn_upload('namedentity');" class="btn_icon_upload_wihte float_r mr_10" title="개체명 설정 다운로드"></a> </p>
						<div  class="cont_gray clear2" style="height:507px;">
							<div id="namedentity_tree_list">
								${namedentityJstreeHtml}
							</div>
						</div>
					</li>
					<li id="simentic">
						<p class="cont_tit3 clear2">의미역
						<a href="#" class="btn_label_onoff" title="펼치기"></a>
						<a href="javascript:fn_excelDown('simentic')" class="btn_icon_download_white float_r mr_25" title="개체명 설정 다운로드"></a>
						<a href="javascript:fn_upload('simentic');" class="btn_icon_upload_wihte float_r mr_10" title="개체명 설정 다운로드"></a>
						</p>
						<div class="cont_gray clear2" style="height:507px;">
							<div id="simentic_tree_list">
								${simenticJstreeHtml}
							</div>
						</div>
					</li>
					<li id="simentic_analysis">
						<p class="cont_tit3 clear2">의미분석
							<a href="#" class="btn_label_onoff" title="펼치기"></a>
							<a href="javascript:fn_excelDown('simentic_analysis')" class="btn_icon_download_white float_r mr_25" title="개체명 설정 다운로드"></a>
							<a href="javascript:fn_upload('simentic_analysis');" class="btn_icon_upload_wihte float_r mr_10"  title="개체명 설정 다운로드"></a>
						</p>
						<div class="cont_gray clear2" style="height:507px;">
							<div id="simentic_analysis_tree_list">
								${simenticAanlysisJstreeHtml}
							</div>
						</div>
					</li>
					<li id="hate">
						<p class="cont_tit3 clear2">혐오발언
						<a href="#" class="btn_label_onoff" title="펼치기"></a>
						<a href="javascript:fn_excelDown('hate')" class="btn_icon_download_white float_r mr_25" title="개체명 설정 다운로드"></a>
						<a href="javascript:fn_upload('hate');" class="btn_icon_upload_wihte float_r mr_10"  title="개체명 설정 다운로드"></a>
						
						</p>
						<div class="cont_gray clear2" style="height:507px;">
							<div id="hate_tree_list">
								${hateJstreeHtml}
							</div>
						</div>
					</li>
				</ul>
			</div>
			<!--// 아코디언 end -->
	
			<!-- 우측 영역 start -->
			<div class="label_02">
				<!--// 폼 end -->
				<form id="searchForm">
					<input type="hidden" name="groupName" id="groupName" value="${common.groupName}"/>
					<input type="hidden" name="pageNo" id="pageNo" value="${common.pageNo}"/>
					<input type="hidden" name="selIds" id="selIds" value="${selIds[0]}"/>
					<input type="hidden" name="name" id="name" value="${selIds[0]}"/>
					<input type="hidden" name="count" id="count" value="${count}"/>
				</form>
				<!-- 문서목록 start -->
				<div>
					<form id="delete_form" action="/data/document/delete.do?_format=json">
						<table class="tbl_type02">
							<colgroup>
								<col>
								<col style="width:150px">
								<col style="width:100px">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">내용</th>
									<th scope="col">레이블 유형</th>
									<th scope="col">레이블링</th>
								</tr>
							</thead>
							<tbody id="docList">
								<c:if test="${not empty docList}">
									<c:forEach var="doc" items="${docList}">		
					                	<tr>
											<td class="left">
												<div style="font-size:12px;">
				                					<img src="${pageContext.request.contextPath}/resources/images/common/blank-file.png"> <span  style="font-weight:bold;">${doc.subject}</span> By <span style="color:#7FB1DE;">${doc.regId}</span> @ <span style="color:#7FB1DE;">${doc.domain}</span> <span style="color:#7FB1DE;"><fmt:formatDate value="${doc.regDate}" pattern="yyyy-MM-dd"/></span>
				                				</div>
				                				<div class="mt_15">
				                					${fn:substring(doc.content,0,195)}
				                				</div>
											</td>
											<td>
												<c:if test="${doc.groupName == 'namedentity'}">
													개체명
												</c:if>
												<c:if test="${doc.groupName == 'simentic'}">
													의미역
												</c:if>
												<c:if test="${doc.groupName == 'simentic_analysis'}">
													의미분석
												</c:if>
												<c:if test="${doc.groupName == 'hate'}">
													혐오발언
												</c:if>
											 </td>
											<td>${doc.rabelStat}</td>
										</tr>
									</c:forEach>
								</c:if>
								<c:if test="${empty docList}">
									<tr>
										<td colspan="3">결과가 없습니다.</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</form>
					<t:pagination ref="${pagination}" />
				</div>
			</div>
			<!--// 문서목록 end -->
		</div>
		<!--// 우측 영역 end -->
	</div>
	<!--// full area end -->
</div>
<!--// content end -->
<script id="tmpl_selRel" type="text/x-jsrender">
{{if #data}}
	{{for relation ~len=relation.length}}
	<div id="ent_{{:#index}}">
		<select class="select2" style="width: 200px;" id="startEnt" name="startEnt">
			<option value="">소스 선택</option>
				{{for entlist}}
					<option value="">{{>name}}</option>
				{{/for}}
		</select>
		->
		<select class="select2" style="width: 200px;" id="endEnt" name="endEnt">
			<option value="">타겟 선택</option>
				
		</select>
 		{{if #index == ~len-1}}
			<a name="btnArgAdd" href="javascript:fn_argAdd();" class="btn b_gray ssmall_pm valign_m" title="추가">+</a>
		{{/if}}
			<a name="btnArgDelete" href="javascript:fn_argDelete('ent_{{:#index}}');" class="btn b_gray ssmall_pm valign_m" title="삭제">X</a>
		</div>
	{{/for}}
{{/if}}
</script>

<script id="tmpl_doc" type="text/x-jsrender">
{{if #data}}
	{{for list}}
		<tr>
			<td><input type="checkbox" name="recordIds" value="{{>recordId}}"/></td>
			<td>{{>rabelStat}}</td>
			<td>{{>domain}}</td>
			<td><div class="of_hidden">{{>subject}}</div></td>
			<td class="left"><div class="of_hidden">{{>content}}</div></td>
			<td>{{>regId}}</td>
			<td>{{>confId}}</td>
			<td>{{date:regDate}}</td>
			<td><a href="javascript:fn_recordEntDelete('{{>recordId}}');" class="btn_td btn_tbl_del">
			{{if groupName == 'namedentity'}}
				객체명
			{{/if}}
			{{if groupName == 'syntactic'}}
				구문분석
			{{/if}}
			{{if groupName == 'causation'}}
				인과관계
			{{/if}}
			 삭제</a></td>
		</tr>
	{{/for}}
{{/if}}
</script>
