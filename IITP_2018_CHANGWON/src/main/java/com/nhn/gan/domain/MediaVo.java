package com.nhn.gan.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class MediaVo extends CommonVo implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4021284817901583088L;
	private int mediaId;
	private int category;
	private String categoryName;
	private String fileName;
	private String thumbNail;
	private String localFile;
	private String registedUser;
	private String status;
	private int editFlag = 0;
	private int duration;
	private int totalFrame;
	private Timestamp regDt;
	private Timestamp uptDt;

	public int getMediaId() {
		return mediaId;
	}

	public void setMediaId(int mediaId) {
		this.mediaId = mediaId;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getThumbNail() {
		return thumbNail;
	}

	public void setThumbNail(String thumbNail) {
		this.thumbNail = thumbNail;
	}

	public String getLocalFile() {
		return localFile;
	}

	public void setLocalFile(String localFile) {
		this.localFile = localFile;
	}

	public String getRegistedUser() {
		return registedUser;
	}

	public void setRegistedUser(String registedUser) {
		this.registedUser = registedUser;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Timestamp getRegDt() {
		return regDt;
	}

	public void setRegDt(Timestamp regDt) {
		this.regDt = regDt;
	}

	public Timestamp getUptDt() {
		return uptDt;
	}

	public void setUptDt(Timestamp uptDt) {
		this.uptDt = uptDt;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public int getEditFlag() {
		return editFlag;
	}

	public void setEditFlag(int editFlag) {
		this.editFlag = editFlag;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public int getTotalFrame() {
		return totalFrame;
	}

	public void setTotalFrame(int totalFrame) {
		this.totalFrame = totalFrame;
	}

}
