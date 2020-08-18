package com.javalec.ex.Dto;

public class PagingDto {
	
	//한 페이지 게시글 수
	private int page_size;
	//페이지 블럭에 노출될 페이지 수
	private int range_size;
	
	//현재 페이지 위치
	private int cur_page;
	//현재 페이지 블럭 위치
	private int cur_range;
	
	//총 게시글 수
	private int list_count;
	//총 페이지 수
	private int page_count;
	//총 페이지 블럭 수
	private int range_count;
	
	//현재 블럭 시작페이지
	private int start_page;
	//현재 블럭 끝 페이지
	private int end_page;
	
	//이전페이지 버튼 노출
	private boolean prev_page;
	//다음페이지 버튼 노출
	private boolean next_page;
	

	public int getPage_size() {
		return page_size;
	}

	public void setPage_size(int page_size) {
		this.page_size = page_size;
	}

	public int getRange_size() {
		return range_size;
	}

	public void setRange_size(int range_size) {
		this.range_size = range_size;
	}

	public int getCur_page() {
		return cur_page;
	}

	public void setCur_page(int cur_page) {
			this.cur_page = cur_page;			
	}

	public int getCur_range() {
		return cur_range;
	}

	public void setCur_range(int cur_page) {
		if(cur_page%getRange_size()==0) {
			this.cur_range = cur_page/getRange_size();
		}else {
			this.cur_range = cur_page/getRange_size()+1;
		}
	}

	public int getList_count() {
		return list_count;
	}

	public void setList_count(int list_count) {
		this.list_count = list_count;
	}

	public int getPage_count() {
		return page_count;
	}

	public void setPage_count(int list_count) {
		if(list_count%getPage_size()==0) {
			this.page_count = list_count/getPage_size();
		}else {
			this.page_count = list_count/getPage_size()+1;			
		}
	}

	public int getRange_count() {
		return range_count;
	}

	public void setRange_count(int page_count) {
		if(page_count%getRange_size()==0) {
			this.range_count = page_count/getRange_size();
		}else {
			this.range_count = page_count/getRange_size()+1;
		}
	}

	public int getStart_page() {
		return start_page;
	}

	public void setStart_page(int cur_range,int range_size) {
		this.start_page = ((cur_range-1)*range_size)+1;
	}

	public int getEnd_page() {
		return end_page;
	}

	public void setEnd_page(int cur_range,int range_count) {
		if(cur_range==range_count) {
			this.end_page = getPage_count();		
		}else {
			this.end_page=cur_range*getRange_size();
		}
	}

	public boolean isPrev_page() {
		return prev_page;
	}

	public void setPrev_page(boolean prev_page) {
		this.prev_page = prev_page;
	}

	public boolean isNext_page() {
		return next_page;
	}

	public void setNext_page(boolean next_page) {
		this.next_page = next_page;
	}
	
	// 이전 페이지, 다음 페이지 버튼 노출
		public void prevnext(int curPage) {
			if (getRange_count() == 1) {
				setPrev_page(false);
				setNext_page(false);
			} else if (getRange_count() > 1 && curPage < (getRange_size()+1)) {
				setPrev_page(false);
				setNext_page(true);
			} else if (getRange_count() * getRange_size() - getRange_size()< curPage) {
				setPrev_page(true);
				setNext_page(false);
			} else {
				setPrev_page(true);
				setNext_page(true);
			}
		}
}
