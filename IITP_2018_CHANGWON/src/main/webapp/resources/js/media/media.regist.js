/**
 * 
 */
var fileList = [];
var uploadChkInterVal = null;
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
		console.log(files);
		if ($('tr[id^=tr_]').length < 20) {
			for (var i = 0; i < files.length; i++) {
				if ((/png$|jpe?g$|gif$|mp4$|avi$|mkv$|mp3$/i).test(files[i].name)) {
					if ((/mp4$|avi$|mkv$/i).test(files[i].name)) {
						doVieoBlobUrl(files[i], 'VIDEO');
					} else if ((/mp3$/i).test(files[i].name)) {
						doVieoBlobUrl(files[i], 'AUDIO');
					} else {
						doVieoBlobUrl(files[i], 'IMAGE');
					}
				}
			}
		} else {
			alert('미디어 파일은 최대 20개 까지 등록이 가능합니다.');
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
		if ($('tr[id^=tr_]').length < 20) {
			for (var i = 0; i < files.length; i++) {
				if ((/png$|jpe?g$|gif$|mp4$|avi$|mkv$|mp3$/i).test(files[i].name)) {
					if ((/mp4$|avi$|mkv$/i).test(files[i].name)) {
						doVieoBlobUrl(files[i], 'VIDEO');
					} else if ((/mp3$/i).test(files[i].name)) {
						doVieoBlobUrl(files[i], 'AUDIO');
					} else {
						doVieoBlobUrl(files[i], 'IMAGE');
					}
				}
			}
		} else {
			alert('미디어 파일은 최대 20개 까지 등록이 가능합니다.');
		}
	});
	
	$('#startUpload').click(function(){
		var fd = new FormData();
		for(var i = 0 ; i < fileList.length ; i++){
			fd.append('file', fileList[i]);
		}

		$.ajax({
			url : contextPath+'/media/upload.do',
			processData: false,
            contentType: false,
			data : fd,
			type : 'POST',
			beforeSend : function () {
				open_modal('modal_progress');
				uploadChkInterVal = setInterval(function(){uploadCheckInterval();}, 2000);
			},
			success : function(data) {
				close_modal_porgress('modal_progress');
				alert('선택한 파일의 업로드를 완료하였습니다.')
				$('#uploadFileData').empty();
				clearInterval(uploadChkInterVal);
				uploadChkInterVal = null;
			}, error : function (){
				close_modal_porgress('modal_progress');
				alert('파일 업로드 및 미디어 등록에 실패하였습니다.');
				clearInterval(uploadChkInterVal);
				uploadChkInterVal = null;
			}
		})
	})
	
	$('#addFile').click(function(){
		$('#localFile').click();
	});
	
});

function uploadCheckInterval(){
	$.ajax({
		url : contextPath + '/media/uploadChk.do',
		type : 'get',
		success : function(data){
			if(data){
				$('#uploadMessage').html($.trim(data));
			}
		}
	})
}


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
	html += '<a class="large btn btn_delete float_r" href="javascript:deleteFile(\''+file.name+'\', \'tr_'+trId+'\')">Delete File</a>'
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