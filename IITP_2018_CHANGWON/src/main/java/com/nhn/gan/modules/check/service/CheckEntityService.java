package com.nhn.gan.modules.check.service;

import java.util.List;

import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.CommonVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.EntityVo;

public interface CheckEntityService {

	/**
	 * entity list 가져오기
	 * 
	 * @param commonVo
	 * @return
	 */
	public List<EntityVo> getEntityList(CommonVo commonVo);
	
	/**
	 * entity jstree 가져오기
	 * 
	 * @param groupName
	 * @return
	 * @throws Exception
	 */
	public String entityJstreeHtml(String groupName) throws Exception;

	/**
	 * keyword list 가져오기
	 * 
	 * @param groupName
	 * @param entity
	 * @param searchTerm
	 * @param orderOpt 
	 * @param orderField 
	 * @return
	 * @throws Exception
	 */
	public List<AnnotationVo> getKeywordList(String groupName, String entity, String searchTerm, String orderField, String orderOpt) throws Exception;

	/**
	 * 선택한 Groupname에 해당하는 태그의 레이블링 문서 가져오기
	 * 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<DocumentVo> getLabelingDocList(AnnotationVo vo) throws Exception;
	
	/**
	 * 선택한 Groupname에 해당하는 태그 이외의 레이블링 문서 가져오기
	 * 
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<DocumentVo> getWorngCheckLabelingDocList(AnnotationVo vo) throws Exception;

	/**
	 * labeling 안된 문서 가져오기
	 * 
	 * @param list
	 * @param searchKeyword 
	 * @return
	 * @throws Exception
	 */
	public List<DocumentVo> getUnlabelingList(List<DocumentVo> list, String searchKeyword) throws Exception;

	/**
	 * labeling->unlabeling 처리 하기
	 * 
	 * @param docId
	 * @param groupName
	 * @param keyword
	 * @param name 
	 * @param worngLabled 
	 * @throws Exception
	 */
	public void unlabelingDoc(String[] docId, String groupName, String[] keyword, String name, int worngLabled) throws Exception;

}
