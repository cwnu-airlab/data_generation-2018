package com.nhn.gan.modules.media.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.nhn.gan.common.dao.CommonDAO;
import com.nhn.gan.domain.MediaCategoryVo;
import com.nhn.gan.domain.MediaShotVo;
import com.nhn.gan.domain.MediaTagDescVo;
import com.nhn.gan.domain.MediaVo;

@Repository("mediaDao")
public class MediaDao extends CommonDAO {

	public int getMediaId() {
		return getSqlSession().selectOne("media.getMediaId");
	}

	public String getNoneCategory() {
		return getSqlSession().selectOne("media.getNoneCategory");
	}

	public int insertMedia(MediaVo vo)  throws Exception{
		return getSqlSession().insert("media.insertMedia", vo);
	}
	
	public int selectMediaInfoCount(MediaVo vo) {
		return getSqlSession().selectOne("media.selectMediaInfoCount", vo);
	}
	
	public int insertMediaCategory(MediaCategoryVo vo) throws Exception {
		return getSqlSession().insert("media.insertMediaCategory", vo);	
	}

	public int updateMediaCategory(MediaVo vo)  throws Exception{
		return getSqlSession().update("media.updateMediaCategory", vo);	
	}
	
	public List<MediaVo> selectMediaInfoList(MediaVo vo) {
		return getSqlSession().selectList("media.selectMediaInfoList", vo);
	}
	
	public MediaVo selectMediaInfo(int mediaId) {
		return getSqlSession().selectOne("media.selectMediaInfo", mediaId);
	}
	
	public List<MediaShotVo> selectShotMediaActivity(int mediaId) {
		return getSqlSession().selectList("media.selectMediaActivity", mediaId);
	}
	
	
	public List<MediaTagDescVo> selectMediaTagDesc(int mediaId) {
		return getSqlSession().selectList("media.selectMediaTagDesc", mediaId);
	}
	
	public List<MediaCategoryVo> selectCategoryInfo(){
		return getSqlSession().selectList("media.selectCategoryInfo");
	}
	
	public int getShotId(int mediaId) {
		return getSqlSession().selectOne("media.getMediaShotId", mediaId);
	}

	public int insertMediaShot(MediaShotVo vo)  throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().insert("media.insertMediaShot", vo);
	}
	
	public int insertMediaActivity(MediaShotVo vo) throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().insert("media.insertMediaActivity", vo);
	}

	public int deleteMedia(int mediaId) throws Exception {
		return getSqlSession().delete("media.deleteMedia", mediaId);
	}
	
	public int deleteMediaShot(MediaShotVo vo)  throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().delete("media.deleteMediaShot", vo);
	}

	public int updateMediaTagDesc(MediaTagDescVo vo)  throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().update("media.updateMediaTagDesc", vo);
	}

	public int insertMediaTagDesc(MediaTagDescVo vo)  throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().insert("media.insertMediaTagDesc", vo);
	}

	public int updateMediaActivity(MediaShotVo vo) throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().update("media.updateMediaActivity", vo);
	}

	public int updateMediaShotThumb(MediaShotVo shotVo) throws Exception {
		// TODO Auto-generated method stub
		return getSqlSession().update("media.updateMediaShotThumb", shotVo);
	}
}
