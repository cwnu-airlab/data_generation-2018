package com.nhn.gan.modules.media.web;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.nhn.gan.domain.MediaVo;

@Controller
public class MediaController {

	@RequestMapping(value = "/media/mediaList.do")
	public String mediaList(@ModelAttribute("mediaVo") MediaVo vo) {
		return "media/mediaList";
	}

	@RequestMapping(value = "/media/mediaRegist.do")
	public String mediaRegist(@ModelAttribute("mediaVo") MediaVo vo) {
		return "media/mediaRegist";
	}

	@RequestMapping(value = "/media/upload.do", method = { RequestMethod.POST })
	public ResponseEntity<String> upload(MediaVo vo) {
		MultipartFile[] mp = vo.getFile();
		
		
		ResponseEntity<String> resEnt = new ResponseEntity<>("Success",HttpStatus.OK);
		return resEnt;
	}

	@RequestMapping(value = "/media/mediaEdit.do")
	public String mediaEdit(@ModelAttribute("mediaVo") MediaVo vo) {
		return "media/mediaEdit";
	}

	@RequestMapping(value = "/media/mediaView.do")
	public String mediaView(@ModelAttribute("mediaVo") MediaVo vo) {
		return "media/mediaView";
	}
}
