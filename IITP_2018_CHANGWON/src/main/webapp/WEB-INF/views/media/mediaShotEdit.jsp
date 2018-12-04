<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div id="shotEditDiv_${shotInfo.shotId}" style="height: 475px;border-bottom: 1px solid #afafaf;">
	<script>
			$(document).ready(function (){
				var videoPlayer1 = document.getElementById('sampleShot_${shotInfo.shotId}');
				
				
				$( "#slider-range_${shotInfo.shotId}" ).slider({
					range: true,
					min: 0,
					max: ${mediaInfo.duration},
					values: [${shotInfo.startTime}, ${shotInfo.endTime}],
					start : function(evt, ui){
						videoPlayer1.currentTime = ui.values[0]
					}
				});
				
				
				videoPlayer1.ontimeupdate = function(){
					var values =  $( "#slider-range_${shotInfo.shotId}" ).slider('values');
					if(videoPlayer1.currentTime >= values[1]){
						videoPlayer1.pause();
						videoPlayer1.currentTime = values[1];
						//
					} else {	
						$( "#slider-range_${shotInfo.shotId}" ).slider('values', 0,videoPlayer1.currentTime)
					}
				}
				$("#sampleShot_${shotInfo.shotId}Btn").click(function(){
					if($(this).html() == 'Pause'){
						$(this).html('Play');
						videoPlayer1.pause();
					} else {
						var values =  $( "#slider-range_${shotInfo.shotId}" ).slider('values');
						if(videoPlayer1.currentTime == values[1] || videoPlayer1.currentTime == 0){
							videoPlayer1.currentTime = ${shotInfo.startTime};
							$( "#slider-range_${shotInfo.shotId}" ).slider('values', [${shotInfo.startTime}, ${shotInfo.endTime}])
						}
						videoPlayer1.play();
						$(this).html('Pause');
					}
					
				});
				
				
				$('input[type=text][id$=_${shotInfo.shotId}]').focusout(function(){
					var id = $(this).attr('id');
					var mediaId =  $('#mediaId_${shotInfo.shotId}').val();
					var shotId = $('#shotId_${shotInfo.shotId}').val()
					if(id.indexOf('evt') != -1) {
						var editField = '';
						var value= "";
						var tagId = 0;
						var tagName = '' 
						if(id.indexOf('evt_title') == 0){
							editField = 'TITLE';
							value = $(this).val();
						} else if(id.indexOf('evt_who') == 0){
							editField = 'WHO';
							tagId = $('#evt_who_tagId_'+ shotId).val();
							tagName = $('#evt_who_tag_'+ shotId).val();
							value = $('#evt_who_'+ shotId).val();
						} else if(id.indexOf('evt_whatBehavior') == 0){
							editField = 'WHAT_BEHAVIOR';
							tagId = $('#evt_whatBehavior_tagId_'+ shotId).val();
							tagName = $('#evt_whatBehavior_tag_'+ shotId).val();
							value = $('#evt_whatBehavior_'+ shotId).val();
						} else if(id.indexOf('evt_whatObject') == 0){
							editField = 'WHAT_OBJECT';
							tagId = $('#evt_whatObject_tagId_'+ shotId).val();
							tagName = $('#evt_whatObject_tag_'+ shotId).val();
							value = $('#evt_whatObject_'+ shotId).val();
						} else if(id.indexOf('evt_where') == 0){
							editField = 'WHERE';
							tagId = $('#evt_where_tagId_'+ shotId).val();
							tagName = $('#evt_where_tag_'+ shotId).val();
							value = $('#evt_where_'+ shotId).val();
						} else if(id.indexOf('evt_when') == 0){
							editField = 'WHEN';
							tagId = $('#evt_when_tagId_'+ shotId).val();
							tagName = $('#evt_when_tag_'+ shotId).val();
							value = $('#evt_when_'+ shotId).val();
						} else if(id.indexOf('evt_why') == 0){
							editField = 'WHY';
							tagId  = $('#evt_why_tagId_'+ shotId).val();
							tagName = $('#evt_why_tag_'+ shotId).val();
							value = $('#evt_why_'+ shotId).val();
						} else if(id.indexOf('evt_how') == 0){
							editField = 'HOW';
							tagId = $('#evt_how_tagId_'+ shotId).val();
							tagName = $('#evt_how_tag_'+ shotId).val();
							value = $('#evt_how_'+ shotId).val();
						}
						
						$.ajax({
							url : contextPath + '/media/editActivity.do',
							type : 'post',
							data : {"editField" : editField, "tagId" : tagId, "tagName" : tagName, "tagValue" : value},
							success : function(data) {
								console.log(data);
							}
						})
					}
				});
				
				$('#deleteShot_${shotInfo.shotId}').click(function(){
					$.ajax({
						url : contextPath + "/media/deleteShot.do",
						data : {mediaId : $('#mediaId_${shotInfo.shotId}').val(), shotId : $('#shotId_${shotInfo.shotId}').val()},
						type : 'post',
						success : function(data){
							$('#shotEditDiv_${shotInfo.shotId}').remove();
						}
					})
				})
			});
	</script>
	<div class="cont_tit2 ml_10 mt_10">Shot1 (${shotInfo.startTimeCode} ~ ${shotInfo.endTimeCode})</div>
	<div class="mt_10">
		<input type="hidden" id="mediaId_${shotInfo.shotId}" value="${shotInfo.mediaId}" />
		<input type="hidden" id="shotId_${shotInfo.shotId}" value="${shotInfo.shotId}" />
		<div class="float_l" style="width:30%">
			<video src="${pageContext.request.contextPath}${mediaInfo.localFile}" id="sampleShot_${shotInfo.shotId}" width="90%" height="250px" class="float_l ml_10 mr_10"></video>
			<div>
				<button id="sampleShot_${shotInfo.shotId}Btn" class="float_l mt_10 ml_10 btn_tit_box">Play</button>
				<div id="slider-range_${shotInfo.shotId}" class="float_l mt_10 ml_10" style="width:80%;"></div>
			</div>
		</div>
		<div class="float_l margin" style="width:69%">
			<div class="cont_tit2">샷 추출 정보 <button id="deleteShot_${shotInfo.shotId }" style="font-size:15px;" class="btn_tit_box float_r">삭제</button></div>
			<table class="tbl_type02">
				<colgroup>
					<col style="width:20%">
					<col>
					<col style="width:20%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>샷 시작시간</th>
						<td>${shotInfo.startTimeInfo}</td>
						<th>샷 종료시간</th>
						<td>${shotInfo.endTimeInfo}</td>
					</tr>
					<tr>
						<th>샷 시작프레임</th>
						<td>${shotInfo.startFrame}</td>
						<th>샷 종료프레임</th>
						<td>${shotInfo.endFrame}</td>
					</tr>
					<tr>
						<th>샷 시작섬네일</th>
						<td>/uploads${shotInfo.startThumb}</td>
						<th>샷 종료섬네일</th>
						<td>/uploads${shotInfo.endThumb}</td>
					</tr>
				</tbody>
			</table>
			<div class="cont_tit2 mt_10">동영상 샷 이벤트 정보</div>
			<table class="tbl_type02" style="font-size:12px;">
				<colgroup>
					<col style="width:15%">
					<col>
				</colgroup>
				<tbody>
					<tr>
						<th>제목</th>
						<td class="left" style="font-size:12px;"><input type="text" id="evt_title_${shotInfo.shotId}" style="width:100%" value="${shotInfo.title}" /></td>
					</tr>
					<tr>
						<th>Who</th>
						<td class="left" style="font-size:12px;">
							 <input type="hidden" id="evt_who_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.who}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_who_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whoTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_who_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whoDesc}" />
						</td>
					</tr>
					<tr>
						<th>What Behavior</th>
						<td class="left" style="font-size:12px;">
							  <input type="hidden" id="evt_whatBehavior_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.whatBehavior}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_whatBehavior_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whatBehaviorTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_whatBehavior_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whatBehaviorDesc}" />
						</td>
					</tr>
					<tr>
						<th>What Object</th>
						<td class="left" style="font-size:12px;">
							 <input type="hidden" id="evt_whatObject_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.whatObject}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_whatObject_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whatObjectTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_whatObject_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whatObjectDesc}" />
						</td>
					</tr>
					<tr>
						<th>Where</th>
						<td class="left" style="font-size:12px;">
							  <input type="hidden" id="evt_where_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.where}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_where_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whereTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_where_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whereDesc}" />
						</td>
					</tr>
					<tr>
						<th>When</th>
						<td class="left" style="font-size:12px;">
							  <input type="hidden" id="evt_when_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.when}" default="0" />" />
							 Media Tag :  <input type="text" id="evt_when_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whenTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_when_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whenDesc}" />
						</td>
					</tr>
					<tr>
						<th>Why</th>
						<td class="left" style="font-size:12px;">
							  <input type="hidden" id="evt_why_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.why}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_why_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.whyTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_why_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.whyDesc}" />
						</td>
					</tr>
					<tr>
						<th>How</th>
						<td class="left" style="font-size:12px;">
							 <input type="hidden" id="evt_how_tagId_${shotInfo.shotId}" style="width:25%" value="<c:out value="${shotInfo.how}" default="0" />" /> 
							 Media Tag :  <input type="text" id="evt_how_tag_${shotInfo.shotId}" style="width:25%" value="${shotInfo.howTagName}" />
							 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_how_${shotInfo.shotId}" style="width:30%"  value="${shotInfo.howDesc}" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
