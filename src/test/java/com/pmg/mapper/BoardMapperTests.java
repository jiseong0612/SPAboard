package com.pmg.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pmg.domain.BoardVO;
import com.pmg.domain.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
	@Autowired
	private BoardMapper mapper;
	
	@Test
	public void listCountTest() {
		mapper.listCount();
	}
	
	@Test
	public void listPagingTest() {
		Criteria cri = new  Criteria();
		cri.setId("user00");
		List<BoardVO> list = mapper.getListWithPaging(cri);
		log.info(list);
	}
	@Test
	public void readTest() {
		Long bno = 234L;
		log.info(mapper.read(bno));
	}
	@Test
	public void getBoardListTest() {
		mapper.getList();
	}

	@Test
	public void writeTest() {
		BoardVO board = new BoardVO();
		board.setId("user00");
		board.setTitle("wldms1wltjd@");
		board.setContent("010-3346-5713");
		mapper.write(board);
	}

	@Test
	public void updateTest() {
		BoardVO board = new BoardVO();
		board.setTitle("update업데이트제목");
		board.setContent("update콘텐츠");
		board.setBno(208L);
		mapper.update(board);
		log.info(mapper.update(board));
	}
	
	@Test
	public void deleteTest() {
		Long bno = 208L;
		log.info(mapper.delete(bno));
	}
}
