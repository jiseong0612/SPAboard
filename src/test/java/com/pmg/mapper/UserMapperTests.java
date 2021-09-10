package com.pmg.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.pmg.domain.UsersVO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class UserMapperTests {
	@Autowired
	private UserMapper mapper;
	
	@Test
	public void idDupTest() {
		String id = "qt";
		int result = mapper.idDupChk(id);
		log.info("idDup reulst.............."+result);
	}
	@Test
	public void getTime() {
		log.info(mapper.getTime());
	}

	@Test
	public void createTest() {
		UsersVO user = new UsersVO();
		user.setId("hanji");
		user.setPasswd("wldms1wltjd@");
		user.setPhnum("010-3346-5713");
		user.setEmail("ddddd@gmail.com");
		int result = mapper.create(user);
		log.info("회원가입 성공유뮤 : " + result);
	}

	@Test
	public void logInTest() {
		int result = 0;
		UsersVO user = new UsersVO();
		user.setId("user00");
		user.setPasswd("12344");
		mapper.logIn(user);
	}
}
