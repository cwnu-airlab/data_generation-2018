<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<style>
	.cont_white {
			position: relative;
			clear: both;
			background: #ffffff;
			border: 1px solid #ddd;
			border-radius: 6px;
	}

	.slidecontainer {
		width: 100%;
	}

	.slider {
		-webkit-appearance: none;
		width: 100%;
		height: 25px;
		background: #d3d3d3;
		outline: none;
		opacity: 0.7;
		-webkit-transition: .2s;
		transition: opacity .2s;
	}

	.slider:hover {
		opacity: 1;
	}

	.slider::-webkit-slider-thumb {
		-webkit-appearance: none;
		appearance: none;
		width: 25px;
		height: 25px;
		background: #4CAF50;
		cursor: pointer;
	}

	.slider::-moz-range-thumb {
		width: 25px;
		height: 25px;
		background: #4CAF50;
		cursor: pointer;
	}
</style>

<script>
	$(document).ready(function () {
		var videoPlayer = document.getElementById('samplePlayer');
	
		var d = new Date(null)
		d.setSeconds(0);
		var timeString = d.toISOString().substr(11, 8);
		videoPlayer.currentTime = 0
		$('#startTime').val(timeString);
		$('#startTimeHid').val(0);
		
		d = new Date(null)
		d.setSeconds(${mediaInfo.duration});
		timeString = d.toISOString().substr(11, 8);
		$('#endTime').val(timeString);
		$('#endTimeHid').val(${mediaInfo.duration});
		
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: ${mediaInfo.duration},
			values: [ 0, ${mediaInfo.duration}],
			slide : function (event ,ui ){
				var values =  ui.values;
				var d = new Date(null)
				d.setSeconds(values[0]);
				var timeString = d.toISOString().substr(11, 8);
				videoPlayer.currentTime = values[0]
				$('#startTime').val(timeString);
				$('#startTimeHid').val(values[0]);
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				$('#endTime').val(timeString);
				$('#endTimeHid').val(values[1]);
			}, 
			start : function (event, ui) {
				var values =  ui.values;
				var d = new Date(null)
				d.setSeconds(values[0]);
				var timeString = d.toISOString().substr(11, 8);
				$('#startTime').val(timeString);
				$('#startTimeHid').val(values[0]);
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				$('#endTime').val(timeString);
				$('#endTimeHid').val(values[1]);
			}
		});
		
		videoPlayer.ontimeupdate = function(){
			var values =  $( "#slider-range" ).slider('values');
			
			if(videoPlayer.currentTime >= values[1]){
				videoPlayer.pause();
				videoPlayer.currentTime = values[1];
				
				var d = new Date(null)
				d.setSeconds(values[1]);
				var timeString = d.toISOString().substr(11, 8);
				
				$('#startTime').val(timeString);
				$('#startTimeHid').val(values[1]);
			} else {	
				var d = new Date(null)
				d.setSeconds(videoPlayer.currentTime);
				var timeString = d.toISOString().substr(11, 8);
				$('#startTime').val(timeString);
				$('#startTimeHid').val(videoPlayer.currentTime);
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				$('#endTime').val(timeString);
				$('#endTimeHid').val(values[1]);
				$( "#slider-range" ).slider('values', 0,videoPlayer.currentTime)
			}
			
		}
		// Play / pause.
		videoPlayer.addEventListener('click', function () {
			if (videoPlayer.paused == false) {
				videoPlayer.pause();
				videoPlayer.firstChild.nodeValue = 'Play';
			} else {
				videoPlayer.play();
				videoPlayer.firstChild.nodeValue = 'Pause';
			}
		});
		
		$('#makeShotBtn').click(function (){
			$('#startTimeCode').val($("#startTime").val());
			$('#endTimeCode').val($("#endTime").val());
			
			$.ajax({
				url : contextPath + "/media/makeShot.do",
				type : 'post',
				data : $(document.makeShotFrom).serialize(),
				success : function (data){
					$('#shotEditForm').html(data);
				}
			});
		});
	});
</script>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>동영상 편집</h2>
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 편집</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<div class="cont">
	<!-- full area start -->
	<form name="makeShotFrom">
		<input type="hidden" name="mediaId" id="mediaId" value="${mediaInfo.mediaId}" />
		<input type="hidden" name="localFile" id="localFile" value="${mediaInfo.localFile}" />
<%-- 		<input type="hidden" name="localFile" id="" value="${mediaInfo.localFile}" /> --%>
		<input type="hidden" name="startTime" id="startTimeHid" value="" />
		<input type="hidden" name="endTime" id="endTimeHid" value="" />
		<input type="hidden" name="startTimeCode" id="startTimeCode" value="" />
		<input type="hidden" name="endTimeCode" id="endTimeCode" value="" />
	</form>
	<div class="full_area">
		<div>
			<div class="mb_20">
				<div class="cont_tit2">동영상 정보
				</div>
				<div class="cont_white clear2" style="height:300px;">
					<div class="cont_tit2 ml_10 mt_10">Sample Info</div>
					<video src="${pageContext.request.contextPath}${mediaInfo.localFile}" poster="${pageContext.request.contextPath}${mediaInfo.thumbNail}" id="samplePlayer" width="30%" height="250px" controls="controls" class="float_l ml_10 mr_10"></video>
					<div class="float_l ml_10" style="width:65%">
						<div id="slider-range"></div>
						<div class="mt_20">
							<div class="float_l">
								구간 시작 시간 : <input type="text" id="startTime" readonly="readonly" style="font-size:15px;padding:3px;" value=""/>
							</div>
							<div class="float_r">
								구간 종료 시간 : <input type="text" id="endTime" readonly="readonly" style="font-size:15px;padding:3px;" value=""/>
							</div>
						</div>
						<div style="margin-top:150px;">
							<button id="makeShotBtn" style="font-size:30px;" class="btn_tit_box float_r">MAKE SHOT</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div>
			<div class="cont_tit2">샷 편집 정보</div>
			<div id="shotEditForm" class="cont_white clear2" style="height:486px;overflow-y:auto;">
				<c:forEach items="${mediaInfo.shotInfo}" var="item" varStatus="itemIndex">
					<div id="shotEditDiv_${item.shotId}" style="height: 475px;border-bottom: 1px solid #afafaf;">
						<script>
							$(document).ready(function (){
								var videoPlayer1 = document.getElementById('sampleShot_${item.shotId}');
								
								
								$( "#slider-range_${item.shotId}" ).slider({
									range: true,
									min: 0,
									max: ${mediaInfo.duration},
									values: [${item.startTime}, ${item.endTime}],
									start : function(evt, ui){
										videoPlayer1.currentTime = ui.values[0]
									}
								});
								
								
								videoPlayer1.ontimeupdate = function(){
									var values =  $( "#slider-range_${item.shotId}" ).slider('values');
									if(videoPlayer1.currentTime >= values[1]){
										videoPlayer1.pause();
										videoPlayer1.currentTime = values[1];
										//
									} else {	
										$( "#slider-range_${item.shotId}" ).slider('values', 0,videoPlayer1.currentTime)
									}
								}
								$("#sampleShot_${item.shotId}Btn").click(function(){
									if($(this).html() == 'Pause'){
										$(this).html('Play');
										videoPlayer1.pause();
									} else {
										var values =  $( "#slider-range_${item.shotId}" ).slider('values');
										if(videoPlayer1.currentTime == values[1] || videoPlayer1.currentTime == 0){
											videoPlayer1.currentTime = ${item.startTime};
											$( "#slider-range_${item.shotId}" ).slider('values', [${item.startTime}, ${item.endTime}])
										}
										videoPlayer1.play();
										$(this).html('Pause');
									}
									
								});
								
								$('input[type=text][id$=_${item.shotId}]').focusout(function(){
									var id = $(this).attr('id');
									var mediaId =  $('#mediaId_${item.shotId}').val();
									var shotId = $('#shotId_${item.shotId}').val()
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
										
										if(editField != 'TITLE'){
											message = '샷의 '+editField+" 항목에 "
											
											if($.trim(tagName) == ''){
												return;
											}
											
											if($.trim(value) == ''){
												return													
											}
											
										} else {
											if(value == ''){
												return;
											}
										}
										
										console.log(mediaId);
										console.log(shotId);
										$.ajax({
											url : contextPath + '/media/editActivity.do',
											type : 'post',
											data : {"mediaId" : mediaId, "shotId" : shotId, "editField" : editField, "tagId" : tagId, "tagName" : tagName, "tagValue" : value},
											success : function(data) {
												if(id.indexOf('evt_who') == 0){
													$('#evt_who_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_whatBehavior') == 0){
													$('#evt_whatBehavior_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_whatObject') == 0){
													$('#evt_whatObject_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_where') == 0){
													$('#evt_where_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_when') == 0){
													$('#evt_when_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_why') == 0){
													$('#evt_why_tagId_'+ shotId).val(data.tagInfo.tagId);
												} else if(id.indexOf('evt_how') == 0){
													$('#evt_how_tagId_'+ shotId).val(data.tagInfo.tagId);
												}
												console.log(data);
											}
										});
									}
								});
								
								$('#deleteShot_${item.shotId}').click(function(){
									$.ajax({
										url : contextPath + "/media/deleteShot.do",
										data : {mediaId : $('#mediaId_${item.shotId}').val(), shotId : $('#shotId_${item.shotId}').val()},
										type : 'post',
										success : function(data){
											if(data.deleteRes > 0){
												alert('선택한 샷 삭제를 완료하였습니다.');
												$('#shotEditDiv_${item.shotId}').remove();
											}
										}
									});
								});
							});
						</script>
						<div class="cont_tit2 ml_10 mt_10">Shot1 (${item.startTimeCode} ~ ${item.endTimeCode}) <a href="#" id="deleteShot_${item.shotId }" style="font-size:12px;" class="btn_tit_box float_r">삭제</a></div>
						<div class="mt_10">
							<input type="hidden" id="mediaId_${item.shotId}" value="${item.mediaId}" />
							<input type="hidden" id="shotId_${item.shotId}" value="${item.shotId}" />
							<div class="float_l" style="width:30%">
								<video src="${pageContext.request.contextPath}${mediaInfo.localFile}" id="sampleShot_${item.shotId}" width="90%" height="250px" class="float_l ml_10 mr_10"></video>
								<div>
									<button id="sampleShot_${item.shotId}Btn" class="float_l mt_10 ml_10 btn_tit_box">Play</button>
									<div id="slider-range_${item.shotId}" class="float_l mt_10 ml_10" style="width:80%;"></div>
								</div>
							</div>
							<div class="float_l margin" style="width:69%">
								<div class="cont_tit2">샷 추출 정보</div>
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
											<td>${item.startTimeInfo}</td>
											<th>샷 종료시간</th>
											<td>${item.endTimeInfo}</td>
										</tr>
										<tr>
											<th>샷 시작프레임</th>
											<td>${item.startFrame}</td>
											<th>샷 종료프레임</th>
											<td>${item.endFrame}</td>
										</tr>
										<tr>
											<th>샷 시작섬네일</th>
											<td>${item.startThumb}</td>
											<th>샷 종료섬네일</th>
											<td>${item.endThumb}</td>
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
											<td class="left" style="font-size:12px;"><input type="text" id="evt_title_${item.shotId}" style="width:100%" value="${item.title}" /></td>
										</tr>
										<tr>
											<th>Who</th>
											<td class="left" style="font-size:12px;">
												 <input type="hidden" id="evt_who_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.who}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_who_tag_${item.shotId}" style="width:25%" value="${item.whoTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_who_${item.shotId}" style="width:30%"  value="${item.whoDesc}" />
											</td>
										</tr>
										<tr>
											<th>What Behavior</th>
											<td class="left" style="font-size:12px;">
												  <input type="hidden" id="evt_whatBehavior_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.whatBehavior}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_whatBehavior_tag_${item.shotId}" style="width:25%" value="${item.whatBehaviorTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_whatBehavior_${item.shotId}" style="width:30%"  value="${item.whatBehaviorDesc}" />
											</td>
										</tr>
										<tr>
											<th>What Object</th>
											<td class="left" style="font-size:12px;">
												 <input type="hidden" id="evt_whatObject_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.whatObject}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_whatObject_tag_${item.shotId}" style="width:25%" value="${item.whatObjectTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_whatObject_${item.shotId}" style="width:30%"  value="${item.whatObjectDesc}" />
											</td>
										</tr>
										<tr>
											<th>Where</th>
											<td class="left" style="font-size:12px;">
												  <input type="hidden" id="evt_where_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.where}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_where_tag_${item.shotId}" style="width:25%" value="${item.whereTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_where_${item.shotId}" style="width:30%"  value="${item.whereDesc}" />
											</td>
										</tr>
										<tr>
											<th>When</th>
											<td class="left" style="font-size:12px;">
												  <input type="hidden" id="evt_when_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.when}" default="0" />" />
												 Media Tag :  <input type="text" id="evt_when_tag_${item.shotId}" style="width:25%" value="${item.whenTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_when_${item.shotId}" style="width:30%"  value="${item.whenDesc}" />
											</td>
										</tr>
										<tr>
											<th>Why</th>
											<td class="left" style="font-size:12px;">
												  <input type="hidden" id="evt_why_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.why}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_why_tag_${item.shotId}" style="width:25%" value="${item.whyTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_why_${item.shotId}" style="width:30%"  value="${item.whyDesc}" />
											</td>
										</tr>
										<tr>
											<th>How</th>
											<td class="left" style="font-size:12px;">
												 <input type="hidden" id="evt_how_tagId_${item.shotId}" style="width:25%" value="<c:out value="${item.how}" default="0" />" /> 
												 Media Tag :  <input type="text" id="evt_how_tag_${item.shotId}" style="width:25%" value="${item.howTagName}" />
												 <span class="ml_25">Media Tag Description </span> : <input type="text" id="evt_how_${item.shotId}" style="width:30%"  value="${item.howDesc}" />
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<!--// full area end -->
</div>