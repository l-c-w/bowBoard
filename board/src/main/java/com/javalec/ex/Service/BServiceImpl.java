package com.javalec.ex.Service;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

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
		BDto bDto = bDao.b_view(b_num);
		
		return bDto;
	}

	//글쓰기
	@Override
	public int b_write(BDto bDto,MultipartHttpServletRequest mprequest) throws Exception {
		//저장경로
		String path = "C:/Users/arang/Documents/GitHub/bowBoard/board/src/main/webapp/upload/";
	
		String upload_files="";
		String upload_names="";
		
		//파일 받아오기
		List<MultipartFile> file_list = mprequest.getFiles("files");
		
		for (MultipartFile mf : file_list) {
			if(!mf.getOriginalFilename().equals("")) {
				
			String originalName = mf.getOriginalFilename();
			
			//난수 설정
			UUID uuid = UUID.randomUUID();
			
			String file_name = uuid.toString()+"_"+originalName;
			
			mf.transferTo(new File(path+file_name));
			
			upload_files+= file_name+"*";
			upload_names+= originalName+"*";			
			};
		}
		bDto.setB_files(upload_files);
		bDto.setB_file_names(upload_names);
		
		return bDao.b_write(bDto);
	}
	
	//파일 다운로드
	@Override
	public void file_down(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//저장 경로
		String path="C:/Users/arang/Documents/GitHub/bowBoard/board/src/main/webapp/upload/";
		//저장되어 있는 파일의 경로
		String realPath = path+request.getParameter("full_name");
		//업로드 당시 원래 파일의 이름
		String fileName =request.getParameter("ori_name");
		
		System.out.println("경로:"+realPath);
		System.out.println("파일이름:" +fileName);
		
		
		//실제 경로
		File file = new File(realPath);
		
		FileInputStream fis = null;
		ServletOutputStream sos = null;
		
		//브라우저에 따른 파일 인코딩
		try {
			String downName=null;
			//헤더에서 브라우저 정보 가져오기
			String browser = request.getHeader("User-Agent");
			System.out.println("브라우저:"+browser);
			
			if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
				 downName = URLEncoder.encode(fileName,"UTF-8").replaceAll("\\+", "%20");
			}else {
				downName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
			}
			
			 response.setHeader("Content-Disposition","attachment;filename=\"" + downName+"\"");             
		     response.setContentType("application/octer-stream");
		     response.setHeader("Content-Transfer-Encoding", "binary;");
			
			fis = new FileInputStream(file);
			sos = response.getOutputStream(); 
			
			 byte b [] = new byte[1024];
		     int data = 0;
			
			while((data=(fis.read(b, 0, b.length))) != -1){
	            
	            sos.write(b, 0, data);
			}
			
			sos.flush();
	
		} catch (IOException e) {
			e.printStackTrace();
		}finally {
			if(sos!=null){
	            try{
	                sos.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
	        if(fis!=null){
	            try{
	                fis.close();
	            }catch (IOException e){
	                e.printStackTrace();
	            }
	        }
		}
		
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
