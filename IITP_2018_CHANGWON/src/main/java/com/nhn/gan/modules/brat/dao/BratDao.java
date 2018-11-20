package com.nhn.gan.modules.brat.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.DocumentVo;


@Repository("BratDao")
public class BratDao extends CommonDAO{

	public List<AnnotationVo> getAnnotationList(DocumentVo vo) {
		return selectList("checkLabeling.getAnnotationList" , vo);
	}

	public void insertAnnotation(AnnotationVo vo) {
		insert("checkLabeling.insertAnnotation" , vo);
	}

}
