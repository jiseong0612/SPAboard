package com.pmg.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pmg.domain.UsersVO;
import com.pmg.mapper.UserMapper;

@Service
public class UserService{
	@Autowired
	private UserMapper mapper;

	public int create(UsersVO user) {
		int result = mapper.create(user);
		if (result != 1) {
			result = 0;
		}
		return result;
	}

	public int logIn(UsersVO user) {
		int result = 0;
		UsersVO old = new UsersVO();
		old = mapper.logIn(user);
		if (old.getId().equals(user.getId())) {
			if (old.getPasswd().equals(user.getPasswd())) {
				result = 1; // 로그인성공
			}else {
				result =-1; //로그인 실패
			}
		}
		return result;

	}

	public UsersVO getUserInfo(String id) {
		return mapper.getUserInfo(id);
	}

	public int idDupChk(String id) {
		return mapper.idDupChk(id);
	}
}
