package com.nhn.gan.common.utils.file;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileInfo {
	private String fieldName;
	private String gubun; //파일구분
	private String save_path; //파일저장경로
	private String orgn_file_nm; //원파일명
	private String save_file_nm; //저장파일명
	private String mimetype; //마임타임
	private long file_size; //파일사이즈

}
