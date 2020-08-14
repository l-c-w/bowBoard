package com.javalec.ex.Controller;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String bwrite_page(HttpServletRequest request, Model model)throws Exception {
		
		model.addAttribute("type",request.getParameter("type"));
		model.addAttribute("b_group",request.getParameter("b_group"));
		model.addAttribute("b_step",request.getParameter("b_step"));
		model.addAttribute("b_indent",request.getParameter("b_indent"));

		return "b_write";
	}
	
	//글 등록
	@RequestMapping("b_write")
	public String b_write (BDto bDto)throws Exception {
		bService.b_write(bDto);
		return "redirect:board";
	}
	
	//답변등록
	@RequestMapping("b_reply")
	public String b_reply(BDto bDto,HttpServletRequest request)throws Exception {
		bService.stepup(request);
		bService.b_reply(bDto, request);
		return "redirect:board";
	}
	
	//글 수정페이지로 이동
	@RequestMapping("bupdate_page")
	public String bupdate_page(HttpServletRequest request,Model model)throws Exception {
		model.addAttribute("b_view", bService.b_view(request));
		return "b_update";
	}
	
	//비밀번호 확인창 띄우기
	@RequestMapping("pw_check")
	public String pw_check(HttpServletRequest request,Model model) {
		model.addAttribute("b_num",request.getParameter("b_num"));
		model.addAttribute("type",request.getParameter("type"));
		
		return "pw_check";
	}
	
	//비밀번호 확인
	@PostMapping("pw_ok")
	@ResponseBody
	public int pw_ok(BDto bDto,Model model)throws Exception {
		
		return bService.pw_ok(bDto);
	}
	
	//글 수정하기
	@RequestMapping("b_update")
	public String b_update(BDto bDto)throws Exception {
		int b_num=bDto.getB_num();
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
