package com.nhn.gan.modules.statistics.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.StatisticsVO;

@Repository
public class StatisticsDAO extends CommonDAO {

	public List<StatisticsVO> getDomainDocumentStatistics() {
		return selectList("statistics.getDomainDocumentStatistics");
	}

	public List<StatisticsVO> getGroupNameDocumentStatistics() {
		return selectList("statistics.getGroupNameDocumentStatistics");
	}

	public List<StatisticsVO> getGroupNameByTagtStatistics(StatisticsVO vo) {
		return selectList("statistics.getGroupNameByTagStatistics", vo);
	}

	public List<StatisticsVO> getTagByContentStatistics(StatisticsVO vo) {
		return selectList("statistics.getTagByContentStatistics", vo);
	}
}
