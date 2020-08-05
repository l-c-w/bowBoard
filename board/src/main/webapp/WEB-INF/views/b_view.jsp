<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${b_view.b_title} : 자유게시판</title>
<style type="text/css">
#whole_wrap{width: 800px; }
table{width: 800px; }
tr{display:block; border-bottom: 1px solid black;}
#writer{width:700px;}
#content{height: 300px; vertical-align: top; padding-top: 10px;}
#btnwrap{float: right; margin-top: 10px;}

	
</style>
</head>
<body>
	<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<div id="whole_wrap">
	<table>
		<tr id="title">
		<td>${b_view.b_title }</td>
		</tr>
		<tr>
		<td id="writer">${b_view.b_name }</td>
		<td id="date">${b_view.b_date }</td>
		</tr>
		<tr>
		<td id="content">${b_view.b_content }</td>
		</tr>
	</table>
	<div id="btnwrap">
	<button onclick="location.href='bupdate_page?b_num=${b_view.b_num}'">수정</button>
	<button onclick="b_delete(${b_view.b_num })">삭제</button>
	<button onclick="location.href='board'">목록으로</button>
	</div>
	</div>
	
	<script>
		function b_delete(b_num) {
			var delete_check = confirm("삭제하시겠습니까>?");
			
			if(delete_check){
				location.href='b_delete?b_num='+b_num;
			}else{
				return;
			}
		}
	
	
	
	</script>
	
	
</body>
</html>