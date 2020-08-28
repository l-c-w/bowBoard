package com.javalec.ex.Service;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
import com.javalec.ex.Dto.RDto;
import com.javalec.ex.Dto.SearchingDto;

public interface BService {
	
	//글 리스트 가져요기
	public List<BDto> b_list(SearchingDto searchingDto) throws Exception;
	
	//글 페이징요소
	public PagingDto b_paging(SearchingDto searchingDto) throws Exception;
	
	//글 한개 보기
	public BDto b_view(HttpServletRequest request) throws Exception;
	
	//글쓰기
	public int b_write(BDto bDto,MultipartHttpServletRequest mprequest) throws Exception;
	
	//파일 다운로드
	public void file_down(HttpServletRequest request,HttpServletResponse response)throws Exception;
	
	//답변작성
	public int b_reply(BDto bDto,HttpServletRequest request)throws Exception;
	
	//등록 전 요소 업데이트
	public int stepup(HttpServletRequest request)throws Exception;
	
	//비밀번호 확인
	public int pw_ok(HttpServletRequest request)throws Exception;
	
	//글수정
	public int b_update(BDto bDto)throws Exception;
	
	//글삭제(답변글 포함)
	public int b_delete(BDto bDto)throws Exception;
	
	//리플 작성
	public int r_write(RDto rDto)throws Exception;
	
	//리플 갯수
	public int r_count(HttpServletRequest request)throws Exception;
	
	//리플 리스트 가져오기
	public List<RDto> r_list(HttpServletRequest request)throws Exception;
	
	//리플 수정
	public int r_update(HttpServletRequest request)throws Exception;
	
	//리플 삭제
	public int r_delete(HttpServletRequest request)throws Exception;
	
}
