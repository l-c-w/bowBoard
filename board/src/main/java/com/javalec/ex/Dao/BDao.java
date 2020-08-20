package com.javalec.ex.Dao;

import java.util.ArrayList;
import java.util.List;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
import com.javalec.ex.Dto.SearchingDto;

public interface BDao {

	//글 리스트 가져오기
	public List<BDto> b_list(SearchingDto searchingDto) throws Exception;
	
	//리스트 페이징
	public PagingDto b_paging(SearchingDto searchingDto)throws Exception;
	
	//글 상세보기
	public BDto b_view(int b_num) throws Exception;
	
	//글쓰기
	public int b_write(BDto bDto) throws Exception;
	
	//답변작성
	public int b_reply(BDto bDto)throws Exception;
	
	//등록 전 요소 업데이트
	public int stepup(BDto bDto)throws Exception;
	
	//비밀번호 찾기
	public int pw_ok(BDto bDto)throws Exception;
	
	//글수정
	public int b_update(BDto bDto)throws Exception;
	
	//글삭제
	public int b_delete(int b_num)throws Exception;
	
	//답변이 달려있는 글 삭제
	public int r_delete(int b_num)throws Exception;
	
	//답변 달려있는 글인지 확인
	public int r_check(BDto bDto)throws Exception;
}
