package com.javalec.ex.Dto;

public class SearchingDto {
	
	//현재페이지
	private int cur_page = 1;
	//검색분류
	private String sort;
	//검색어
	private String keyword;
	
	
	
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
	
	
}
