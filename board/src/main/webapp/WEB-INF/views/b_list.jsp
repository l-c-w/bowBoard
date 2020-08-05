<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
#search{margin-top: 10px;}
select{height:22px;}
#keyword{display: inline-block; vertical-align: top; margin-top: 1px}
#b_write{display:inline-block;}

</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h1>자유게시판</h1>
	<div id="b_whole">
	<table>
		<tr>
			<th class="b_num">글번호</th>
			<th class="b_title">제목</th>
			<th class="b_name">작성자</th>
			<th class="b_date">작성일</th>	
		</tr>
		<hr>
	<c:forEach var="b_list" items="${list }">
		<tr class="b_body" onclick="location.href='b_view?b_num=${b_list.b_num}'" style="cursor: pointer;">
			<td class="b_num">${b_list.b_num }</td>
			<td class="b_title">${b_list.b_title }</td>
			<td class="b_name">${b_list.b_name }</td>
			<td class="b_date">${b_list.b_date }</td>
		</tr>
	</c:forEach>
	
	</table>
	<hr>
	
	<!-- 페이징이동 -->
		<div id="paging">
			
		<!-- 첫 페이지로 -->
			<a href="event?curPage=1&option=${sv.option }&search=${sv.search}" class="n">처음</a>
				
		<!-- 앞 페이지로 -->
			<c:if test="${paging.prev_page }">
			<a href="event?curPage=${paging.start_page-1 }&option=${sv.option }&search=${sv.search}" class="pre">〈</a>
			</c:if>
					
		<!-- 페이지블럭 -->
			<c:forEach var="index" begin="${paging.start_page }" end="${paging.end_page }" step="1">
			<c:if test="${paging.curPage eq index }">
			<a href="event?curPage=${index }&option=${sv.option }&search=${sv.search}">${index }</a>
			</c:if>
			<c:if test="${paging.curPage ne index }">
			<a href="event?curPage=${index }&option=${sv.option }&search=${sv.search}">${index }</a>
			</c:if>
			</c:forEach>
						
		<!-- 다음 페이지로 -->
			<c:if test="${paging.next_page }">
			<a href="event?curPage=${paging.end_page+1 }&option=${sv.option }&search=${sv.search}" class="next">〉</a>
			</c:if>
						
		<!-- 마지막 페이지로 -->
			<a href="event?curPage=${paging.page_cnt }&option=${sv.option }&search=${sv.search}" class="n">마지막</a>

			</div>
	<!-- //페이징이동 -->
					
	
	<div id="search">
	<select name="sort" id="sort">
		<option value="title">제목</option>
		<option value="content">내용</option>
		<option value="title_con">제목+내용</option>
		<option value="writer">작성자</option>
		<option value="w_date">작성일자</option>
	</select>
	<input type="text" name="keyword" id="keyword">
	<button onclick="">검색</button>
	<button id="b_write" onclick="location.href='bwrite_page'">글쓰기</button>
	</div>
	
	
	<script>
		$(document).ready(function() {
			$("#sort").change(function() {
				if($("#sort option:selected").val()=='w_date'){
					$("#keyword").prop("type", "date");
				}
			});
		});
	
	
	
	</script>
	
	
</body>
</html>