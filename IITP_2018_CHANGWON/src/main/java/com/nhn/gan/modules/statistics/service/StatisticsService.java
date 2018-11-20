package com.nhn.gan.modules.statistics.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

import com.nhn.gan.domain.StatisticsVO;

public interface StatisticsService {

	Map<String, Double> getRootDomainDocumentStatistics();

	String getRootDomainDocumentStatisticsChart();

	Map<String, Map<String, Double>> getDomainDocumentStatistics();
	
	Map<String, Map<String, Integer>> getDomainDocumentStatisticsDocCnt();

	List<StatisticsVO> getGroupNameDocumentStatistics();

	String getGroupNameDocumentStatisticsChart();

	List<StatisticsVO> getGroupNameByTagtStatistics(StatisticsVO vo);

	JSONObject getGroupNameByTagtStatisticsChart(StatisticsVO vo);

	List<List<StatisticsVO>> getTagByContentStatistics(StatisticsVO vo);

}
