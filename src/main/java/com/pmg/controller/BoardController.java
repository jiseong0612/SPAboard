package com.pmg.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;
import com.pmg.domain.PageMaker;
import com.pmg.service.BoardService;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board")
@Log4j
public class BoardController {
	@Autowired
	private BoardService service;

	@GetMapping("/spaRead")
	public void spaRead(Model model, Criteria cri) {
		log.info("spaRead GetMapping.....................");
		BoardVO board = service.read(cri.getBno());
		service.viewUp(cri.getBno());
		model.addAttribute("board", board);
		model.addAttribute("cri", cri);
	}

	@GetMapping("/spaModify")
	public void spaModify(Model model, Criteria cri) {
		log.info("spaModify GetMapping.....................");
		BoardVO board = service.read(cri.getBno());
		model.addAttribute("board", board);
		model.addAttribute("cri", cri);
	}

	@PostMapping("/spaModify")
	@ResponseBody
	public int spaModify(BoardVO board, Criteria cri, Model model) {
		log.info("spaModify PostMapping.....................");
		int result = service.update(board);
		model.addAttribute("cir", cri);
		return result;
	}

	@PostMapping("/spaDelete")
	@ResponseBody
	public int spaDelete(long bno) {
		log.info("spaDelete PostMapping.....................");
		int result = service.delete(bno);
		return result;
	}

	@GetMapping("/spaList")
	public void spaList(Criteria cri, Model model) {
		log.info("spaList GetMapping.....................");
		List<BoardVO> list = service.listPage(cri);
		int total = service.listCount();
		model.addAttribute("list", list);
		model.addAttribute("paging", new PageMaker(cri, total));
	}

	@GetMapping("/spaWrite")
	public void spaWrite() {
		log.info("spaWrite GetMapping.....................");
	}

	@PostMapping("/spaWrite")
	@ResponseBody
	public String spaWrite(BoardVO board, String boardId) {
		log.info("spaWrite PostMapping.....................");
		board.setId(boardId);
		service.write(board);
		return "redirect:/board/spaList";
	}
}
