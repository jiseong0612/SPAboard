package com.pmg.service;

import com.pmg.domain.UsersVO;

public interface UserService {
	public int create(UsersVO user);

	public int logIn(UsersVO user);

	public UsersVO getUserInfo(String id);

	public int idDupChk(String id);
}
