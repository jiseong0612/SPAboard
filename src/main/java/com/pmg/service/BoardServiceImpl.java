package com.pmg.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;
import com.pmg.mapper.BoardMapper;
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;

	@Override
	public BoardVO read(Long bno) {
		BoardVO board = mapper.read(bno);
		return board;
	}

	@Override
	public int write(BoardVO board) {
		int result = mapper.write(board);
		return result;
	}

	@Override
	public int update(BoardVO board) {
		System.out.println("BoardServiceImpl........."+board);
		int result = mapper.update(board);
		return result;
	}

	@Override
	public int delete(Long bno) {
		int result = mapper.delete(bno);
		return result;
	}

	@Override
	public List<BoardVO> getList() {
		List<BoardVO> list = mapper.getList();
		return list;
	}

	@Override
	public void viewUp(Long bno) {
		mapper.viewUp(bno);
	}

	@Override
	public List<BoardVO> listPage(Criteria cri) {
		return mapper.listPage(cri);
	}

	@Override
	public int listCount() {
		return mapper.listCount();
	}


}
