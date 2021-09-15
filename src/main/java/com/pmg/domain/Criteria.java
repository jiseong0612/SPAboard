package com.pmg.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;

@Data
@Log4j
public class Criteria {
	private int pageNum = 1; // 페이지 번호
	private int amount = 10; // 페이지당 데이터 갯수
	private String type; // t, tc, tcw, cw
	private String keyword;
	private String myContentCB;
	private String sorting;
	private String id;
	
	
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
	
	public String getMyContentCB() {
		log.info("this.myContentCB 값....................?"+this.myContentCB);
		String myContentCB = this.myContentCB;
		System.out.println("this.myContentCBmyContentCBmyContentCBmyContentCB 값....................?"+myContentCB);
		return myContentCB;
	}
	
}
