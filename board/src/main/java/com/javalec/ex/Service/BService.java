package com.javalec.ex.Service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
import com.javalec.ex.Dto.SearchingDto;

public interface BService {
	
	//글 리스트 가져요기
	public List<BDto> b_list(SearchingDto searchingDto) throws Exception;
	
	//글 페이징요소
	public PagingDto b_paging(SearchingDto searchingDto) throws Exception;
	
	//글 한개 보기
	public BDto b_view(HttpServletRequest request) throws Exception;
	
	//글쓰기
	public int b_wirte(BDto bDto,HttpSession session) throws Exception;
	
	//비밀번호 확인
	public int pw_ok(BDto bDto)throws Exception;
	
	//글수정
	public int b_update(BDto bDto)throws Exception;
	
	//글삭제
	public int b_delete(HttpServletRequest request)throws Exception;

}
