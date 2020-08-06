<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<jsp:useBean id="now" class="java.util.Date"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
a{text-decoration: none; color: black; border: 1px solid #666; padding: 3px;}
#b_whole{width:1000px; }
#b_head{border-bottom: 2px solid black;}
.b_body{margin-bottom: 10px;}
.b_num{width:80px; text-align: center;}
.b_title{width:400px; text-align: center;}
.b_name{width:200px; text-align: center;}
.b_date{width:200px; text-align: center;}
#search{text-align: center;}
#paging{text-align: center;}
#search{display:inline-block; margin-top: 10px; margin-left: 300px;}
select{height:22px;}
#keyword{display: inline-block; vertical-align: top; margin-top: 1px}
#btnWrap{display: inline-block;}
.b_write{display:inline-block;}

</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h1 onclick="location.href='board'" style="cursor: pointer;">자유게시판</h1>
	
	<!-- 검색결과 표시 -->
	<c:if test="${not empty sv.keyword }">
		<c:choose>
		<c:when test="${paging.list_count>0 }">
		<h3>"${sv.keyword }" 로 검색하여 "${paging.list_count } 건"의 게시물을 찾았습니다. </h3>
		</c:when>
		<c:when test="${paging.list_count==0 }">
		<h3>검색결과가 없습니다. </h3>
		</c:when>
		</c:choose>
	</c:if>
	
	<div id="b_whole">
	<table>
		<tr>
			<th class="b_num">글번호</th>
			<th class="b_title">제목</th>
			<th class="b_name">작성자</th>
			<th class="b_date">작성일</th>	
		</tr>
		<hr>
		
		<fmt:formatDate var="today" value="${now }" pattern="yy-MM-dd" />

		<c:forEach var="b_list" items="${list }" varStatus="status">
		<tr class="b_body">
			<td class="b_num"><!-- ${paging.list_count+10-(status.index+(10*paging.cur_page))}-->
			${b_list.b_num } </td>
			<td class="b_title" onclick="location.href='b_view?b_num=${b_list.b_num}'" style="cursor: pointer;">${b_list.b_title }</td>
			<td class="b_name">${b_list.b_name }</td>
			<td class="b_date">
			<fmt:formatDate var="b_date" value="${b_list.b_date }" pattern="yy-MM-dd"/>
			
			
			<c:choose>
			<c:when test="${today eq b_date }">
			<fmt:formatDate value="${b_list.b_date }" pattern="hh:MM"/>
			</c:when>
			<c:when test="${today ne b_date }">
			${b_date }
			</c:when>
			</c:choose>
			</td>
		</tr>
	</c:forEach>
	
	</table>
	<hr>
	
	<!-- 페이징 -->
	<c:if test="${paging.list_count!=0 }">
		<div id="paging">
			
		<!-- 첫 페이지로 -->
			<a href="board?cur_Page=1&sort=${sv.sort }&keyword=${sv.keyword}">처음</a>
				
		<!-- 앞 페이지로 -->
			<c:if test="${paging.prev_page }">
			<a href="board?cur_page=${paging.start_page-1 }&sort=${sv.sort }&keyword=${sv.keyword}">〈</a>
			</c:if>
					
		<!-- 페이지블럭 -->
			
			<c:forEach var="index" begin="${paging.start_page }" end="${paging.end_page }" step="1">
			<c:if test="${paging.cur_page eq index }">
			<a href="board?cur_page=${index }&sort=${sv.sort }&keyword=${sv.keyword}" style="background-color: black; color: white">${index }</a>
			</c:if>
			<c:if test="${paging.cur_page ne index }">
			<a href="board?cur_page=${index }&sort=${sv.sort }&keyword=${sv.keyword}">${index }</a>
			</c:if>
			</c:forEach>
						
		<!-- 다음 페이지로 -->
			<c:if test="${paging.next_page }">
			<a href="board?cur_page=${paging.end_page+1 }&sort=${sv.sort }&keyword=${sv.keyword}">〉</a>
			</c:if>
						
		<!-- 마지막 페이지로 -->
			<a href="board?cur_page=${paging.page_count }&sort=${sv.sort }&keyword=${sv.keyword}">마지막</a>

			</div>
			</c:if>
	<!-- //페이징이동 -->
					
	<!-- 검색창 -->
	<div id="searching">
	<form action="board" method="post" name="search" id="search">
	<select name="sort" id="sort">
		<option value="all">제목+내용</option>
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="writer">작성자</option>
		<option value="w_date">작성일자</option>
	</select>
	<div id="word" style="display: inline-block;">
	<input type="text" name="keyword" id="keyword">
	</div>
	</form>
	<button onclick="search_check()">검색</button>
	<button class="b_write" onclick="location.href='bwrite_page'">글쓰기</button>
	<c:if test="${not empty sv.keyword }">
		<button class="b_write" onclick="location.href='board'">전체보기</button>
	</c:if>
	</div>
	
	
	<script>
		//날짜검색창으로 변경
		$(document).ready(function() {
			$("#sort").change(function() {
				if($("#sort option:selected").val()=='w_date'){
					$("#keyword").prop("type", "date");
					$("#word").append('~<input type="date" name="end_date" id="end_date">');
				}
			});	
		});
	
		function search_check() {
			if($("#keyword").val()==""){
				alert('검색어를 입력해주세요');
				return;
			}else{			
				document.search.submit();
			}
		}
	</script>
	
</body>
</html>