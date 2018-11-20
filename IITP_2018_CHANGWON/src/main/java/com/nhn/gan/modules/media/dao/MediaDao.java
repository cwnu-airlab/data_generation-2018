package com.nhn.gan.modules.media.dao;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;


@Repository("mediaDao")
public class MediaDao extends CommonDAO{

	public int getMediaId() {
		return getSqlSession().selectOne("media.getMediaId");
	}
	
	public String getNoneCategory() {
		return getSqlSession().selectOne("media.getNoneCategory");
	}

}
