package com.pmg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;
import com.pmg.mapper.BoardMapper;

import jdk.internal.org.jline.utils.Log;
import lombok.extern.log4j.Log4j;
@Service
public class BoardService{

	@Autowired
	private BoardMapper mapper;

	public BoardVO read(Long bno) {
		BoardVO board = mapper.read(bno);
		return board;
	}

	public int write(BoardVO board) {
		int result = mapper.write(board);
		return result;
	}

	public int update(BoardVO board) {
		System.out.println("BoardServiceImpl........."+board);
		int result = mapper.update(board);
		return result;
	}

	public int delete(Long bno) {
		int result = mapper.delete(bno);
		return result;
	}

	public List<BoardVO> getList() {
		List<BoardVO> list = mapper.getList();
		return list;
	}

	public void viewUp(Long bno) {
		mapper.viewUp(bno);
	}

	public List<BoardVO> getListWithPaging(Criteria cri) {
		return mapper.getListWithPaging(cri);
	}

	public int listCount() {
		return mapper.listCount();
	}
	
	public int getTotal(Criteria cri) {
		return mapper.getTotal(cri);
	}

	public List<BoardVO> getListWithSortingPaging(Criteria cri) {
		return mapper.getListWithSortingPaging(cri);
	}

}
