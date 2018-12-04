package com.nhn.gan.common.controller;

import java.security.Principal;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nhn.gan.domain.UserVo;
import com.nhn.gan.modules.user.service.UserService;

@Controller
public class MainController {

	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	@Autowired
	public UserService userService;

	@RequestMapping(value = "/login/loginForm.do", method = RequestMethod.GET)
	public String loginForm(String result, HttpSession session, Model model) {
		if (session.getAttribute("userLoginInfo") != null) {
			return "redirect:/statistics/text/list.do";
		}
		model.addAttribute("result", result);
		return "login/login";
	}

	@RequestMapping(value = "/login/login.do", method = RequestMethod.GET)
	public void login(HttpSession session) {
		logger.info("Welcome login! {}", session.getId());
	}

	@RequestMapping(value = "/login/logout.do", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login/loginForm.do";
	}

	@RequestMapping(value = "/login/login_success.do", method = RequestMethod.GET)
	public String login_success(Principal principal, HttpSession session) {
		UserVo vo = userService.selectUser(principal.getName());
		String chkInfo = vo.getUserId() + "__" + session.getId();
		session.setAttribute("uploadSessionChk", chkInfo);
		session.setAttribute("userLoginInfo", vo);
		return "redirect:/statistics/text/list.do";
	}

	@RequestMapping(value = "/login/login_duplicate.do", method = RequestMethod.GET)
	public void login_duplicate() {

	}

}
