package com.nhn.gan.modules.statistics.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.nhn.gan.domain.CollectionVo;
import com.nhn.gan.domain.StatisticsVO;
import com.nhn.gan.modules.data.dao.CollectionDao;
import com.nhn.gan.modules.data.dao.EntityDao;
import com.nhn.gan.modules.statistics.dao.StatisticsDAO;

@Service("statisticsService")
public class StatisticsServiceImpl implements StatisticsService {

	private static final String LINE_FEED = "\n";

	private static final String TAB = "\t";
	@Autowired
	StatisticsDAO statisticsDAO;

	@Autowired
	public CollectionDao checkDao;

	@Autowired
	public EntityDao entityDao;

	private Map<Integer, String> getCollectionInfo() {
		Map<Integer, String> map = new HashMap<Integer, String>();
		List<CollectionVo> list;
		try {
			list = checkDao.getCollectionList();
		} catch (Exception e) {
			list = Collections.emptyList();
		}
		for (CollectionVo vo : list) {
			map.put(vo.getColId(), vo.getName());
		}
		return map;
	}

	@Override
	public Map<String, Double> getRootDomainDocumentStatistics() {
		Map<String, Double> result = new LinkedHashMap<String, Double>();
		Map<String, Integer> documentCnt = new LinkedHashMap<String, Integer>();
		List<StatisticsVO> results = statisticsDAO.getDomainDocumentStatistics();

		Map<Integer, String> collectionInfoMap = getCollectionInfo();
		int totalDocCount = 0;
		for (StatisticsVO vo : results) {
			String path = vo.getPath();
			int rootColId = -1;
			if (path == null) {
				rootColId = vo.getColId();
			} else {
				String[] paths = path.split(">");
				if (paths.length > 0) {
					try {
						rootColId = Integer.parseInt(paths[0]);
					} catch (NumberFormatException e) {
						continue;
					}
				}
			}

			String rootName = collectionInfoMap.get(rootColId);

			int docCnt = vo.getCnt();
			if (documentCnt.containsKey(rootName)) {
				int rDocCnt = documentCnt.get(rootName) + docCnt;
				documentCnt.put(rootName, rDocCnt);
			} else {
				documentCnt.put(rootName, docCnt);
			}
			totalDocCount += docCnt;
		}

		for (String root : documentCnt.keySet()) {
			double rate = ((double) documentCnt.get(root)) / ((double) totalDocCount);
			result.put(root, rate);
		}
		return result;
	}

	@Override
	public String getRootDomainDocumentStatisticsChart() {
		Map<String, Double> results = getRootDomainDocumentStatistics();

		StringBuffer sb = new StringBuffer();
		sb.append("{" + LINE_FEED);
		sb.append(TAB + "\"chart\": {" + LINE_FEED);
		sb.append(TAB + TAB + "\"type\": \"pie\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\": {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-left\": \"5px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-bottom\": \"10px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"background-color\": \"#fbfbfb\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"tooltip\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "pointFormat: \"{series.name}: <b>{point.percentage:.1f}%</b>\"" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"title\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"text\" : \"도메인 별 문서 통계\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"display\" : \"none\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"plotOptions\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"pie\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"allowPointSelect\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"cursor\" : \"pointer\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"depth\" : 35," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"dataLabels\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"enabled\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"format\": \"{point.name}\"" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"series\" : [{" + LINE_FEED);
		sb.append(TAB + TAB + "\"name\" : \"최상위 도메인 문서건수 비율\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"size\" : \"70%\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"dataLabels\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"formatter\": function () {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "return this.y > 5 ? this.point.name : null;" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "}," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"color\" : \"#ffffff\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"distance\": -30" + LINE_FEED);
		sb.append(TAB + TAB + "}," + LINE_FEED);
		sb.append(TAB + TAB + "\"data\" : [" + LINE_FEED);
		// TODO 데이터 생성
		int i = 0;
		for (String res : results.keySet()) {
			sb.append(TAB + TAB + TAB + "{\"name\" :\"" + res + "\", \"y\" : " + results.get(res)
					+ ", \"color\" : Highcharts.getOptions().colors[" + i + "]}");
			if (i < (results.size() - 1)) {
				sb.append("," + LINE_FEED);
			} else {
				sb.append(LINE_FEED);
			}
			i++;
		}
		sb.append(TAB + TAB + "]" + LINE_FEED);

		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "{" + LINE_FEED);
		sb.append(TAB + TAB + "\"name\" : \"도메인 문서건수 비율\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"size\" : \"100%\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"innerSize\" : \"70%\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"dataLabels\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"formatter\": function () {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "return this.y > 1 ? '<b>' + this.point.name + ':</b> ' +\r\n"
				+ "                    this.y + '%' : null;" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + TAB + "}," + LINE_FEED);
		sb.append(TAB + TAB + "\"data\" : [" + LINE_FEED);
		// TODO 데이터 생성
		int j = 0;
		Map<String, Map<String, Double>> subResult = getDomainDocumentStatistics();
		for (String res : results.keySet()) {
			Map<String, Double> subRate = subResult.get(res);
			int k = 0;
			for (String colName : subRate.keySet()) {
				double brightness = 0.2 - (subRate.get(colName) / 5);
				sb.append(TAB + TAB + TAB + "{\"name\" :\"" + colName + "\", \"y\" : " + subRate.get(colName)
						+ ", \"color\" : Highcharts.Color(Highcharts.getOptions().colors[" + j + "]).brighten("
						+ brightness + ").get()}");
				if (k < (subRate.size() - 1)) {
					sb.append("," + LINE_FEED);
				}
				k++;
			}
			if (j < (results.size() - 1)) {
				sb.append("," + LINE_FEED);
			} else {
				sb.append(LINE_FEED);
			}
			j++;
		}
		sb.append(TAB + TAB + "]" + LINE_FEED);
		sb.append(TAB + "}]" + LINE_FEED);
		sb.append("}");
		return sb.toString().trim();
	}

	@Override
	public Map<String, Map<String, Double>> getDomainDocumentStatistics() {

		Map<String, Map<String, Double>> result = new LinkedHashMap<String, Map<String, Double>>();
		Map<String, Map<String, Integer>> documentCnt = getDomainDocumentStatisticsDocCnt();
		int totalDocCount = 0;
		for (String root : documentCnt.keySet()) {
			Map<String, Integer> subCnt = documentCnt.get(root);
			for (String colName : subCnt.keySet()) {
				totalDocCount += subCnt.get(colName);
			}
		}

		for (String root : documentCnt.keySet()) {
			Map<String, Integer> subCnt = documentCnt.get(root);
			Map<String, Double> subRate = new LinkedHashMap<String, Double>();
			for (String colName : subCnt.keySet()) {
				double rate = ((double) subCnt.get(colName)) / ((double) totalDocCount);
				subRate.put(colName, rate);
			}
			result.put(root, subRate);
		}
		return result;
	}

	@Override
	public List<StatisticsVO> getGroupNameDocumentStatistics() {
		return statisticsDAO.getGroupNameDocumentStatistics();
	}

	@Override
	public String getGroupNameDocumentStatisticsChart() {
		StringBuffer sb = new StringBuffer();
		sb.append("{" + LINE_FEED);
		sb.append(TAB + "\"chart\": {" + LINE_FEED);
		sb.append(TAB + TAB + "\"type\": \"pie\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\": {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-left\": \"5px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-bottom\": \"10px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"background-color\": \"#fbfbfb\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"tooltip\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "pointFormat: \"{series.name}: <b>{point.percentage:.1f}%</b>\"" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"title\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"text\" : \"도메인 별 문서 통계\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"display\" : \"none\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"plotOptions\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"pie\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"allowPointSelect\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"cursor\" : \"pointer\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"depth\" : 35," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"dataLabels\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"enabled\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"format\": \"{point.name}\"" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"series\" : [{" + LINE_FEED);
		sb.append(TAB + TAB + "\"name\" : \"비율\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"data\" : [" + LINE_FEED);
		List<StatisticsVO> groupNameList = getGroupNameDocumentStatistics();
		int i = 0;
		for (StatisticsVO vo : groupNameList) {
			String groupName = vo.getGroupName();
			if ("namedentity".equalsIgnoreCase(groupName)) {
				groupName = "개채명";
			} else if ("simentic".equalsIgnoreCase(groupName)) {
				groupName = "의미역";
			} else if ("hate".equalsIgnoreCase(groupName)) {
				groupName = "혐오발언";
			} else if ("simentic_analysis".equalsIgnoreCase(groupName)) {
				groupName = "의미 분석";
			}
			sb.append(TAB + TAB + TAB + "[\"" + groupName + "\"," + vo.getRate() + "]");
			if (i < (groupNameList.size() - 1)) {
				sb.append("," + LINE_FEED);
			} else {
				sb.append(LINE_FEED);
			}
			i++;
		}
		sb.append(TAB + TAB + "]" + LINE_FEED);
		sb.append(TAB + "}]" + LINE_FEED);
		sb.append("}");
		return sb.toString().trim();
	}

	@Override
	public List<StatisticsVO> getGroupNameByTagtStatistics(StatisticsVO vo) {
		List<StatisticsVO> result = statisticsDAO.getGroupNameByTagtStatistics(vo);
		int totalCnt = 0;
		for (StatisticsVO sVo : result) {
			totalCnt += sVo.getCnt();
		}

		System.out.println("TOTAL COUNT : " + totalCnt);

		for (StatisticsVO sVo : result) {
			System.out.println("TOTAL COUNT : " + totalCnt);
			System.out.println("COUNT : " + sVo.getCnt());
			double rate = ((double) sVo.getCnt() / (double) totalCnt);
			sVo.setRate(rate);
		}
		return result;
	}

	@Override
	public JSONObject getGroupNameByTagtStatisticsChart(StatisticsVO vo) {
		List<StatisticsVO> result = getGroupNameByTagtStatistics(vo);
		String groupLabels = vo.getGroupName();
		if ("namedentity".equalsIgnoreCase(groupLabels)) {
			groupLabels = "개채명";
		} else if ("simentic".equalsIgnoreCase(groupLabels)) {
			groupLabels = "의미역";
		} else if ("hate".equalsIgnoreCase(groupLabels)) {
			groupLabels = "혐오발언";
		} else if ("simentic_analysis".equalsIgnoreCase(groupLabels)) {
			groupLabels = "의미 분석";
		}

		StringBuffer sb = new StringBuffer();
		sb.append("{" + LINE_FEED);
		sb.append(TAB + "\"chart\": {" + LINE_FEED);
		sb.append(TAB + TAB + "\"type\": \"pie\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\": {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-left\": \"5px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"margin-bottom\": \"10px\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"background-color\": \"#fbfbfb\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"tooltip\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "pointFormat: \"{series.name}: <b>{point.percentage:.1f}%</b>\"" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"title\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"text\" : \"도메인 별 문서 통계\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"style\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"display\" : \"none\"" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"plotOptions\" : {" + LINE_FEED);
		sb.append(TAB + TAB + "\"pie\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"allowPointSelect\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"cursor\" : \"pointer\"," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"depth\" : 35," + LINE_FEED);
		sb.append(TAB + TAB + TAB + "\"dataLabels\" : {" + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"enabled\": true," + LINE_FEED);
		sb.append(TAB + TAB + TAB + TAB + "\"format\": \"{point.name}\"" + LINE_FEED);
		sb.append(TAB + TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + TAB + "}" + LINE_FEED);
		sb.append(TAB + "}," + LINE_FEED);
		sb.append(TAB + "\"series\" : [{" + LINE_FEED);
		sb.append(TAB + TAB + "\"name\" : \"비율\"," + LINE_FEED);
		sb.append(TAB + TAB + "\"data\" : [" + LINE_FEED);
		int i = 0;
		for (StatisticsVO sVo : result) {
			sb.append(TAB + TAB + TAB + "[\"" + sVo.getTagName() + "\"," + sVo.getCnt() + "]");
			if (i < (result.size() - 1)) {
				sb.append("," + LINE_FEED);
			} else {
				sb.append(LINE_FEED);
			}
			i++;
		}
		sb.append(TAB + TAB + "]" + LINE_FEED);
		sb.append(TAB + "}]" + LINE_FEED);
		sb.append("}");

		return new Gson().fromJson(sb.toString(), JSONObject.class);
	}

	@Override
	public List<List<StatisticsVO>> getTagByContentStatistics(StatisticsVO vo) {
		List<StatisticsVO> results = statisticsDAO.getTagByContentStatistics(vo);
		List<List<StatisticsVO>> cResult = new ArrayList<List<StatisticsVO>>();

		List<StatisticsVO> subList = null;
		for (StatisticsVO res : results) {
			if (subList == null) {
				subList = new ArrayList<StatisticsVO>();
			}
			subList.add(res);
			if (subList.size() == 25) {
				cResult.add(subList);
				subList = null;
			}
		}

		return cResult;
	}

	@Override
	public Map<String, Map<String, Integer>> getDomainDocumentStatisticsDocCnt() {
		Map<String, Map<String, Integer>> documentCnt = new LinkedHashMap<String, Map<String, Integer>>();
		List<StatisticsVO> results = statisticsDAO.getDomainDocumentStatistics();

		Map<Integer, String> collectionInfoMap = getCollectionInfo();
		for (StatisticsVO vo : results) {
			String path = vo.getPath();
			int rootColId = -1;
			int colId = -1;
			if (path == null) {
				rootColId = vo.getColId();
			} else {
				String[] paths = path.split(">");
				if (paths.length > 1) {
					try {
						rootColId = Integer.parseInt(paths[0]);
						colId = Integer.parseInt(paths[1]);
					} catch (NumberFormatException e) {
						continue;
					}
				} else if (paths.length == 1) {
					rootColId = Integer.parseInt(paths[0]);
					colId = vo.getColId();
				} else {
					continue;
				}
			}

			String rootName = collectionInfoMap.get(rootColId);
			String colName = collectionInfoMap.get(colId);

			if (colName == null) {
				colName = "";
			}
			Map<String, Integer> subCnt = null;
			if (documentCnt.containsKey(rootName)) {
				subCnt = documentCnt.get(rootName);
			} else {
				subCnt = new LinkedHashMap<String, Integer>();
				documentCnt.put(rootName, subCnt);
			}

			int docCnt = vo.getCnt();
			if (subCnt.containsKey(colName)) {
				int rDocCnt = subCnt.get(colName) + docCnt;
				subCnt.put(colName, rDocCnt);
			} else {
				subCnt.put(colName, docCnt);
			}
		}
		return documentCnt;
	}

}
