package com.pmg.mapper;

import java.util.List;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;

public interface BoardMapper {
	
	public BoardVO read(Long bno);

	public List<BoardVO> getList();

	public int write(BoardVO board);

	public int update(BoardVO board);

	public int delete(Long bno);

	public void viewUp(Long bno);

	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public int listCount();

	public int getTotal(Criteria cri);
	
}
