package com.pmg.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum=1;	//페이지 번호
	private int amount=10;	//페이지당 데이터 갯수
	private Long bno;

	public Criteria() {
		this.pageNum = 1;
		this.amount = 10;
	}

	public Criteria(int pageNum, int amount, long bno) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.bno = bno;
	}

}
