package com.nhn.gan.domain;

import java.text.NumberFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AnnotationVo extends CommonVo {
	
	/**
	 * annotation 고유 ID
	 */
	private Integer id;
	
	/**
	 * record 고유 ID
	 */
	private Integer recordId;
	
	/**
	 * record 시퀀스
	 */
	private Integer recordSeq;
	
	/**
	 * annotation 이름
	 */
	private String annId;
	
	/**
	 * entity 혹은 relation 이름
	 */
	private String name;
	
	/**
	 * 시작 지점
	 */
	private String startPoint;
	
	/**
	 * 끝 지점
	 */
	private String endPoint;
	
	/**
	 * 내용
	 */
	private String content;
	
	/**
	 * 카운트
	 */
	private Integer count;
	
	private Double subCount;
	private String subCntFmt;
	
	private String groupName;
	
	public void setSubCount(Double subCount) {
		this.subCount = subCount;
		setSubCntFmt();
	}
	
	
	public void setSubCntFmt() {
		subCntFmt = NumberFormat.getInstance().format(subCount);
	}
	
	
	public String getSubCntFmt() {
		return subCntFmt;
	}
}
