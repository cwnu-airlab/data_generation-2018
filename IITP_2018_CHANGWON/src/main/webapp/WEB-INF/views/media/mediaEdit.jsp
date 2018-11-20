<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	
		$( "#slider-range" ).slider({
			range: true,
			min: 0,
			max: 377.951200,
			values: [ 0, 377.951200 ],
			slide : function (event ,ui ){
				var values =  ui.values;
				var d = new Date(null)
				d.setSeconds(values[0]);
				var timeString = d.toISOString().substr(11, 8);
				console.log("START TIME : " + timeString)
				videoPlayer.currentTime = values[0]
				$('#startTime').val(timeString);
				
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				console.log("END TIME : " + timeString)
				$('#endTime').val(timeString);
			}, 
			start : function (event, ui) {
				var values =  ui.values;
				var d = new Date(null)
				d.setSeconds(values[0]);
				var timeString = d.toISOString().substr(11, 8);
				$('#startTime').val(timeString);
				
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				$('#endTime').val(timeString);
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
			} else {	
				var d = new Date(null)
				d.setSeconds(videoPlayer.currentTime);
				var timeString = d.toISOString().substr(11, 8);
				$('#startTime').val(timeString);
				
				d = new Date(null)
				d.setSeconds(values[1]);
				timeString = d.toISOString().substr(11, 8);
				$('#endTime').val(timeString);
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
	<div class="full_area">
		<div>
			<div class="float_l mb_20">
				<div class="cont_tit2">동영상 정보
				</div>
				<div class="cont_white clear2" style="height:300px;">
					<div class="cont_tit2 ml_10 mt_10">Sample Info</div>
					<video src="${pageContext.request.contextPath}/resources/sample/sample1.mp4" id="samplePlayer" width="30%" height="250px" controls="controls" class="float_l ml_10 mr_10"></video>
					<div class="float_l ml_10" style="width:65%">
						<div id="slider-range"></div>
						<div class="mt_20">
							<div class="float_l">
								<input type="text" id="startTime" style="font-size:15px;padding:3px;" value=""/>
								<button id="startTimeBtn" style="font-size:15px;" class="btn_tit_box">구간 시작 설정</button>
							</div>
							<div class="float_r">
								<input type="text" id="endTime" style="font-size:15px;padding:3px;" value=""/>
								<button id="endTimeBtn" style="font-size:15px;" class="btn_tit_box">구간 시작 종료</button>
							</div>
						</div>
						<div style="margin-top:150px;">
							<button id="endTimeBtn" style="font-size:30px;" class="btn_tit_box float_r">MAKE SHOT</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div>
			<div class="cont_tit2">샷 편집 정보</div>
			<div class="cont_white clear2" style="height:465px;overflow-y:auto;">
				<div style="height: 475px;border-bottom: 1px solid #afafaf;">
					<script>
						$(document).ready(function (){
							var videoPlayer1 = document.getElementById('sampleShot1');
							$( "#slider-range1" ).slider({
								range: true,
								min: 0,
								max: 377.951200,
								values: [ 10, 150],
								start : function(evt, ui){
									videoPlayer1.currentTime = ui.values[0]
								}
							});
							
							
							videoPlayer1.ontimeupdate = function(){
								var values =  $( "#slider-range1" ).slider('values');
								if(videoPlayer1.currentTime >= values[1]){
									videoPlayer1.pause();
									videoPlayer1.currentTime = values[1];
									//
								} else {	
									$( "#slider-range1" ).slider('values', 0,videoPlayer1.currentTime)
								}
							}
							$("#sampleShot1Btn").click(function(){
								if($(this).html() == 'Pause'){
									$(this).html('Play');
									videoPlayer1.pause();
								} else {
									var values =  $( "#slider-range1" ).slider('values');
									if(videoPlayer1.currentTime == values[1] || videoPlayer1.currentTime == 0){
										videoPlayer1.currentTime = 10;
										$( "#slider-range1" ).slider('values', [10, 150])
									}
									videoPlayer1.play();
									$(this).html('Pause');
								}
								
							});
						});
					</script>
					<div class="cont_tit2 ml_10 mt_10">Shot1 (XX:XX:XX ~ XX:XX:XX)</div>
					<div class="mt_10">
						<div class="float_l" style="width:30%">
							<video src="${pageContext.request.contextPath}/resources/sample/sample1.mp4" id="sampleShot1" width="90%" height="250px" class="float_l ml_10 mr_10"></video>
							<div>
								<button id="sampleShot1Btn" class="float_l mt_10 ml_10 btn_tit_box">Play</button>
								<div id="slider-range1" class="float_l mt_10 ml_10" style="width:80%;"></div>
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
										<td>1분 00초</td>
										<th>샷 종료시간</th>
										<td>1분 20초</td>
									</tr>
									<tr>
										<th>샷 시작프레임</th>
										<td>1740</td>
										<th>샷 종료프레임</th>
										<td>2320</td>
									</tr>
									<tr>
										<th>샷 시작섬네일</th>
										<td>/uploads/amusement_park/1/shot1740.png</td>
										<th>샷 종료섬네일</th>
										<td>/uploads/amusement_park/1/shot2320.png</td>
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
										<td class="left" style="font-size:12px;"><input type="text" style="width:100%" value="쌈바홍과 시청자들의 질의 응답" /></td>
									</tr>
									<tr>
										<th>Who</th>
										<td class="left" style="font-size:12px;"> Media Tag : <input type="text" style="width:25%" value="female" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%"  value="쌈바홍" /></td>
									</tr>
									<tr>
										<th>What Behavior</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="answer" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="응답" /></td>
									</tr>
									<tr>
										<th>What Object</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%"value="view_question" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="시청자 질문" /></td>
									</tr>
									<tr>
										<th>Where</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="home" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="자택" /></td>
									</tr>
									<tr>
										<th>When</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="night" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="밤" /></td>
									</tr>
									<tr>
										<th>why</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="question" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="시청자들 질의" /></td>
									</tr>
									<tr>
										<th>How</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="chatting_voice" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="채팅과 음성" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
				</div>
				<div style="height: 465px;border-bottom: 1px solid #afafaf;">
					<script>
						$(document).ready(function (){
							var videoPlayer2 = document.getElementById('sampleShot2');
							$( "#slider-range2" ).slider({
								range: true,
								min: 0,
								max: 377.951200,
								values: [ 10, 150],
								start : function(evt, ui){
									videoPlayer2.currentTime = ui.values[0]
								}
							});
							
							
							videoPlayer2.ontimeupdate = function(){
								var values =  $( "#slider-range2" ).slider('values');
								if(videoPlayer2.currentTime >= values[1]){
									videoPlayer2.pause();
									videoPlayer2.currentTime = values[1];
									//
								} else {	
									$( "#slider-range2" ).slider('values', 0,videoPlayer2.currentTime)
								}
							}
							$("#sampleShot2Btn").click(function(){
								if($(this).html() == 'Pause'){
									$(this).html('Play');
									videoPlayer2.pause();
								} else {
									var values =  $( "#slider-range2" ).slider('values');
									if(videoPlayer2.currentTime == values[1] || videoPlayer2.currentTime == 0){
										videoPlayer2.currentTime = 10;
										$( "#slider-range2" ).slider('values', [10, 150])
									}
									videoPlayer2.play();
									$(this).html('Pause');
								}
								
							});
						});
					</script>
					<div class="cont_tit2 ml_10 mt_10">Shot2 (XX:XX:XX ~ XX:XX:XX)</div>
					<div class="mt_10">
						<div class="float_l" style="width:30%">
							<video src="${pageContext.request.contextPath}/resources/sample/sample1.mp4" id="sampleShot2" width="90%" height="250px" class="float_l ml_10 mr_10"></video>
							<div>
								<button id="sampleShot2Btn" class="float_l mt_10 ml_10 btn_tit_box">Play</button>
								<div id="slider-range2" class="float_l mt_10 ml_10" style="width:80%;"></div>
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
										<td>1분 00초</td>
										<th>샷 종료시간</th>
										<td>1분 20초</td>
									</tr>
									<tr>
										<th>샷 시작프레임</th>
										<td>1740</td>
										<th>샷 종료프레임</th>
										<td>2320</td>
									</tr>
									<tr>
										<th>샷 시작섬네일</th>
										<td>/uploads/amusement_park/1/shot1740.png</td>
										<th>샷 종료섬네일</th>
										<td>/uploads/amusement_park/1/shot2320.png</td>
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
										<td class="left" style="font-size:12px;"><input type="text" style="width:100%" value="쌈바홍과 시청자들의 질의 응답" /></td>
									</tr>
									<tr>
										<th>Who</th>
										<td class="left" style="font-size:12px;"> Media Tag : <input type="text" style="width:25%" value="female" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%"  value="쌈바홍" /></td>
									</tr>
									<tr>
										<th>What Behavior</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="answer" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="응답" /></td>
									</tr>
									<tr>
										<th>What Object</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%"value="view_question" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="시청자 질문" /></td>
									</tr>
									<tr>
										<th>Where</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="home" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="자택" /></td>
									</tr>
									<tr>
										<th>When</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="night" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="밤" /></td>
									</tr>
									<tr>
										<th>why</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="question" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="시청자들 질의" /></td>
									</tr>
									<tr>
										<th>How</th>
										<td class="left" style="font-size:12px;">Media Tag : <input type="text" style="width:25%" value="chatting_voice" /><span class="ml_25">Media Tag Description </span> : <input type="text" style="width:30%" value="채팅과 음성" /></td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					
				</div>
			</div>
		</div>
		<div class="align_r mt_10">
			<a href="#" class="btn b_gray medium">저장</a>
		</div>
	</div>
	<!--// full area end -->
</div>