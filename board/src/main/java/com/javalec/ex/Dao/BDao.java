package com.javalec.ex.Dao;

import java.util.ArrayList;
import java.util.List;

import com.javalec.ex.Dto.BDto;

public interface BDao {

	//글 리스트 가져오기
	public List<BDto> b_list() throws Exception;
	
	//글 상세보기
	public BDto b_view(int b_num) throws Exception;
	
	//글쓰기
	public int b_wirte(BDto bDto) throws Exception;
	
	//글수정
	public int b_update(BDto bDto)throws Exception;
	
	//글삭제
	public int b_delete(int b_num)throws Exception;
}
