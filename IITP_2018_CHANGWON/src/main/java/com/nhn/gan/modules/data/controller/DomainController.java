package com.nhn.gan.modules.data.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.common.utils.Pagination;
import com.nhn.gan.domain.CollectionVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.modules.data.service.CollectionService;
import com.nhn.gan.modules.data.service.DocumentService;

@Controller
public class DomainController {
	Logger log = LoggerFactory.getLogger(this.getClass());
	   
	@Autowired
	public DocumentService documentService;
	
	@Autowired
	public CollectionService collectionService;
	
	
    @RequestMapping(value="/data/domain/list.do")
    public ModelAndView getDomainList(HttpServletRequest request, DocumentVo vo) throws Exception {
        ModelAndView mv = new ModelAndView();

        List<DocumentVo> docList = documentService.getDocRecordList(vo);
        
        int colId = vo.getColId();
        int count = documentService.getDocRecordListCount(vo);
        String domainJstreeHtml = collectionService.domainJstreeHtml(colId, request.getContextPath());
        
        mv.addObject("domainJstreeHtml", domainJstreeHtml);
        mv.addObject("list", docList);
        mv.addObject("count", count);
        mv.addObject("pagination", new Pagination(request, count));
        mv.addObject("doc", vo);
        
        mv.setViewName("data/domain/list");
        return mv;
    }
    
    @RequestMapping(value="/data/domain/insert.do", produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView insertDomain(HttpServletRequest request, CollectionVo vo) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        collectionService.insertDomain(vo);
        
        int colId = vo.getParentId();
        String domainJstreeHtml = collectionService.domainJstreeHtml(colId, request.getContextPath());
        
        mv.addObject("domainJstreeHtml", domainJstreeHtml);
        return mv;
    }
    
    @RequestMapping(value="/data/domain/edit.do", produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView editDomain(HttpServletRequest request, CollectionVo vo) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        
        collectionService.updateDomain(vo);
        
        int colId = vo.getColId();
        String domainJstreeHtml = collectionService.domainJstreeHtml(colId, request.getContextPath());
        mv.addObject("domainJstreeHtml", domainJstreeHtml);
        
        return mv;
    }
    
    @RequestMapping(value="/data/domain/delete.do", produces = MediaType.APPLICATION_JSON_VALUE)
    public ModelAndView deleteDomain(HttpServletRequest request, CollectionVo vo) throws Exception {
        ModelAndView mv = new ModelAndView("jsonView");
        
        collectionService.deleteDomain(vo);
        
        String domainJstreeHtml = collectionService.domainJstreeHtml(null, request.getContextPath());
        mv.addObject("domainJstreeHtml", domainJstreeHtml);
        return mv;
    }
}
