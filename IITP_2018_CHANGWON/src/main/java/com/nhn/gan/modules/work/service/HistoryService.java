package com.nhn.gan.modules.work.service;

import java.util.HashMap;
import java.util.List;

import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.CollectionVo;
import com.nhn.gan.domain.CommonVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.HistoryVo;

public interface HistoryService {
	
	public void addHistory(HistoryVo vo) throws Exception;
	
	public void addHistoryRecord(HistoryVo vo) throws Exception;	

	public HistoryVo makeDomainHistory(String action, CollectionVo vo, String etc) throws Exception;
	
	public HistoryVo makeDocHistory(String action, DocumentVo vo, String etc) throws Exception;
		
	public HistoryVo makeLabelingHistory(String action, int recordId, String etc) throws Exception;
	
	public List<HistoryVo> getHistoryList(CommonVo vo) throws Exception;

	public int getHistoryListCount(CommonVo vo) throws Exception;

	public List<HistoryVo> getRecordHistoryList(DocumentVo vo) throws Exception;

	public List<AnnotationVo> getCompareLoc(HashMap<String,Object> map) throws Exception;

}
