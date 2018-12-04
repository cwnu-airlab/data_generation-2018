package com.nhn.gan.domain;

import java.io.Serializable;

public class MediaTagDescVo extends CommonVo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 3749872199839753180L;
	private int tagId;
	private int mediaId;
	private int shotId;
	private String tagName;
	private String description;

	public int getTagId() {
		return tagId;
	}

	public void setTagId(int tagId) {
		this.tagId = tagId;
	}

	public int getMediaId() {
		return mediaId;
	}

	public void setMediaId(int mediaId) {
		this.mediaId = mediaId;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getShotId() {
		return shotId;
	}

	public void setShotId(int shotId) {
		this.shotId = shotId;
	}

	public String makeTagKey() {
		return mediaId + "-" + shotId + "-" + tagId;
	}

}
