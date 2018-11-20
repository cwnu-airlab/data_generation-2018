package com.nhn.gan.modules.check.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.AnnotationVo;
import com.nhn.gan.domain.CommonVo;
import com.nhn.gan.domain.DocumentVo;
import com.nhn.gan.domain.EntityVo;


@Repository("CheckEntityDao")
public class CheckEntityDao extends CommonDAO{

	public List<EntityVo> getEntityList(CommonVo vo) {
		return selectList("checkEntity.getEntityList" , vo);
	}

	public List<AnnotationVo> getKeywordList(HashMap<String,Object> map) {
		return selectList("checkEntity.getKeywordList" , map);
	}

	public List<DocumentVo> getLabelingDocList(AnnotationVo vo) {
		return selectList("checkEntity.getLabelingDocList" , vo);
	}

	public List<DocumentVo> getUnlabelingList(List<DocumentVo> list, String searchKeyword) {
		HashMap <String,Object> map = new HashMap<>();
		map.put("list", list);
		map.put("searchKeyword", searchKeyword);
		return selectList("checkEntity.getUnlabelingList" , map);
	}

	public List<DocumentVo> getWorngCheckLabelingDocList(AnnotationVo vo) {
		return selectList("checkEntity.getWorngCheckLabelingDocList" , vo);
	}

}
