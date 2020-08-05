<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정하기</title>
<style type="text/css">
#whole_wrap{width: 800px; }
table{width: 800px; }
tr{display:block; border-bottom: 1px solid black;}
#writer{width:700px;}
#btnwrap{float: right; margin-top: 10px;}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<h3 onclick="location.href='board'" style="cursor: pointer;">자유게시판 ></h3>
	<div id="whole_wrap">
	<form action="b_update" method="post" name="b_update">
	<table>
		<input type="hidden" value="${b_view.b_num }" name="b_num">
		<tr id="title">
		<td><input type="text" value="${b_view.b_title }" name="b_title" id="b_title"></td>
		</tr>
		<tr>
		<td id="writer">${b_view.b_name }</td>
		<td id="date">${b_view.b_date }</td>
		</tr>
		<tr>
		<td id="content"><textarea rows="10" cols="100" name="b_content" id="b_content">${b_view.b_content }</textarea></td>
		</tr>
	</table>
	</form>
	<div id="btnwrap">
	<button onclick="update()">수정</button>
	<button onclick="history.go(-1)">취소</button>
	</div>
	</div>
	
	<script >
		function update() {
			
			if($("#b_title").val()==""){
				$("#b_title").focus();
				$("#b_title").attr("placeholder","제목을 입력해주세요.");
				return;
			}
			
			if($("#b_content").val()==""){
				$("#b_content").focus();
				$("#b_content").attr("placeholder","내용을 입력해주세요.");
				return;
			}
			
			var update_check= confirm("수정하시겠습니까?");
			if (update_check) {
				b_update.submit();
			}else{
				return;
			}
		}
	
	
	</script>

</body>
</html>