package com.pmg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pmg.domain.UsersVO;
import com.pmg.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService service;

	@GetMapping("/")
	public String mainCase() {
		log.info("mainCase GetMapping.....................");
		return "/common/mainCase";
	}

	@GetMapping("/signUp")
	public String signUp() {
		log.info("signUp GetMapping.....................");
		return "items/signUp";
	}

	@PostMapping("/signUp")
	@ResponseBody
	public int signUp(UsersVO user, Model model) {
		log.info("signUp PostMapping.....................");
		int result = service.create(user);
		model.addAttribute("result", result);
		return result;
	}

	@PostMapping("/idDup")
	@ResponseBody
	public int idDup(String id) {
		log.info("idDup PostMapping.....................");
		int result = service.idDupChk(id);
		return result;
	}

	@GetMapping("/logIn")
	public String logIn() {
		log.info("logIn GetMapping.....................");
		return "items/logIn";
	}

	@PostMapping("/logIn")
	@ResponseBody
	public int logIn(String lgId, String lgPasswd, Model model, HttpServletRequest request) {
		log.info("logIn PostMapping.....................");
		HttpSession session = request.getSession();
		UsersVO user = new UsersVO();
		user.setId(lgId);
		user.setPasswd(lgPasswd);
		int result = service.logIn(user);
		if (result == 1) {
			session.setAttribute("id", user.getId());
		} else {
			log.info("로그인 실패?" + result);
		}
		return result;
	}

	@GetMapping("/logOut")
	public String logOut(HttpSession session) {
		log.info("logOut GetMapping.....................");
		session.invalidate();
		return "redirect:/board/spaList";

	}

}
