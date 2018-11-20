package com.nhn.gan.modules.auto.service;

import java.util.List;

import com.nhn.gan.domain.DocumentVo;

public interface AutoLabelingService {

	/**
	 * 자동 레이블링 시작
	 * 
	 * @param vo
	 * @throws Exception
	 */
	public void labelingStart(DocumentVo vo) throws Exception;

	public List<DocumentVo> getAutoLabelingList(DocumentVo vo) throws Exception;

	public int getAutoLabelingListCount(DocumentVo vo) throws Exception;
	
}
