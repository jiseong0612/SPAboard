package com.pmg.domain;

import java.util.Date;

import lombok.Data;
@Data
public class BoardVO {
	private Long bno;
	private String	id;
	private String title;
	private String content;
	private Long views;
	private Date regdate;
	private Date updateDate;
}
