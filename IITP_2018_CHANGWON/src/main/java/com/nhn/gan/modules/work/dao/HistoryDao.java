package com.nhn.gan.modules.work.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.CommonVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.HistoryVo;

@Repository("historyDao")
public class HistoryDao extends CommonDAO {
	
	public void addHistory(HistoryVo vo) {
		insert("history.addHistory" , vo);
	}
	
	public void addHistoryRecord(HistoryVo vo) {
		insert("history.addHistoryRecord" , vo);
	}
	
	public List<HistoryVo> getHistoryList(CommonVo vo) {
		return selectList("history.getHistoryList" , vo);
	}

	public int getHistoryListCount(CommonVo vo) {
		return (int)selectOne("history.getHistoryListCount" , vo);
	}

	public List<HistoryVo> getRecordHistoryList(DocumentVo vo) {
		return selectList("history.getRecordHistoryList" , vo);
	}

	public List<AnnotationVo> getCompareLoc(HashMap<String,Object> map) {
		return selectList("history.getCompareLoc" , map);
	}

}
