package com.pmg.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		System.out.println("spaList 컨트롤러왔단");
		System.out.println(cri);
		model.addAttribute("list", service.getListWithPaging(cri)); // 이것도 크리테리아
		model.addAttribute("pageMaker", new pageDTO(cri, service.getTotal(cri)));// 이것도 크리테리아면 만약 30개씩 출력한다 했을때 어떤 모델을
		return "/items/spaList";
	}

	@GetMapping("/spaRead")
	public String spaRead(long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("spaRead.....................");
		System.out.println("cri .........." + cri);
		service.viewUp(bno);
		model.addAttribute("board", service.read(bno));
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
		model.addAttribute("board", service.read(bno));
		return "/items/spaModify";
	}

	@PostMapping("/spaModify")
	@ResponseBody
	public String modify(BoardVO board, Criteria cri, Model model) {
	if(service.update(board)==1) {
		model.addAttribute("pageNum", cri.getPageNum());
		model.addAttribute("amount", cri.getAmount());
		return "/board/spaList";
	}else {
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
