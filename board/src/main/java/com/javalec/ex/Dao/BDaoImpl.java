package com.javalec.ex.Dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.javalec.ex.Dto.BDto;
import com.javalec.ex.Dto.PagingDto;
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
	public int b_wirte(BDto bDto) throws Exception {
		
		return sqlSession.insert(namespace+".b_write", bDto);
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

	

	

	

	
	
	
	
}
