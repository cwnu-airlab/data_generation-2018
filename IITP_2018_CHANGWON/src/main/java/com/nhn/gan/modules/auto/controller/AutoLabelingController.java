package com.nhn.gan.modules.auto.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.common.utils.Pagination;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.modules.auto.service.AutoLabelingService;
import com.nhn.gan.modules.data.service.CollectionService;

@Controller
public class AutoLabelingController {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	public CollectionService collectionService;

	@Autowired
	public AutoLabelingService autoLabelingService;

	@RequestMapping(value = "/auto/list.do")
	public ModelAndView getAutoList(HttpServletRequest request, DocumentVo vo) throws Exception {
		ModelAndView mv = new ModelAndView();
		if (StringUtils.isEmpty(vo.getGroupName())) {
			vo.setGroupName("namedentity");
		}

		Integer colId = vo.getColId();
		String domainJstreeHtml = collectionService.domainJstreeHtml(colId, request.getContextPath());

		List<DocumentVo> list = autoLabelingService.getAutoLabelingList(vo);
		int count = autoLabelingService.getAutoLabelingListCount(vo);

		if (vo.getGroupName() == null || (vo.getGroupName() != null && "".equalsIgnoreCase(vo.getName()))) {
			vo.setGroupName("ALL");
		}

		mv.addObject("domainJstreeHtml", domainJstreeHtml);
		mv.addObject("list", list);
		mv.addObject("count", count);
		mv.addObject("pagination", new Pagination(request, count));
		mv.addObject("doc", vo);
		mv.setViewName("auto/list");
		return mv;
	}

	@RequestMapping(value = "/auto/start.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView AutolabelingStart(DocumentVo vo) throws Exception {
		ModelAndView mv = new ModelAndView("jsonView");
		autoLabelingService.labelingStart(vo);
		return mv;
	}

}
