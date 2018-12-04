package com.nhn.gan.domain;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;

public class CommonVo {

	@Getter
	@Setter
	String searchTerm;

	@Getter
	@Setter
	String searchTermOpt;

	@Getter
	@Setter
	String typeOpt;

	@Getter
	@Setter
	String startDate = oneWeekAgo();

	@Getter
	@Setter
	String endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());

	@Getter
	@Setter
	String dateSearchOpt;

	@Getter
	@Setter
	String jstreeName;

	@Getter
	@Setter
	String jstreeId;

	@Getter
	@Setter
	String groupName;

	@Getter
	@Setter
	String name;

	@Getter
	@Setter
	private String keyword;

	@Getter
	@Setter
	String[] keywords;

	@Setter
	String userId;

	@Getter
	@Setter
	String[] searchTagName;

	@Getter
	@Setter
	String entityTag;

	@Getter
	@Setter
	String labelingType;

	public String getUserId() {
		if (StringUtils.isEmpty(userId)) {
			UserVo vo = (UserVo) RequestContextHolder.getRequestAttributes().getAttribute("userLoginInfo",
					RequestAttributes.SCOPE_SESSION);
			userId = vo.getUserId();
		}
		return userId;
	}

	@Getter
	@Setter
	String domain;

	@Getter
	@Setter
	String domainPath;

	@Getter
	@Setter
	boolean result;

	@Getter
	@Setter
	String[] entIds;

	@Getter
	@Setter
	String[] recordIds;

	@Getter
	@Setter
	String[] docIds;

	@Getter
	@Setter
	String[] relIds;

	@Getter
	@Setter
	Integer pageNo = 1;

	@Getter
	@Setter
	Integer pageSize = 10;

	Integer offSet;

	@Getter
	@Setter
	String searchKeyword;

	public Integer getOffSet() {
		return pageNo == null || pageSize == null ? null : (pageNo - 1) * pageSize;
	}

	@Getter
	int startIndex = 0;
	
	@Getter
	int endIndex = 0;

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
		setStartIndex(pageNo);
		setEndIndex(pageNo);
	}


	public void setEndIndex(int pageNo) {
		this.endIndex = pageNo * pageSize;
	}

	public void setStartIndex(int pageNo) {
		this.startIndex = (pageNo - 1) * pageSize;
	}


	public String oneWeekAgo() {
		Calendar week = Calendar.getInstance();
		week.add(Calendar.DATE, -7);
		String date = new java.text.SimpleDateFormat("yyyy-MM-dd").format(week.getTime());
		return date;
	}

	@Getter
	@Setter
	private MultipartFile[] file;

	@Getter
	@Setter
	String orderField;

	@Getter
	@Setter
	String orderOpt;

}
