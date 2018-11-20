package com.nhn.gan.modules.auto.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.HistoryVo;


@Repository("AutoLabelingDao")
public class AutoLabelingDao extends CommonDAO {

	public List<HistoryVo> getAutoLabelingStat(DocumentVo vo) {
		return selectList("auto.getAutoLabelingStat" , vo);
	}

}
