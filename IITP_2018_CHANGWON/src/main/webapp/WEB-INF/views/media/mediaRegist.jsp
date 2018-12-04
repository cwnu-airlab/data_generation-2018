<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- page title start -->
<div class="tit_page clear2">
	<h2>동영상 데이터 등록</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 데이터 등록</li>
		</ul>
	</div>
</div>
<!--// page title end -->
<div class="cont">
	<!-- full area start -->
	<div class="full_area">
		<!-- 개체명 레이블드 데이터 start -->
		<div>
			<div class="cont_tit2">Meida Upload
			</div>
			<div id="fileUploadInfo" class="cont_white clear2" style="height:395px;">
				<div style="display:inline-block">
					<div class="media_upload_icon">
					</div>
					<div class="media_upload_text">
						Media 파일을 등록(업로드)하는 페이지입니다.<br/>
						드래그 앤 드랍을 지원합니다.
					</div>
				</div>
				<div class="mb_15" style="/* position: absolute; *//* top: 86%; *//* left: 78%; *//* margin-left: 78%; *//* display: inline-block; */">
					<input type="file" style="display:none" id="localFile" />
					<a id="startUpload" class="large btn b_balck float_r" href="#">Start Upload</a>
					<a id="addFile" class="large btn b_gray float_r" href="#">Add File</a>
				</div>
			</div>
		</div>
		<!--// 개체명 레이블드 데이터 end -->
		<!-- 개체명 레이블드 데이터 start -->
		<div class="mt_30">
			<div class="cont_tit2">Media Upload List
			</div>
			<div class="cont_white clear2" style="min-height:395px;">	
				<table class="media_type02" id="uploadFileData">
					<colgroup>
						<col width="320px">
						<col>
						<col width="150px">
					</colgroup>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!--// 개체명 레이블드 데이터 end -->
	</div>
	<!--// full area end -->
	
	<!-- 모달 : Progress -->
	<div class="modal" id="modal_progress">
		<div class="modal_in" style="width:400px;">
			<div class="modal_cont">
				<img src="${pageContext.request.contextPath}/resources/images/common/icon_upload_loading.gif" class="float_l" style="width:25px;" alt="업로드 로딩 이미지"/>
				<div id="uploadMessage" class="ml_10 float_l" style="font-size:13px;font-weight:bold;"></div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/media/media.regist.js"></script>
<style>
	.media_type02 {
		border-bottom: 1px solid #ddd;
		width: 100%;
		table-layout: fixed;
	}
	.media_type02 td {
		border-bottom: 1px solid #ddd;
		padding: 5px 10px;
		text-align: center;
		font-size: 25px;
		line-height: 1.5em;
		word-break: break-all;
	}
	.cont_white {
		position: relative;
		clear: both;
		background: #ffffff;
		border: 1px solid #ddd;
		border-radius: 6px;
	}
</style>