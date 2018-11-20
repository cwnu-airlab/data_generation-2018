package com.nhn.gan.modules.statistics.web;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.domain.StatisticsVO;
import com.nhn.gan.modules.statistics.service.StatisticsService;

@Controller
public class StatisticsController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	StatisticsService statisticsService;

	@RequestMapping(value = "/statistics/text/list.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public String getTextLabeldStatistics(StatisticsVO statisticsVO, Model model) throws Exception {

		String documentChartJson = statisticsService.getRootDomainDocumentStatisticsChart();
		Map<String, Map<String, Double>> resDocRate = statisticsService.getDomainDocumentStatistics();
		Map<String, Map<String, Integer>> resDocCnt = statisticsService.getDomainDocumentStatisticsDocCnt();

		String groupNameChartJson = statisticsService.getGroupNameDocumentStatisticsChart();
		List<StatisticsVO> groupNameStatistics = statisticsService.getGroupNameDocumentStatistics();
		model.addAttribute("documentChartJson", documentChartJson);
		model.addAttribute("groupNameChartJson", groupNameChartJson);
		model.addAttribute("groupNameStatistics", groupNameStatistics);
		model.addAttribute("resDocRate", resDocRate);
		model.addAttribute("resDocCnt", resDocCnt);
		return "statistics/text/list";
	}

	// TODO 통계 차트 관련 처리

	@RequestMapping(value = "/statistics/text/lableingChatJson.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getTextLableingChatJson(StatisticsVO statisticsVO, ModelAndView model) throws Exception {
		model.setViewName("jsonView");
		List<StatisticsVO> result = statisticsService.getGroupNameByTagtStatistics(statisticsVO);
		JSONObject json = statisticsService.getGroupNameByTagtStatisticsChart(statisticsVO);
		model.addObject("chartJson", json);
		model.addObject("tableJson", result);
		return model;
	}

	
	@RequestMapping(value = "/statistics/text/tagByContents.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getTextTagByContents(StatisticsVO statisticsVO, ModelAndView model) throws Exception {
		model.setViewName("jsonView");
		List<List<StatisticsVO>> result = statisticsService.getTagByContentStatistics(statisticsVO);
		model.addObject("contentTagList", result);
		return model;
	}
	
	
	@RequestMapping(value = "/statistics/media/list.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public String getMediaLabeldStatistics(StatisticsVO statisticsVO, Model model) throws Exception {

//		String documentChartJson = statisticsService.getRootDomainDocumentStatisticsChart();
//		Map<String, Map<String, Double>> resDocRate = statisticsService.getDomainDocumentStatistics();
//		Map<String, Map<String, Integer>> resDocCnt = statisticsService.getDomainDocumentStatisticsDocCnt();
//
//		String groupNameChartJson = statisticsService.getGroupNameDocumentStatisticsChart();
//		List<StatisticsVO> groupNameStatistics = statisticsService.getGroupNameDocumentStatistics();
//		model.addAttribute("documentChartJson", documentChartJson);
//		model.addAttribute("groupNameChartJson", groupNameChartJson);
//		model.addAttribute("groupNameStatistics", groupNameStatistics);
//		model.addAttribute("resDocRate", resDocRate);
//		model.addAttribute("resDocCnt", resDocCnt);
		return "statistics/media/list";
	}
}
