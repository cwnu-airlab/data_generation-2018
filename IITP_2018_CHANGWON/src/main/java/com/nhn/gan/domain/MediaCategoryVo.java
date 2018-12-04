package com.nhn.gan.domain;

import java.io.Serializable;

public class MediaCategoryVo extends CommonVo implements Serializable  {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3018315839461161444L;
	private int catId;
	private int mediaId;
	private String catName;

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public int getMediaId() {
		return mediaId;
	}

	public void setMediaId(int mediaId) {
		this.mediaId = mediaId;
	}
}
