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
	
	@GetMapping("/myContentCB")
	public String myContentCB(HttpServletRequest request, Criteria cri) {
		HttpSession session = request.getSession();
		//아이디 세션의 아이디값을 가져온다.
		String id= (String)session.getAttribute("id");
		//mycontentCB 세션에 유저 아이디 세션 값을 넣어준다.
		session.setAttribute("myContentSession", id);
		String myContentSession= (String)session.getAttribute("myContentSession");
		cri.setMyContentCB(myContentSession);
		System.out.println("세션값 출력..................."+(String)session.getAttribute("myContentSession"));
		log.info("[myContentCB]"+cri);
		return "redirect:/board/spaList";
	}
	@GetMapping("/sessionRemove")
	public String sessionRemove(HttpSession session, Criteria cri) {
		log.info("sessionRemove GET..................");
		
		String myContentSession= (String)session.getAttribute("myContentSession");
		System.out.println("삭제될 myContentSession 세션 ...."+ myContentSession);
		session.removeAttribute("myContentSession");
		log.info("[sessionRemove Get]"+cri);
		return "redirect:/board/spaList";
	}
	
	@GetMapping("/spaList")
	public String list(HttpSession session, @ModelAttribute("cri") Criteria cri, Model model) {
		String myContentSession= (String)session.getAttribute("myContentSession");
		cri.setMyContentCB(myContentSession);
		/* List<BoardVO> list = service.getListWithPaging(cri); */
		model.addAttribute("list", service.getListWithPaging(cri));
		model.addAttribute("bno", service.getTotal(cri));
		model.addAttribute("pageMaker", new pageDTO(cri, service.getTotal(cri)));
		log.info("[spaListGET]" + cri);
		return "/items/spaList";
	}

	// 스프링 시큐리티
	// 로그인페이지 .로그인 성공페이지 로그인 실패 페이지 기존 페이지. 총 jsp가 4개가 된다.
	// 이게 되면 하나로 합쳐라.
	@GetMapping("/spaRead")
	public String spaRead(long bno, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("[spaReadGET]" + cri);
		service.viewUp(bno);
		model.addAttribute("board", service.read(bno));

		BoardVO before = service.read(bno - 1); // 이전글
		System.out.println("[spaReadGET] before :" + before);

		BoardVO after = service.read(bno + 1); // 다음글
		System.out.println("[spaReadGET] after :" + after);

		model.addAttribute("before", before);
		model.addAttribute("after", after);
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
		log.info("[spaModifyGET]" + cri);
		model.addAttribute("board", service.read(bno));
		return "/items/spaModify";
	}

	@PostMapping("/spaModify")
	@ResponseBody
	public String modify(BoardVO board, Criteria cri, Model model) {
		log.info("[spaModify]" + cri);
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
