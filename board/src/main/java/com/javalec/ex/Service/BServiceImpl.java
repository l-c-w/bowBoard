package com.javalec.ex.Service;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import com.javalec.ex.Dao.BDao;
import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
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
		
//		System.out.println("page_size:"+pagingDto.getPage_size());
//		System.out.println("range_size:"+pagingDto.getRange_size());
//		System.out.println("cur_page:"+pagingDto.getCur_page());
//		System.out.println("cur_range:"+pagingDto.getCur_range());
//		System.out.println("page_count:"+pagingDto.getPage_count());
//		System.out.println("range_count:"+pagingDto.getRange_count());
//		System.out.println("prev:"+pagingDto.isPrev_page());
//		System.out.println("next:"+pagingDto.isNext_page());
//		System.out.println("startpage:"+pagingDto.getStart_page());
//		System.out.println("endpage:"+pagingDto.getEnd_page());
		
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
