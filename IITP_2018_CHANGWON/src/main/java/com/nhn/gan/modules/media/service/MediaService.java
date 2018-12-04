package com.nhn.gan.modules.media.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.web.multipart.MultipartFile;

import com.nhn.gan.domain.MediaCategoryVo;
import com.nhn.gan.domain.MediaShotVo;
import com.nhn.gan.domain.MediaTagDescVo;
import com.nhn.gan.domain.MediaVo;

public interface MediaService {
	int getMediaId();

	boolean registMediaFile(MultipartFile[] mfs, String userId, String chkInfo, HttpSession session) throws Exception;

	List<MediaVo> selectMediaInfoList(MediaVo vo);

	int selectMediaInfoCount(MediaVo vo);

	public MediaVo getMediaInfo(int mediaId);

	List<MediaCategoryVo> selectCategoryInfo();

	public int insertMediaCategory(MediaCategoryVo vo) throws Exception;

	public int updateMediaCategory(MediaCategoryVo vo) throws Exception;

	public int getShotId(int mediaId);

	public MediaShotVo insertMediaShot(MediaShotVo vo) throws Exception;

	int deleteMediaShot(MediaShotVo vo) throws Exception;

	int editMediaTag(MediaTagDescVo vo) throws Exception;

	int updateActivity(MediaShotVo vo) throws Exception;

	int deleteMedia(MediaVo vo) throws Exception;
}
