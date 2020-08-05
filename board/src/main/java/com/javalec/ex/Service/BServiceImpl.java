package com.javalec.ex.Service;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.javalec.ex.Dao.BDao;
import com.javalec.ex.Dto.BDto;

@Service
public class BServiceImpl implements BService {

	
	@Inject
	BDao bDao;
	
	//글 리스트 가져오기
	@Override
	public List<BDto> b_list() throws Exception {
		return bDao.b_list();
	}
	
	//글 한개 가져오기
	@Override
	public BDto b_view(HttpServletRequest request) throws Exception {
		int b_num = Integer.parseInt(request.getParameter("b_num")); 
		return bDao.b_view(b_num);
	}

	//글쓰기
	@Override
	public int b_wirte(BDto bDto) throws Exception {
		
		return bDao.b_wirte(bDto);
	}

	//글수정
	@Override
	public int b_update(BDto bDto) throws Exception {
		
		return bDao.b_update(bDto);
	}

	//글삭제
	@Override
	public int b_delete(HttpServletRequest request) throws Exception {
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		return bDao.b_delete(b_num);
	}

	

	
}
