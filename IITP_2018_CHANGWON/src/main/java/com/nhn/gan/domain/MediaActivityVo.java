package com.nhn.gan.domain;

import java.io.Serializable;
import java.sql.Timestamp;

public class MediaActivityVo extends CommonVo implements Serializable  {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3484194157429643664L;
	private int mediaId;
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
	private Timestamp regDt;
	private Timestamp uptDt;

	public int getMediaId() {
		return mediaId;
	}

	public void setMediaId(int mediaId) {
		this.mediaId = mediaId;
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

	public int getWhatBehavior() {
		return whatBehavior;
	}

	public void setWhatBehavior(int whatBehavior) {
		this.whatBehavior = whatBehavior;
	}

	public int getWhatObject() {
		return whatObject;
	}

	public void setWhatObject(int whatObject) {
		this.whatObject = whatObject;
	}

	public int getWhere() {
		return where;
	}

	public void setWhere(int where) {
		this.where = where;
	}

	public int getWhen() {
		return when;
	}

	public void setWhen(int when) {
		this.when = when;
	}

	public int getWhy() {
		return why;
	}

	public void setWhy(int why) {
		this.why = why;
	}

	public int getHow() {
		return how;
	}

	public void setHow(int how) {
		this.how = how;
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
	
	public String getWhoDesc() {
		return whoDesc;
	}

	public void setWhoDesc(String whoDesc) {
		this.whoDesc = whoDesc;
	}

	public String getWhatBehaviorDesc() {
		return whatBehaviorDesc;
	}

	public void setWhatBehaviorDesc(String whatBehaviorDesc) {
		this.whatBehaviorDesc = whatBehaviorDesc;
	}

	public String getWhatObjectDesc() {
		return whatObjectDesc;
	}

	public void setWhatObjectDesc(String whatObjectDesc) {
		this.whatObjectDesc = whatObjectDesc;
	}

	public String getWhereDesc() {
		return whereDesc;
	}

	public void setWhereDesc(String whereDesc) {
		this.whereDesc = whereDesc;
	}

	public String getWhenDesc() {
		return whenDesc;
	}

	public void setWhenDesc(String whenDesc) {
		this.whenDesc = whenDesc;
	}

	public String getWhyDesc() {
		return whyDesc;
	}

	public void setWhyDesc(String whyDesc) {
		this.whyDesc = whyDesc;
	}

	public String getHowDesc() {
		return howDesc;
	}

	public void setHowDesc(String howDesc) {
		this.howDesc = howDesc;
	}

	public String getWhoTagName() {
		return whoTagName;
	}

	public void setWhoTagName(String whoTagName) {
		this.whoTagName = whoTagName;
	}

	public String getWhatBehaviorTagName() {
		return whatBehaviorTagName;
	}

	public void setWhatBehaviorTagName(String whatBehaviorTagName) {
		this.whatBehaviorTagName = whatBehaviorTagName;
	}

	public String getWhatObjectTagName() {
		return whatObjectTagName;
	}

	public void setWhatObjectTagName(String whatObjectTagName) {
		this.whatObjectTagName = whatObjectTagName;
	}

	public String getWhereTagName() {
		return whereTagName;
	}

	public void setWhereTagName(String whereTagName) {
		this.whereTagName = whereTagName;
	}

	public String getWhenTagName() {
		return whenTagName;
	}

	public void setWhenTagName(String whenTagName) {
		this.whenTagName = whenTagName;
	}

	public String getWhyTagName() {
		return whyTagName;
	}

	public void setWhyTagName(String whyTagName) {
		this.whyTagName = whyTagName;
	}

	public String getHowTagName() {
		return howTagName;
	}

	public void setHowTagName(String howTagName) {
		this.howTagName = howTagName;
	}
}
