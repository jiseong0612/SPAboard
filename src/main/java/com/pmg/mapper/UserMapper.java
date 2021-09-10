package com.pmg.mapper;

import com.pmg.domain.UsersVO;

public interface UserMapper {
	public String getTime();

	public int create(UsersVO user);

	public UsersVO logIn(UsersVO user);

	public UsersVO getUserInfo(String id);

	public int idDupChk(String id);
}
