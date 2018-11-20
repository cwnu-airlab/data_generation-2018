package com.nhn.gan.modules.check.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.modules.brat.service.BratService;
import com.nhn.gan.modules.check.service.CheckLabelingService;
import com.nhn.gan.modules.data.service.CollectionService;
import com.nhn.gan.modules.data.service.DocumentService;

@Controller
public class CheckLabelingController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	public BratService bratService;

	@Autowired
	public CheckLabelingService checkLabelingService;

	@Autowired
	public CollectionService collectionService;

	@Autowired
	public DocumentService documentService;

	@RequestMapping(value = "/check/labeling/list.do")
	public ModelAndView main(HttpServletRequest request, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("check/labeling/list");

		String domainJstreeHtml = collectionService.domainJstreeHtml(null, request.getContextPath());

		String namedentityJstreeHtml = checkLabelingService.elementJstreeHtml("namedentity", null);
		String simenticJstreeHtml = checkLabelingService.elementJstreeHtml("simentic", null);
		String simenticAanlysisJstreeHtml = checkLabelingService.elementJstreeHtml("simentic_analysis", null);
		String hateJstreeHtml = checkLabelingService.elementJstreeHtml("hate", null);

		mv.addObject("domainJstreeHtml", domainJstreeHtml);
		mv.addObject("namedentityJstreeHtml", namedentityJstreeHtml);
		mv.addObject("simenticJstreeHtml", simenticJstreeHtml);
		mv.addObject("simenticAanlysisJstreeHtml", simenticAanlysisJstreeHtml);
		mv.addObject("hateJstreeHtml", hateJstreeHtml);
		return mv;
	}

	@RequestMapping(value = "/check/labeling/docList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView getDocList(DocumentVo documentVo) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		List<DocumentVo> docList = documentService.getDocSubjectGroupList(documentVo);

		int index = 0;
		for (DocumentVo vo : docList) {
			Date regDate = vo.getRegDate();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String date = format.format(regDate);
			vo.setDate(date);

			docList.set(index, vo);
			index++;
		}

		mv.addObject("docList", docList);
		mv.addObject("count", docList.size());
		return mv;
	}

}
