package com.nhn.gan.modules.check.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.EntityVo;
import com.nhn.gan.modules.brat.service.BratService;
import com.nhn.gan.modules.check.service.CheckEntityService;
import com.nhn.gan.modules.data.service.EntityService;

@Controller
public class CheckEntityController {

	@Autowired
	public CheckEntityService checkEntityService;

	@Autowired
	public EntityService entityService;

	@Autowired
	public BratService bratService;

	@RequestMapping(value = "/check/entity/list.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getEntityList(DocumentVo documentVo) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("check/entity/list");

		String namedentityJstreeHtml = checkEntityService.entityJstreeHtml("namedentity");
		String simenticJstreeHtml = checkEntityService.entityJstreeHtml("simentic");
		String simenticAanlysisJstreeHtml = checkEntityService.entityJstreeHtml("simentic_analysis");
		String hateJstreeHtml = checkEntityService.entityJstreeHtml("hate");

		mv.addObject("namedentityJstreeHtml", namedentityJstreeHtml);
		mv.addObject("simenticJstreeHtml", simenticJstreeHtml);
		mv.addObject("simenticAanlysisJstreeHtml", simenticAanlysisJstreeHtml);
		mv.addObject("hateJstreeHtml", hateJstreeHtml);
		return mv;
	}

	@RequestMapping(value = "/check/entity/keywordList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getKeywordList(String groupName, String entity, String searchTerm, String orderField, String orderOpt) throws Exception {
		System.out.println(orderOpt);
		ModelAndView mv = new ModelAndView("jsonView");
		List<EntityVo> seletedEnt = entityService.getEntityByEntId(entity);
		List<AnnotationVo> keywordList = checkEntityService.getKeywordList(groupName, entity, searchTerm, orderField, orderOpt);
		mv.addObject("selectEntityDesc", seletedEnt);
		mv.addObject("keywordList", keywordList);
		mv.addObject("keywordListCount", keywordList.size());
		return mv;
	}

	@RequestMapping(value = "/check/entity/docList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getLabelingDocList(AnnotationVo vo) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");

		List<DocumentVo> labelingAllList = new ArrayList<>();
		List<DocumentVo> labelingList = checkEntityService.getLabelingDocList(vo);
		long labelingCnt = 0;
		for(DocumentVo v : labelingList) {
			labelingCnt += v.getCount();
		}
		
		labelingAllList.addAll(labelingList);

		List<DocumentVo> worngLabelingList = checkEntityService.getWorngCheckLabelingDocList(vo);
		long wLabelingCnt = 0;
		for(DocumentVo v : worngLabelingList) {
			wLabelingCnt += v.getCount();
		}
		labelingAllList.addAll(worngLabelingList);

		List<DocumentVo> unlabelingList = checkEntityService.getUnlabelingList(labelingAllList, vo.getSearchKeyword());

		mv.addObject("labelingList", labelingList);
		mv.addObject("labelingListCount", labelingList.size());
		mv.addObject("lableingCount", labelingCnt);
		mv.addObject("worngLabelingList", worngLabelingList);
		mv.addObject("worngLabelingListCount", worngLabelingList.size());
		mv.addObject("worngLabelingCount", wLabelingCnt);
		mv.addObject("unlabelingList", unlabelingList);
		mv.addObject("unlabelingListCount", unlabelingList.size());
		return mv;
	}

	@RequestMapping(value = "/check/entity/bratDetailView.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView bratDetailView(DocumentVo documentVo) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		mv.addObject("map", bratService.bratReadOnly(documentVo));
		return mv;
	}

	@RequestMapping(value = "/check/entity/unlabeling.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView unlabeling(String docId, String groupName, String[] keyword, String name, int worngLabled)
			throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		checkEntityService.unlabelingDoc(docId.split(","), groupName, keyword, name, worngLabled);
		return mv;
	}
}
