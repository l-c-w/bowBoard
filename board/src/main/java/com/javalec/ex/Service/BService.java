package com.javalec.ex.Service;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.javalec.ex.Dto.BDto;

public interface BService {
	
	//글 리스트 가져오기
	public List<BDto> b_list() throws Exception;
	
	//글 한개 보기
	public BDto b_view(HttpServletRequest request) throws Exception;
	
	//글쓰기
	public int b_wirte(BDto bDto) throws Exception;
	
	//글수정
	public int b_update(BDto bDto)throws Exception;
	
	//글삭제
	public int b_delete(HttpServletRequest request)throws Exception;

}
