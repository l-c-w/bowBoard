<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${b_view.b_title} : 자유게시판</title>
<style type="text/css">
#whole_wrap{width: 800px; margin: 0 auto;}
Xmp{font-family:sans-serifs;vertical-align: inherit; font-size: 16px; margin: 10px;}
table{width: 800px; }
tr{display:block; border-bottom: 1px solid black;}
#writer{width:700px;}
#content{height: 300px; vertical-align: top; padding-top: 10px;}
#btnwrap{float: right; margin-top: 10px;}

	
</style>
</head>
<body>
	<div id="whole_wrap">
	<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<table>
		<tr id="title">
		<td><Xmp>${b_view.b_title }</Xmp></td>
		</tr>
		<tr>
		<td id="writer"><Xmp>${b_view.b_name }</Xmp></td>
		<td id="date"><fmt:formatDate value="${b_view.b_date }" pattern="yy-MM-dd"/></td>
		</tr>
		<tr>
		<td id="content"><Xmp>${b_view.b_content }</Xmp></td>
		</tr>
	</table>
	<div id="btnwrap">
	<button onclick="location.href='bupdate_page?b_num=${b_view.b_num}'">수정</button>
	<button onclick="b_delete(${b_view.b_num })">삭제</button>
	<button onclick="location.href='board'">목록</button>
	</div>
	</div>
	
	<script>
		function b_delete(b_num) {
			var delete_check = confirm("삭제하시겠습니까?");
			
			if(delete_check){
				location.href='b_delete?b_num='+b_num;
			}else{
				return;
			}
		}
	
	
	
	</script>
	
	
</body>
</html>