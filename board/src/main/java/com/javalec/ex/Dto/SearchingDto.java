package com.javalec.ex.Dto;

public class SearchingDto {
	
	//현재페이지
	private int curpage = 1;
	//검색분류
	private String sort;
	//검색어
	private String keyword;
	
	
	public int getCurpage() {
		return curpage;
	}
	public void setCurpage(int curpage) {
		this.curpage = curpage;
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
