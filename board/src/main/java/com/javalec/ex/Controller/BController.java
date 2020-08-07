package com.javalec.ex.Controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.SearchingDto;
import com.javalec.ex.Service.BService;

@Controller
public class BController {

	@Inject
	BService bService;
	
	//게시판 리스트 보기
	@RequestMapping("board")
	public String board_list(SearchingDto searchingDto, Model model) throws Exception{
		
		//리스트 보내주기
		model.addAttribute("list",bService.b_list(searchingDto));
		//페이징 보내기
		model.addAttribute("paging",bService.b_paging(searchingDto));
		//검색값 보내기
		model.addAttribute("sv",searchingDto);
		
		return "b_list";
	}
	
	//글 상세보기
	@RequestMapping("b_view")
	public String b_view(HttpServletRequest request, Model model)throws Exception {
		
		model.addAttribute("b_view", bService.b_view(request));
		
		return "b_view";
	}
	
	//글 등록 페이지로 이동
	@RequestMapping("bwrite_page")
	public String bwrite_page() {
		return "b_write";
	}
	
	//글 등록
	@RequestMapping("b_write")
	public String b_write (BDto bDto)throws Exception {
		bService.b_wirte(bDto);
		return "redirect:board";
	}
	
	//글 수정페이지로 이동
	@RequestMapping("bupdate_page")
	public String bupdate_page(HttpServletRequest request,Model model)throws Exception {
		model.addAttribute("b_view", bService.b_view(request));
		return "b_update";
	}
	
	//글 수정하기
	@RequestMapping("b_update")
	public String b_update(BDto bDto)throws Exception {
		int b_num=bDto.getb_num();
		bService.b_update(bDto);
		return "redirect:b_view?b_num="+b_num;
	}
	
	//글 삭제하기
	@RequestMapping("b_delete")
	public String b_delete(HttpServletRequest request)throws Exception {
		bService.b_delete(request);
		return "redirect:board";
	}
	
	
}
