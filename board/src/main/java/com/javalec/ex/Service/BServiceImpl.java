package com.javalec.ex.Service;

import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.javalec.ex.Dao.BDao;
import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
import com.javalec.ex.Dto.RDto;
import com.javalec.ex.Dto.SearchingDto;

@Service
public class BServiceImpl implements BService {

	
	@Inject
	BDao bDao;
	
	@Override
	public List<BDto> b_list(SearchingDto searchingDto) throws Exception {
		return bDao.b_list(searchingDto);
	}
	
	//글 페이징 요소
	@Override
	public PagingDto b_paging(SearchingDto searchingDto) throws Exception {
		//리스트 카운트 가져오기
		PagingDto pagingDto = bDao.b_paging(searchingDto);
		
		//페이징요소 셋팅
		pagingDto.setPage_size(10);
		pagingDto.setRange_size(5);
		pagingDto.setCur_page(searchingDto.getCur_page());
		pagingDto.setCur_range(searchingDto.getCur_page());
		pagingDto.setPage_count(pagingDto.getList_count());
		pagingDto.setRange_count(pagingDto.getPage_count());
		pagingDto.prevnext(searchingDto.getCur_page());
		pagingDto.setStart_page(pagingDto.getCur_range(), pagingDto.getRange_size());
		pagingDto.setEnd_page(pagingDto.getCur_range(), pagingDto.getRange_count());
		
		return pagingDto;
	}
	
	//글 한개 가져오기
	@Override
	public BDto b_view(HttpServletRequest request) throws Exception {
		int b_num = Integer.parseInt(request.getParameter("b_num")); 
		return bDao.b_view(b_num);
	}

	//글쓰기
	@Override
	public int b_write(BDto bDto) throws Exception {
		
		return bDao.b_write(bDto);
	}
	
	//답변 등록
	@Override
	public int b_reply(BDto bDto, HttpServletRequest request) throws Exception {
		bDto.setB_group(Integer.parseInt(request.getParameter("b_group")));
		bDto.setB_step(Integer.parseInt(request.getParameter("b_step")));
		bDto.setB_indent(Integer.parseInt(request.getParameter("b_indent")));
		
		return bDao.b_reply(bDto);
	}

	//등록 전 요소 업데이트
	@Override
	public int stepup(HttpServletRequest request) throws Exception {
		BDto bDto = new BDto();
		 bDto.setB_group(Integer.parseInt(request.getParameter("b_group")));
		 bDto.setB_step(Integer.parseInt(request.getParameter("b_step")));
		return bDao.stepup(bDto);
	}
	
	//비밀번호 확인
	@Override
	public int pw_ok(HttpServletRequest request) throws Exception {
		int result =0;
		String type = request.getParameter("type");
		if(type.equals("update")||type.equals("delete")) {
			BDto bDto = new BDto();
			bDto.setB_num(Integer.parseInt(request.getParameter("b_num")));
			bDto.setB_pw(request.getParameter("b_pw"));
			result =bDao.pw_ok(bDto);
		}else if(type.equals("r_update")||type.equals("r_delete")) {
			RDto rDto = new RDto();
			rDto.setR_num(Integer.parseInt(request.getParameter("r_num")));
			rDto.setR_pw(request.getParameter("b_pw"));
			result= bDao.rpw_ok(rDto);
		}
		
		return result;
	}


	//글수정
	@Override
	public int b_update(BDto bDto) throws Exception {
		
		return bDao.b_update(bDto);
	}

	//글삭제
	@Override
	public int b_delete(BDto bDto) throws Exception {
		
		int check=0;
		
		//답변이 달려있는가에 따라 완전삭제, 이름제목내용만 삭제
		if(bDao.r_check(bDto)==0) {
			check= bDao.b_delete(bDto.getB_num());
		}else if(bDao.r_check(bDto)>0) {
			check= bDao.br_delete(bDto.getB_num());
		}
		return check;
	}

	//리플 작성
	@Override
	public int r_write(RDto rDto) throws Exception {
		
		return bDao.r_write(rDto);
	}

	//리플 갯수
	@Override
	public int r_count(HttpServletRequest request) throws Exception {
		int b_num = Integer.parseInt(request.getParameter("b_num"));

		return bDao.r_count(b_num);
	}

	//댓글 리스트 가져오기
	@Override
	public List<RDto> r_list(HttpServletRequest request) throws Exception {
		int b_num = Integer.parseInt(request.getParameter("b_num"));
		
		return bDao.r_list(b_num);
	}

	//리플 수정
	@Override
	public int r_update(HttpServletRequest request) throws Exception {
		RDto rDto = new RDto();
		
		rDto.setR_num(Integer.parseInt(request.getParameter("r_num")));
		rDto.setR_content(request.getParameter("r_content"));
		return bDao.r_update(rDto);
	}

	//리플 삭제
	@Override
	public int r_delete(HttpServletRequest request) throws Exception {
		int r_num = Integer.parseInt(request.getParameter("r_num"));
		
		return bDao.r_delete(r_num);
	}

	


	
}
