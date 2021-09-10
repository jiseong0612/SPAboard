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

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	private BoardService service;

	@GetMapping("/spaRead")
	public void spaRead(Model model, Criteria cri) {
		BoardVO board = service.read(cri.getBno());
		service.viewUp(cri.getBno());
		model.addAttribute("board", board);
		model.addAttribute("cri", cri);
	}

	@GetMapping("/spaModify")
	public void spaModify(Model model, Criteria cri) {
		BoardVO board = service.read(cri.getBno());
		model.addAttribute("board", board);
		model.addAttribute("cri", cri);
	}

	@PostMapping("/spaModify")
	@ResponseBody
	public int spaModify(BoardVO board, Criteria cri, Model model) {
		int result = service.update(board);
		model.addAttribute("cir", cri);
		return result;
	}

	@PostMapping("/spaDelete")
	@ResponseBody
	public int spaDelete(long bno) {
		int result = service.delete(bno);
		return result;
	}

	@GetMapping("/spaList")
	public void spaList(Criteria cri, Model model) {
		List<BoardVO> list = service.listPage(cri);
		int total = service.listCount();
		model.addAttribute("list", list);
		model.addAttribute("paging", new PageMaker(cri, total));
	}

	@GetMapping("/spaWrite")
	public void spaWrite() {
	}

	@PostMapping("/spaWrite")
	@ResponseBody
	public String spaWrite(BoardVO board, String boardId) {
		board.setId(boardId);
		service.write(board);
		return "redirect:/board/spaList";
	}
}
