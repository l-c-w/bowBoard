package com.javalec.ex.Dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
import com.javalec.ex.Dto.RDto;
import com.javalec.ex.Dto.SearchingDto;

@Repository
public class BDaoImpl implements BDao {

	@Inject
	SqlSession sqlSession;

	private static String namespace = "com.javalec.ex.Dao.BDao";
	
	//글 리스트 가져오기
	@Override
	public List<BDto> b_list(SearchingDto searchingDto) throws Exception {
		
		return sqlSession.selectList(namespace+".b_list",searchingDto);
	}
	
	//리스트 페이징
	@Override
	public PagingDto b_paging(SearchingDto searchingDto) throws Exception {
		
		return sqlSession.selectOne(namespace+".b_paging", searchingDto);
	}
	
	//글 상세보기
	@Override
	public BDto b_view(int b_num) throws Exception {
		
		return sqlSession.selectOne(namespace+".b_view", b_num);
	}
	
	//글쓰기
	@Override
	public int b_write(BDto bDto) throws Exception {
		
		return sqlSession.insert(namespace+".b_write", bDto);
	}
	
	//답변 등록
	@Override
	public int b_reply(BDto bDto) throws Exception {
		return sqlSession.insert(namespace+".b_reply", bDto);
	}
	
	//등록 전 요소 업데이트
	@Override
	public int stepup(BDto bDto) throws Exception {

		return sqlSession.update(namespace+".stepup", bDto);
	}
	
	//비밀번호 찾기
	@Override
	public int pw_ok(BDto bDto) throws Exception {
		
		return sqlSession.selectOne(namespace+".pw_ok", bDto);
	}
	
	//글수정
	@Override
	public int b_update(BDto bDto) throws Exception {
		return sqlSession.update(namespace+".b_update", bDto);
	}

	//글삭제
	@Override
	public int b_delete(int b_num) throws Exception {
		
		return sqlSession.delete(namespace+".b_delete",b_num);
	}

	//답변 달린 글 삭제
	@Override
	public int br_delete(int b_num) throws Exception {
		
		return sqlSession.update(namespace+".br_delete",b_num);
	}

	//답변 여부 확인
	@Override
	public int r_check(BDto bDto) throws Exception {
		
		return sqlSession.selectOne(namespace+".r_check",bDto);
	}

	//리플 등록
	@Override
	public int r_write(RDto rDto) throws Exception {

		return sqlSession.insert(namespace+".r_write", rDto);
	}

	//리플 갯수
	@Override
	public int r_count(int b_num) throws Exception {
	
		return sqlSession.selectOne(namespace+".r_count", b_num);
	}
	
	//리플 리스트 가져오기
	@Override
	public List<RDto> r_list(int b_num) throws Exception {
		return sqlSession.selectList(namespace+".r_list", b_num);
	}

	//리플 비밀번호 확인
	@Override
	public int rpw_ok(RDto rDto) throws Exception {

		return sqlSession.selectOne(namespace+".rpw_ok", rDto);
	}
	//댓글 수정
	@Override
	public int r_update(RDto rDto) throws Exception {
		
		return sqlSession.update(namespace+".r_update", rDto);
	}
	
	//댓글 삭제
	@Override
	public int r_delete(int r_num) throws Exception {
		
		return sqlSession.delete(namespace+".r_delete", r_num);
	}
	

	

	

	

	

	

	
	
	
	
}
