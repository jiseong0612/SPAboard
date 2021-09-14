package com.pmg.domain;

import lombok.Data;

@Data
public class Criteria {
	private int pageNum = 1; // 페이지 번호
	private int amount = 10; // 페이지당 데이터 갯수
	private String type; // t, tc, tcw, cw
	private String keyword;
	private String id;
	private String mycontentCB;
	private String sorting;
	
	
	
	public Criteria() {
		this(1, 10);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}

	public String[] getTypeArr() {
		return type == null ? new String[] {} : type.split(""); // P3 ch15 p339 검색에 동적쿼리적용 3:45
	}
	
}
