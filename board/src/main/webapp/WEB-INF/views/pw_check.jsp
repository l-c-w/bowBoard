<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
div{width:220px; margin: 50px auto; }
.checking{font-size: 14px; color: red;}
</style>
</head>
<body>
	<div>
	<h3>비밀번호 확인</h3>
	<form action="pw_ok" name="pw_check" method="post">
		<input type="hidden" value="${b_num }" name="b_num">
		<input type="password" name="b_pw" id="b_pw" placeholder="비밀번호를 입력하세요." fo>
		<button type="button" onclick="go_check('${b_num}','${type }')">확인</button>
	</form>
	<span id="notice" class="checking"></span>
	</div>
	<script>
	
	$(function() {
		  $("#b_pw").focus();
		});
	
	
	function go_check(b_num,type) {
		var input_pw= $("#pw").val();
		var pw_data = $("form[name=pw_check]").serialize();
		
		$.ajax({
			type:"post",
			url:"pw_ok",
			data:pw_data,
			dataType:"json",
			success: function(data) {
				if(data=="1"){
					window.close();
					if(type=="update"){
					opener.location.href="bupdate_page?b_num="+${b_num};						
					}else if(type=="delete"){
						window.close();
						opener.location.href="b_delete?b_num="+${b_num};	
					}
				}else{
					$("#notice").text("※비밀번호가 틀립니다.");
				}
			},
			error: function() {
				alert("통신 실패");
			}
		});
		
	}

</script>
</body>
</html>