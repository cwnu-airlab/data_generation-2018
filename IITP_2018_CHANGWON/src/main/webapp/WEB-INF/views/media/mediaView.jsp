<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.cont_white {
		position: relative;
		clear: both;
		background: #ffffff;
		border: 1px solid #ddd;
		border-radius: 6px;
	}
</style>
	<!-- page title start -->
<div class="tit_page clear2">
	<h2>동영상 레이블링 상세보기</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 레이블링 상세보기</li>
		</ul>
	</div>
</div>
<!--// page title end -->

<div class="cont">

	<!-- full area start -->
	<div class="full_area">
		<!-- 개체명 레이블드 데이터 start -->
		<div>
			<div class="float_l mb_20">
				<div class="cont_tit2">동영상 정보
					<div class="tit_opt float_3">
						<a href="${pageContext.request.contextPath}/media/mediaEdit.do" class="btn_tit_box">편집</a>
					</div>	
				</div>
				<div class="cont_white clear2" style="height:360px;overflow-y: auto;">
					<div class="cont_tit2 ml_10 mt_10">Sample Info</div>
					<video src="${pageContext.request.contextPath}/resources/sample/sample1.mp4" width="30%" controls="controls" class="float_l ml_10 mr_10"></video>
					<div class="float_l" style="width:65%">
						<table class="tbl_type02" style="font-size:13px;">
							<colgroup>
								<col style="width:20%">
								<col >
							</colgroup>
							<tbody>
								<tr>
									<th scope="col">동영상 명</th>
									<td scope="col" class="left" style="font-size:13px;">쌈바홍의 Q&A 라디오! 근데 항아리게임을 왜 받았냐구요? [쌈바홍ssambahong 트위치] Hong jin young</td>
								</tr>
								<tr>
									<th scope="col">카테고리</th>
									<td scope="col" class="left" style="font-size:13px;">놀이공원</td>
								</tr>
								<tr>
									<th scope="col">동영상 경로</th>
									<td scope="col" class="left" style="font-size:13px;">/uploads/amusement_park/1/1.mp4</td>
								</tr>
								<tr>
									<th scope="col">섬네일 경로</th>
									<td scope="col" class="left" style="font-size:13px;">/uploads/amusement_park/1/SAMPLE1.png</td>
								</tr>
								<tr>
									<th scope="col">재생시간</th>
									<td scope="col" class="left" style="font-size:13px;">4분 58초</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<!--// 개체명 레이블드 데이터 end -->
		<!-- 개체명 레이블드 데이터 start -->
		<div class="mt_30">
			<div>
				<div class="cont_tit2">동영상 샷 리스트</div>
				<div class="cont_white clear2" style="height:420px;overflow-y: auto;">
					<div style="height: 390px;border-bottom: 1px solid #afafaf;">
						<div class="cont_tit2 ml_10 mt_10" style="font-size:20px;">Shot1 (XX:XX:XX ~ XX:XX:XX)</div>
						<div style="width:30%; text-align:center;" class="float_l ml_10 mt_10 mr_10">
							<span style="font-size:15px;">Start Frame :</span> <img src="${pageContext.request.contextPath}/resources/sample/1740.png" width="55%"><br><br>
							<span style="margin-top : 25px;font-size:15px;">&nbsp;End Frame :</span> <img src="${pageContext.request.contextPath}/resources/sample/2320.png" width="55%">
						</div>
						<div class="float_l mr_10" style="width:67%;">
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
							<table class="tbl_type02">
								<colgroup>
									<col style="width:15%">
									<col>
									<col style="width:15%">
									<col>
									<col style="width:15%">
									<col>
								</colgroup>
								<tbody>
									<tr>
										<th>제목</th>
										<td colspan="5" class="left">쌈바홍과 시청자들의 질의 응답</td>
									</tr>
									<tr>
										<th>Who</th>
										<td class="left">여성</td>
										<th>What Behavior</th>
										<td class="left">응답</td>
										<th>What Object</th>
										<td class="left">시청자 질문</td>
									</tr>
									<tr>
										<th>Where</th>
										<td class="left">자택</td>
										<th>When</th>
										<td class="left">밤</td>
										<th>why</th>
										<td class="left">시청자들 질의</td>
									</tr>
									<tr>
										<th>How</th>
										<td class="left">채팅과 음성</td>
										<td colspan="4"></th>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--// 개체명 레이블드 데이터 end -->
	</div>
	<!--// full area end -->

</div>

