<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script>
	var fileList = [];
	$(document).ready(function(){
		$(document).on("dragenter", "#fileUploadInfo", function(e){
			e.stopPropagation();
			e.preventDefault();
		});
		$(document).on("dragover", "#fileUploadInfo", function(e){
			e.stopPropagation();
			e.preventDefault();
		});
		$(document).on("drop", "#fileUploadInfo", function(e){
			var files = e.originalEvent.dataTransfer.files;
			if ($('tr[id^=tr_]').length < 1) {
				for (var i = 0; i < files.length; i++) {
					if (i == 0) {
						if ((/png$|jpe?g$|gif$|mp4$|mp3$/i).test(files[i].name)) {
							if ((/mp4$/i).test(files[i].name)) {
								doVieoBlobUrl(files[i], 'VIDEO');
							} else if ((/mp3$/i).test(files[i].name)) {
								doVieoBlobUrl(files[i], 'AUDIO');
							} else {
								doVieoBlobUrl(files[i], 'IMAGE');
							}
						}
					}
				}
			} else {
				alert('동영상, 소리, 이미지는 최대 1개만 올릴 수 있습니다.');
			}
		});          
		$(document).on('dragenter', function(e){
			e.stopPropagation();
			e.preventDefault();
		});
		$(document).on('dragover', function(e){
			e.stopPropagation();
			e.preventDefault();
		});
		$(document).on('drop', function(e){
			e.stopPropagation();
			e.preventDefault();
		});
		
		$('#localFile').change(function(){
			var files = this.files;
			if ($('tr[id^=tr_]').length < 3) {
				for (var i = 0; i < files.length; i++) {
					if ((/png$|jpe?g$|gif$|mp4$|mp3$/i).test(files[i].name)) {
						if ((/mp4$/i).test(files[i].name)) {
							doVieoBlobUrl(files[i], 'VIDEO');
						} else if ((/mp3$/i).test(files[i].name)) {
							doVieoBlobUrl(files[i], 'AUDIO');
						} else {
							doVieoBlobUrl(files[i], 'IMAGE');
						}
					}
				}
			} else {
				alert('동영상, 소리, 이미지는 최대 3개만 올릴 수 있습니다.');
			}
		});
		
		$('#startUpload').click(function(){
			var fd = new FormData();
			for(var i = 0 ; i < fileList.length ; i++){
				fd.append('file', fileList[i]);
			}

			$.ajax({
				url : '${pageContext.request.contextPath}/media/upload.do',
				processData: false,
                contentType: false,
				data : fd,
				type : 'POST',
				success : function(data) {
					console.log(data);	
				}
			})
		})
		
		$('#addFile').click(function(){
			$('#localFile').click();
		});
	});
	
	function doVieoBlobUrl(file, type) {
		var fileUrl = URL.createObjectURL(file);
		if (fileUrl.lastIndexOf('/') != -1){
			trId = fileUrl.substring(fileUrl.lastIndexOf('/')+1);
		} else {
			trId = fileUrl;
		}
		
		var fileLength =''
		var size = (file.size  / (1000 * 1000)).toFixed(2);
		if(size >= 1024) {
			fileLength = (size / 1000).toFixed(2)  + "GB"; 		
		} else {
			fileLength = size + "MB"
		}
		
		fileList.push(file);
		var html = '';
		html += '<tr id="tr_'+trId+'" class="ng-scope">';
		html +=  '<td scope="col">';
		html +=  '<div class="preview ng-scope">';
		if (type == 'VIDEO') {
			html += '<video style="width: 300px;" src="'+fileUrl+'" controls=""></video>';
		} else if (type =='AUDIO') {
			html += '<audio style="width: 300px;" controls>';
			html += '<source src="'+fileUrl+'" type="audio/mpeg">';
			html += '</audio>';
		} else {
			html += '<img src="'+fileUrl+'" width="100%" height="100%"/>';
		}
		html += '</div>';
		html += '</td>';
		html += '<td scope="col">';
		html += '<p class="size ng-binding">'+file.name+' ('+ fileLength +')</p>';
		html += '</td>';
		html += '<td scope="col">';
		html += '<a class="large btn b_black float_r" href="javascript:deleteFile(\''+file.name+'\', \'tr_'+trId+'\')">Delete File</a>'
		html += '</td>';
		html += '</tr>';
		$('#uploadFileData').append(html);
	}
	
	function deleteFile(index, trId) {
		var subFile = []
		for(var i = 0 ; i < fileList.length ; i++){
			var f = fileList[i]
			if(f.name == index){
				continue;
			}
			subFile.push(f)
		}
		fileList = subFile
		$('#' + trId).remove();
	}
	
</script>
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
			<div class="cont_white clear2" style="height:395px;">	
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
</div>