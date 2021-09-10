package com.pmg.domain;

import java.util.Date;

import lombok.Data;
@Data
public class UsersVO {
	private String  id;
	private String  passwd;
	private Date  signdate;
	private String  phnum;
	private String  email;
	
}
