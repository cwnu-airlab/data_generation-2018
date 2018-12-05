package com.nhn.gan.modules.media.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.nhn.gan.common.utils.PaginationMedia;
import com.nhn.gan.domain.MediaCategoryVo;
import com.nhn.gan.domain.MediaShotVo;
import com.nhn.gan.domain.MediaTagDescVo;
import com.nhn.gan.domain.MediaVo;
import com.nhn.gan.modules.media.service.MediaService;

@Controller
public class MediaController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MediaService mediaService;

	@RequestMapping(value = "/media/mediaList.do")
	public String mediaList(HttpServletRequest request, @ModelAttribute("mediaVo") MediaVo vo, Model model) {

		if (vo.getSearchTermOpt() == null) {
			vo.setSearchTermOpt("ALL");
		}

		if (vo.getPageNo() <= 1) {
			vo.setPageNo(1);
		}
		int count = mediaService.selectMediaInfoCount(vo);
		List<MediaVo> results = mediaService.selectMediaInfoList(vo);
		model.addAttribute("pagination", new PaginationMedia(request, count));
		model.addAttribute("results", results);
		model.addAttribute("count", count);
		return "media/mediaList";
	}

	@RequestMapping(value = "/media/mediaRegist.do")
	public String mediaRegist(@ModelAttribute("mediaVo") MediaVo vo) {
		return "media/mediaRegist";
	}

	@RequestMapping(value = "/media/uploadChk.do", method = { RequestMethod.GET })
	public ResponseEntity<String> fileUploadChk(HttpSession session, MediaVo vo) {
		HttpHeaders resHeaders = new HttpHeaders();
		resHeaders.add("Content-Type", "text/plain;charset=UTF-8");
		String chkInfo = String.valueOf(session.getAttribute("uploadSessionChk"));
		String res = String.valueOf(
				session.getAttribute(chkInfo) == null ? "미디어 업로드 및 등록작업 준비중입니다." : session.getAttribute(chkInfo));
		ResponseEntity<String> resEnt = new ResponseEntity<>(res, resHeaders, HttpStatus.OK);
		return resEnt;
	}

	@RequestMapping(value = "/media/upload.do", method = { RequestMethod.POST })
	public ResponseEntity<String> upload(HttpSession session, MediaVo vo) throws Exception {
		HttpHeaders resHeaders = new HttpHeaders();
		resHeaders.add("Content-Type", "text/plain;charset=UTF-8");
		MultipartFile[] mp = vo.getFile();
		boolean res = false;
		String chkInfo = String.valueOf(session.getAttribute("uploadSessionChk"));
		try {
			String userId = vo.getUserId();
			res = mediaService.registMediaFile(mp, userId, chkInfo, session);
			ResponseEntity<String> resEnt = new ResponseEntity<>(String.valueOf(res), resHeaders, HttpStatus.OK);
			return resEnt;
		} catch (Exception e) {
			session.removeAttribute(chkInfo);
			throw e;
		}
	}

	@RequestMapping(value = "/media/mediaEdit.do")
	public String mediaEdit(@ModelAttribute("mediaVo") MediaVo vo, Model model) {
		List<MediaCategoryVo> categoryInfo = mediaService.selectCategoryInfo();
		MediaVo res = mediaService.getMediaInfo(vo.getMediaId());
		model.addAttribute("mediaInfo", res);
		model.addAttribute("categoryInfo", categoryInfo);
		return "media/mediaEdit";
	}

	@RequestMapping(value = "/media/mediaDelete.do")
	public ModelAndView mediaDelete(@ModelAttribute("mediaVo") MediaVo vo, ModelAndView model) throws Exception {
		model.setViewName("jsonView");
		try {
			int res = mediaService.deleteMedia(vo);
			model.addObject("deleteRes", res);
		} catch (Exception e) {
			throw e;
		}
		return model;
	}

	@RequestMapping(value = "/media/mediaView.do")
	public String mediaView(@ModelAttribute("mediaVo") MediaVo vo, Model model) {
		List<MediaCategoryVo> categoryInfo = mediaService.selectCategoryInfo();
		MediaVo res = mediaService.getMediaInfo(vo.getMediaId());
		model.addAttribute("mediaInfo", res);
		model.addAttribute("categoryInfo", categoryInfo);
		return "media/mediaView";
	}

	@RequestMapping(value = "/media/updateCategory.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView updateCategory(@ModelAttribute("mediaCategoryVo") MediaCategoryVo vo, ModelAndView model)
			throws Exception {
		model.setViewName("jsonView");

		int result = 0;
		if (vo.getCatId() > 0) {
			try {
				result = mediaService.updateMediaCategory(vo);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				throw e;
			}
		} else {
			try {
				mediaService.insertMediaCategory(vo);
				result = mediaService.updateMediaCategory(vo);
			} catch (Exception e) {
				logger.error(e.getMessage(), e);
				throw e;
			}
		}

		if (result > 0) {
			model.addObject("mediaInfo", result);
		}

		return model;
	}

	@RequestMapping(value = "/media/makeShot.do", produces = MediaType.TEXT_HTML_VALUE)
	public String makeShot(@ModelAttribute("mediaShotVo") MediaShotVo vo, Model model) throws Exception {
		MediaShotVo insertResultInfo = mediaService.insertMediaShot(vo);
		MediaVo mediaInfo = mediaService.getMediaInfo(vo.getMediaId());
		model.addAttribute("shotInfo", insertResultInfo);
		model.addAttribute("mediaInfo", mediaInfo);
		return "media/mediaShotEdit";
	}

	@RequestMapping(value = "/media/deleteShot.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView deleteShot(@ModelAttribute("mediaShotVo") MediaShotVo vo, ModelAndView model) throws Exception {
		int res = mediaService.deleteMediaShot(vo);
		model.addObject("deleteRes", res);
		model.setViewName("jsonView");
		return model;
	}

	@RequestMapping(value = "/media/editActivity.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ModelAndView editActivity(int mediaId, int shotId, String editField, int tagId, String tagName, String tagValue,
			ModelAndView model) throws Exception {
		MediaShotVo vo = new MediaShotVo();
		vo.setMediaId(mediaId);
		vo.setShotId(shotId);
		vo.setEditField(editField);
		if ("TITLE".equals(editField.trim())) {
			vo.setTitle(tagValue);
			mediaService.updateActivity(vo);
		} else {
			MediaTagDescVo tagVo = new MediaTagDescVo();
			tagVo.setMediaId(mediaId);
			tagVo.setShotId(shotId);
			boolean insertTag = false;
			if (tagId == 0) {
				insertTag = true;
			} else {
				tagVo.setTagId(tagId);
			}
			tagVo.setTagName(tagName);
			tagVo.setDescription(tagValue);
			mediaService.editMediaTag(tagVo);
			model.addObject("tagInfo", tagVo);
			if (insertTag) {
				if ("WHO".equals(editField.trim())) {
					vo.setWho(tagVo.getTagId());
				} else if ("WHAT_BEHAVIOR".equals(editField.trim())) {
					vo.setWhatBehavior(tagVo.getTagId());
				} else if ("WHAT_OBJECT".equals(editField.trim())) {
					vo.setWhatObject(tagVo.getTagId());
				} else if ("WHERE".equals(editField.trim())) {
					vo.setWhere(tagVo.getTagId());
				} else if ("WHEN".equals(editField.trim())) {
					vo.setWhen(tagVo.getTagId());
				} else if ("WHY".equals(editField.trim())) {
					vo.setWhy(tagVo.getTagId());
				} else if ("HOW".equals(editField.trim())) {
					vo.setHow(tagVo.getTagId());
				}
				mediaService.updateActivity(vo);
			}
		}
		model.setViewName("jsonView");
		return model;
	}
}
