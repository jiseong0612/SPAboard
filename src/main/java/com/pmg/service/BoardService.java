package com.pmg.service;

import java.util.List;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;

public interface BoardService {
	public BoardVO read(Long bno);

	public int write(BoardVO board);

	public int update(BoardVO board);

	public int delete(Long bno);

	public List<BoardVO> getList();

	public void viewUp(Long bno);
	
	public List<BoardVO> listPage(Criteria cri);
	
	public int listCount();
}
