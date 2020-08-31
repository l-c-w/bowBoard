package com.javalec.ex.Dto;

public class SearchingDto {
	
	//현재페이지
	private int cur_page = 1;
	//검색분류
	private String sort;
	//검색어
	private String keyword;
	
	
	//날짜 검색용 추가
	private String end_date;
	
	//엑셀 다운용 추가
	private String excel_type;
	
	
	
	public int getCur_page() {
		return cur_page;
	}
	public void setCur_page(int cur_page) {
		this.cur_page = cur_page;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getExcel_type() {
		return excel_type;
	}
	public void setExcel_type(String excel_type) {
		this.excel_type = excel_type;
	}
	
	
	
	
}
