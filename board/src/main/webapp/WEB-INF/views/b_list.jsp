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
#b_whole{width:1030px; margin: 0 auto; margin-bottom: 50px;}
table{width: 1030px; border-collapse: collapse;}


tr{margin-top: 10px;}
td{margin-top: 10px;}
th{height: 30px; vertical-align: middle; padding-top: 10px;}
.b_num{display:inline-block; float:left; width:120px; text-align: center; } 
.b_title{display:inline-block; float:left; width:660px; word-break:break-all; }
/* .b_title{display:inline-block; float:left; width:600px;  overflow:hidden; text-overflow:ellipsis; white-space:nowrap; padding-right: 30px;} */
.repl_count{color: #FF5E00; font-weight: bold; vertical-align: top;}
.b_name{display:block; float:left; width:120px; text-align: center; text-overflow:ellipsis; overflow:hidden; white-space:nowrap; text-align: center;}
.b_date{width:120px; float:left; text-align: center;}

#search{text-align: center;}
#paging{text-align: center;}
#search{display:inline-block; margin-top: 10px; margin-left: 300px;}
select{height:22px;}
#keyword{display: inline-block; vertical-align: top; margin-top: 1px}
#btnWrap{display: inline-block;}
.b_write{display:inline-block;}
th{background-color: #efefef}

</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	
	<div id="b_whole">
	
	<h1 onclick="location.href='board'" style="cursor: pointer;">자유게시판</h1>

	
	<!-- 검색결과 표시 -->
	<c:if test="${not empty sv.keyword }">
		<c:choose>
		<c:when test="${paging.list_count>0 }">
		<h3>"<c:out value="${sv.keyword }"/> " 로 검색하여 "<c:out value="${paging.list_count }"/>건"의 게시물을 찾았습니다. </h3>
		</c:when>
		<c:when test="${paging.list_count==0 }">
		<h3>검색결과가 없습니다. </h3>
		</c:when>
		</c:choose>
	</c:if>
	
	<!-- 엑셀저장 -->
	
	<select name="excel_type" id="excel_type">
	<option value="all_page">전체 페이지</option>
	<option value="now_page">현재 페이지</option>
	</select>
	<button type="button" name="excel" onclick="to_excel('${paging.cur_page}','${sv.sort}','${sv.keyword}')">엑셀파일로 저장</button>
	
	<hr>
	<table>
	
		
		<tr>
			<th class="b_num">글번호</th>
			<th class="b_title">제목</th>
			<th class="b_name">작성자</th>
			<th class="b_date">작성일</th>	
		</tr>
		
		
		<fmt:formatDate var="today" value="${now }" pattern="yy-MM-dd" />

		<c:forEach var="b_list" items="${list }" varStatus="status">
		<tr id="b_body">
			<td class="b_num" >
			<span>
			<c:out value="${paging.list_count+10-(status.index+(10*paging.cur_page))}"/>  
			</td>
			<td class="b_title" onclick="location.href='b_view?b_num=${b_list.b_num}&cur_page=${paging.cur_page}'" style="cursor: pointer; text-align: left; ">
			<c:choose>
			
			<c:when test="${not empty b_list.b_title&&b_list.b_indent==0 }">
			<c:choose>
			<c:when test="${not empty b_list.b_content }">
			<c:out value="${b_list.b_title }"/>
			
			</c:when>
			<c:when test="${empty b_list.b_content }">
			<del><em><c:out value="${b_list.b_title }"/></em></del>
			
			</c:when>
			</c:choose>
			</c:when>
			
			<c:when test="${b_list.b_indent>0 }">
			<c:forEach begin="1" end="${b_list.b_indent }" step="1">&nbsp&nbsp&nbsp</c:forEach>
			<c:choose>
			<c:when test="${not empty b_list.b_content }">
			ㄴ<c:out value="${b_list.b_title }"/>
			
			</c:when>
			<c:when test="${empty b_list.b_content }">
			<del><em><c:out value="${b_list.b_title }"/></em></del>
			
			</c:when>
			</c:choose>
			</c:when>
			
			</c:choose>
			<c:if test="${not empty b_list.b_files }">
				<img alt="파일있음" src="resources/images/file_icon.jpg" width="16px;" height="16px;" style="vertical-align: middle;">
			</c:if>
			
			<c:if test="${b_list.repl_count>0 }">
			<span class="repl_count">[${b_list.repl_count }]</span>
			</c:if>
			</td>
			
			<td class="b_name"><c:out value="${b_list.b_name }"/></td>
			<td class="b_date">
			<fmt:formatDate var="b_date" value="${b_list.b_date }" pattern="yy-MM-dd"/>
			
			
			<c:choose>
			<c:when test="${today eq b_date }">
			<fmt:formatDate value="${b_list.b_date }" pattern="HH:MM"/>
			</c:when>
			<c:when test="${today ne b_date }">
			<c:out value="${b_date }"/> 
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
			<a href="board?cur_Page=1&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}">처음</a>
				
		<!-- 앞 블럭으로 -->
			<c:if test="${paging.prev_page }">
			<a href="board?cur_page=${paging.start_page-1 }&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}">〈</a>
			</c:if>
					
		<!-- 페이지블럭 -->
			
			<c:forEach var="index" begin="${paging.start_page }" end="${paging.end_page }" step="1">
			<c:if test="${paging.cur_page eq index }">
			<a href="board?cur_page=${index }&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}" style="background-color: black; color: white">${index }</a>
			</c:if>
			<c:if test="${paging.cur_page ne index }">
			<a href="board?cur_page=${index }&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}">${index }</a>
			</c:if>
			</c:forEach>
						
		<!-- 다음 블럭으로 -->
			<c:if test="${paging.next_page }">
			<a href="board?cur_page=${paging.end_page+1 }&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}">〉</a>
			</c:if>
						
		<!-- 마지막 페이지로 -->
			<a href="board?cur_page=${paging.page_count }&sort=${sv.sort }&keyword=${sv.keyword}&end_date=${sv.end_date}">마지막</a>

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
	<button type="button" onclick="search_check()">검색</button>
	<button type="button" class="b_write" onclick="location.href='bwrite_page'">글쓰기</button>
	<c:if test="${not empty sv.keyword }">
		<button type="button" class="b_write" onclick="location.href='board'">전체보기</button>
	</c:if>
	</div>
	</div>
	
	
	<script>
		//날짜검색창으로 변경
		$(document).ready(function() {
			$("#sort").change(function() {
				if($("#sort option:selected").val()=='w_date'){
					$("#keyword").attr("type", "date");
					$("#word").append('~<input type="date" name="end_date" id="end_date">');
				}
			});	
		});
		
		<%-- function write_check() {
			log_check='<%=session.getAttribute("write_term")%>';
			w_check ='<%=session.getMaxInactiveInterval()-session.getCreationTime()%>';
			alert(log_check);
			alert(<%=session.getMaxInactiveInterval()%>);
			alert(<%= new java.util.Date(session.getCreationTime()) %>);
			location.href='bwrite_page';
			
		} --%>
	
		function search_check() {
			if($("#keyword").val()==""){
				alert('검색어를 입력해주세요');
				return;
			}else{			
				document.search.submit();
			}
		}
		
		function to_excel(cur_page,sort,keyword) {
			var excel_type=$("#excel_type").val();
			
			
			location.href='board_excel?cur_page='+cur_page+'&sort='+sort+'&keyword='+keyword+'&excel_type='+excel_type; 
			
			
		}
		
	</script>
	
	
	
</body>
</html>