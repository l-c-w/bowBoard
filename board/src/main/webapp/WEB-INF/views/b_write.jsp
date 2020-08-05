<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
	<style type="text/css">
	div{width: 800px; padding: 50px;}
	label {display: block; width: 100px;}
	#b_title{width: 730px;}
	#btn_wrap{width:650px; text-align: center;}
	</style>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<h1>글쓰기</h1>
	<div>
	<form action="b_write" method="post" name="b_write">
		<label for="b_title">제목</label><input type="text" name="b_title" id="b_title"><br>
		<label>작성자</label><input type="text" name="b_name" id="b_name"><br><br>
		
		<textarea rows="10" cols="100" name="b_content" id="b_content"></textarea><br><br>
		<div id="btn_wrap">
		<input type="submit" value="작성" style="margin-right: 5px;"><input type="reset" value="취소">
		</div>
	</form>
	</div>
</body>
</html>