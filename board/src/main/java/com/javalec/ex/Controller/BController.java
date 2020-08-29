package com.javalec.ex.Controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.RDto;
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
	
	//엑셀로 저장하기
	@RequestMapping("board_excel")
	public void board_excel(SearchingDto searchingDto,HttpServletRequest request, HttpServletResponse response) {
			System.out.println(searchingDto.getCur_page());
			System.out.println(searchingDto.getKeyword());
			System.out.println(request.getParameter("excel_type"));
	}
	
	//글 상세보기
	@RequestMapping("b_view")
	public String b_view(HttpServletRequest request, Model model)throws Exception {
		
		model.addAttribute("b_view", bService.b_view(request));
		model.addAttribute("cur_page",request.getParameter("cur_page"));
		model.addAttribute("r_count",bService.r_count(request));
		model.addAttribute("r_list",bService.r_list(request));
		
		return "b_view";
	}
	
	//파일 다운로드
	@RequestMapping("file_down")
	@ResponseBody
	public void file_down(HttpServletRequest request, HttpServletResponse response)throws Exception {
		bService.file_down(request, response);
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
	
	//답변등록
	@RequestMapping("b_reply")
	public String b_reply(BDto bDto,HttpServletRequest request)throws Exception {
		bService.stepup(request);
		bService.b_reply(bDto, request);
		return "redirect:board";
	}

	//글 등록
	@RequestMapping("b_write")
	public String b_write (BDto bDto,MultipartHttpServletRequest mprequest)throws Exception {
		bService.b_write(bDto, mprequest);
		return "redirect:board";
	}
	
	//글 수정페이지로 이동
	@RequestMapping("bupdate_page")
	public String bupdate_page(HttpServletRequest request,Model model)throws Exception {
		model.addAttribute("b_view", bService.b_view(request));
		model.addAttribute("cur_page",request.getParameter("cur_page"));
		return "b_update";
	}
	
	//비밀번호 확인창 띄우기
	@RequestMapping("pw_check")
	public String pw_check(HttpServletRequest request,Model model) {
		model.addAttribute("b_num",request.getParameter("b_num"));
		model.addAttribute("type",request.getParameter("type"));
		model.addAttribute("cur_page",request.getParameter("cur_page"));
		model.addAttribute("b_group",request.getParameter("b_group"));
		model.addAttribute("b_step",request.getParameter("b_step"));
		model.addAttribute("r_num",request.getParameter("r_num"));
		
		return "pw_check";
	}
	
	//비밀번호 확인
	@PostMapping("pw_ok")
	@ResponseBody
	public int pw_ok(HttpServletRequest request,Model model)throws Exception {
		
		return bService.pw_ok(request);
	}
	
	//글 수정하기
	@RequestMapping("b_update")
	public String b_update(BDto bDto,MultipartHttpServletRequest mprequest)throws Exception {
		int b_num=bDto.getB_num();
		String cur_page = mprequest.getParameter("cur_page");
		bService.b_update(bDto ,mprequest);
		return "redirect:b_view?b_num="+b_num+"&cur_page="+cur_page;
	}
	
	//글 삭제하기
	@RequestMapping("b_delete")
	public String b_delete(HttpServletRequest request, BDto bDto)throws Exception {
		int cur_page=Integer.parseInt(request.getParameter("cur_page"));
		bService.b_delete(bDto);
		return "redirect:board?cur_page="+cur_page;
	}
	
	//리플 등록
	@RequestMapping("r_write")
	@ResponseBody
	public int r_write(RDto rDto)throws Exception {
		
		return bService.r_write(rDto);
		
	}
	
	//리플 수정
	@RequestMapping("r_update")
	@ResponseBody
	public int r_update(HttpServletRequest request)throws Exception {
		
		
		return bService.r_update(request);
	}
	
	//리플 삭제
	@RequestMapping("r_delete")
	@ResponseBody
	public int r_delete(HttpServletRequest request)throws Exception {
		
		return bService.r_delete(request);
	}
	
	
	
	
}
