package com.nhn.gan.domain;

import java.io.Serializable;

public class MediaShotVo extends CommonVo implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7198580088325112544L;
	private int shotId;
	private int mediaId;
	private String localFile;
	private int startFrame;
	private int endFrame;
	private String startThumb;
	private String endThumb;
	private String startTimeCode;
	private String endTimeCode;
	private int startTime;
	private int endTime;
	private String title;
	private int who;
	private String whoTagName;
	private String whoDesc;
	private int whatBehavior;
	private String whatBehaviorTagName;
	private String whatBehaviorDesc;
	private int whatObject;
	private String whatObjectTagName;
	private String whatObjectDesc;
	private int where;
	private String whereTagName;
	private String whereDesc;
	private int when;
	private String whenTagName;
	private String whenDesc;
	private int why;
	private String whyTagName;
	private String whyDesc;
	private int how;
	private String howTagName;
	private String howDesc;

	private String editField;
	
	public int getShotId() {
		return shotId;
	}

	public void setShotId(int shotId) {
		this.shotId = shotId;
	}

	public int getMediaId() {
		return mediaId;
	}

	public void setMediaId(int mediaId) {
		this.mediaId = mediaId;
	}

	public int getStartFrame() {
		return startFrame;
	}

	public void setStartFrame(int startFrame) {
		this.startFrame = startFrame;
	}

	public int getEndFrame() {
		return endFrame;
	}

	public void setEndFrame(int endFrame) {
		this.endFrame = endFrame;
	}

	public String getStartThumb() {
		return startThumb;
	}

	public void setStartThumb(String startThumb) {
		this.startThumb = startThumb;
	}

	public String getEndThumb() {
		return endThumb;
	}

	public void setEndThumb(String endThumb) {
		this.endThumb = endThumb;
	}

	public String getStartTimeCode() {
		return startTimeCode;
	}

	public void setStartTimeCode(String startTimeCode) {
		this.startTimeCode = startTimeCode;
		setStartTimeInfo(startTimeCode);
	}

	public String getEndTimeCode() {
		return endTimeCode;
	}

	public void setEndTimeCode(String endTimeCode) {
		this.endTimeCode = endTimeCode;
		setEndTimeInfo(endTimeCode);
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getWho() {
		return who;
	}

	public void setWho(int who) {
		this.who = who;
	}

	public String getWhoTagId() {
		return mediaId + "-" + shotId + "-" + who;
	}

	public String getWhoTagName() {
		return whoTagName;
	}

	public String getWhoDesc() {
		return whoDesc;
	}

	public void setWhoTagInfo(MediaTagDescVo desc) {
		this.whoTagName = desc.getTagName();
		this.whoDesc = desc.getDescription();
	}

	public int getWhatBehavior() {
		return whatBehavior;
	}

	public void setWhatBehavior(int whatBehavior) {
		this.whatBehavior = whatBehavior;
	}

	public String getWhatBehaviorTagId() {
		return mediaId + "-" + shotId + "-" + whatBehavior;
	}

	public String getWhatBehaviorTagName() {
		return whatBehaviorTagName;
	}

	public String getWhatBehaviorDesc() {
		return whatBehaviorDesc;
	}

	public void setWhatBehaviorTagInfo(MediaTagDescVo desc) {
		this.whatBehaviorTagName = desc.getTagName();
		this.whatBehaviorDesc = desc.getDescription();
	}

	public int getWhatObject() {
		return whatObject;
	}

	public void setWhatObject(int whatObject) {
		this.whatObject = whatObject;
	}

	public String getWhatObjectTagId() {
		return mediaId + "-" + shotId + "-" + whatObject;
	}

	public String getWhatObjectTagName() {
		return whatObjectTagName;
	}

	public String getWhatObjectDesc() {
		return whatObjectDesc;
	}

	public void setWhatObjectTagInfo(MediaTagDescVo desc) {
		this.whatObjectTagName = desc.getTagName();
		this.whatObjectDesc = desc.getDescription();
	}

	public int getWhere() {
		return where;
	}

	public void setWhere(int where) {
		this.where = where;
	}

	public String getWhereTagId() {
		return mediaId + "-" + shotId + "-" + where;
	}

	public String getWhereTagName() {
		return whereTagName;
	}

	public String getWhereDesc() {
		return whereDesc;
	}

	public void setWhereTagInfo(MediaTagDescVo desc) {
		this.whereTagName = desc.getTagName();
		this.whereDesc = desc.getDescription();
	}

	public int getWhen() {
		return when;
	}

	public void setWhen(int when) {
		this.when = when;
	}

	public String getWhenTagId() {
		return mediaId + "-" + shotId + "-" + when;
	}

	public String getWhenTagName() {
		return whenTagName;
	}

	public void setWhenTagInfo(MediaTagDescVo desc) {
		this.whenTagName = desc.getTagName();
		this.whenTagName = desc.getDescription();
	}

	public String getWhenDesc() {
		return whenDesc;
	}

	public int getWhy() {
		return why;
	}

	public void setWhy(int why) {
		this.why = why;
	}

	public String getWhyTagId() {
		return mediaId + "-" + shotId + "-" + why;
	}

	public String getWhyTagName() {
		return whyTagName;
	}

	public String getWhyDesc() {
		return whyDesc;
	}

	public void setWhyTagInfo(MediaTagDescVo desc) {
		this.whyTagName = desc.getTagName();
		this.whyDesc = desc.getDescription();
	}

	public int getHow() {
		return how;
	}

	public void setHow(int how) {
		this.how = how;
	}

	public String getHowTagId() {
		return mediaId + "-" + shotId + "-" + how;
	}

	public String getHowTagName() {
		return howTagName;
	}

	public String getHowDesc() {
		return howDesc;
	}

	public void setHowTagInfo(MediaTagDescVo desc) {
		this.howTagName = desc.getTagName();
		this.howDesc = desc.getDescription();
	}

	private String startTimeInfo;

	public void setStartTimeInfo(String startTimeCode) {
		if (startTimeCode == null) {
			return;
		}
		this.startTimeInfo = convertTimeCode(startTimeCode);
	}
	
	

	public String getStartTimeInfo() {
		return startTimeInfo;
	}

	public String getEndTimeInfo() {
		return endTimeInfo;
	}

	private String endTimeInfo;

	public void setEndTimeInfo(String endTimeCode) {
		if (endTimeCode == null) {
			return;
		}
		this.endTimeInfo = convertTimeCode(endTimeCode);
	}

	private String convertTimeCode(String startTimeCode) {
		String[] timeArray = startTimeCode.split(":");

		String hour = timeArray[0];
		String min = timeArray[1];
		String sec = timeArray[2];

		String timeText = "";

		if (!"00".equalsIgnoreCase(hour)) {
			if (hour.startsWith("0")) {
				timeText += hour.substring(1) + "시간 ";
			} else {
				timeText += hour + "시간 ";
			}
		}

		if ("".equalsIgnoreCase(timeText.trim())) {
			if (!"00".equalsIgnoreCase(min)) {
				if (min.startsWith("0")) {
					timeText += min.substring(1) + "분 ";
				} else {
					timeText += min + "분 ";
				}
			}
		} else {
			timeText += min + "분 ";
		}

		if ("".equals(timeText.trim())) {
			if (!"00".equalsIgnoreCase(sec)) {
				if (min.startsWith("0")) {
					timeText += sec.substring(1) + "초 ";
				} else {
					timeText += sec + "초 ";
				}
			} else {
				timeText += "0초 ";
			}
		} else {
			timeText += sec + "초 ";
		}
		return timeText;
	}

	public int getEndTime() {
		return endTime;
	}

	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}

	public int getStartTime() {
		return startTime;
	}

	public void setStartTime(int startTime) {
		this.startTime = startTime;
	}

	public String getLocalFile() {
		return localFile;
	}

	public void setLocalFile(String localFile) {
		this.localFile = localFile;
	}

	public String getEditField() {
		return editField;
	}

	public void setEditField(String editField) {
		this.editField = editField;
	}

}
