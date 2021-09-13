package com.pmg.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;
import com.pmg.domain.pageDTO;
import com.pmg.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	@Autowired
	private BoardService service;
	
	@GetMapping("/spaList")
	public String list(Criteria cri, Model model) {
		log.info("[spaListGET]"+cri);
		model.addAttribute("list", service.getListWithPaging(cri)); // 이것도 크리테리아
		model.addAttribute("pageMaker", new pageDTO(cri, service.getTotal(cri)));// 이것도 크리테리아면 만약 30개씩 출력한다 했을때 어떤 모델을
		return "/items/spaList";
	}
	//스프링 시큐리티
	//로그인페이지 .로그인 성공페이지 로그인 실패 페이지 기존 페이지. 총 jsp가 4개가 된다.
	//이게 되면 하나로 합쳐라.
	@GetMapping("/spaRead")
	public String spaRead(long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("[spaReadGET]"+cri);
		service.viewUp(bno);
		model.addAttribute("board", service.read(bno));
		System.out.println("여기찍혀야됨......................................................."+cri.getId());
		BoardVO before = service.read(bno-1);
		System.out.println("[spaReadGET]"+before);
		BoardVO after = service.read(bno+1);
		System.out.println("[spaReadGET]"+after);
		model.addAttribute("before",before);
		model.addAttribute("after",after);
		return "/items/spaRead";
	}

	@GetMapping("/spaWrite")
	public String spaWrite() {
		return "/items/spaWrite";
	}

	@PostMapping("/spaWrite")
	@ResponseBody
	public String spaWrite(BoardVO board) {
		long bno = service.write(board);
		return "redirect:/board/list";
	}

	@GetMapping("/spaModify")
	public String spaModify(long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("[spaModifyGET]"+cri);
		model.addAttribute("board", service.read(bno));
		return "/items/spaModify";
	}

	@PostMapping("/spaModify")
	@ResponseBody
	public String modify(BoardVO board, Criteria cri, Model model) {
		log.info("[spaModify]"+cri);
		if (service.update(board) == 1) {
			model.addAttribute("pageNum", cri.getPageNum());
			model.addAttribute("amount", cri.getAmount());
			return "/board/spaList";
		} else {
			return "0";
		}
	}

	@PostMapping("/spaRemove")
	@ResponseBody
	public String remove(Long bno) {
		if (service.delete(bno) == 1) {
			return "1";
		} else {
			return "0";
		}
	}
}
