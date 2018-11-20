package com.nhn.gan.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EntityVo extends CommonVo {
	
	/**
	 * entity 고유 ID
	 */
	private String entId;
	
	/**
	 * entity 이름
	 */
	private String name;
	
	/**
	 * 그룹 이름
	 */
	private String groupName;
	
	/**
	 * 라벨 이름
	 */
	private String label;
	
	/**
	 * 배경색
	 */
	private String bgColor;
	
	/**
	 * TAG 배경색
	 */
	private String fgColor;
	
	/**
	 * 부모 entity 이름
	 */
	private String parentEnt;
}
