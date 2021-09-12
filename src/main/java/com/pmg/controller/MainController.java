package com.pmg.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class MainController {
	@GetMapping("/")
	public String spaList() {
		log.info("spaList GetMapping.....................");
		return "/common/mainCase";
	}
}
