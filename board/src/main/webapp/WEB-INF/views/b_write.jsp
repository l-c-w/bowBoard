<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 작성</title>
	<style type="text/css">
	div{width: 800px; padding: 50px; margin: 0 auto;}
	label {display: inline-block; width: 130px;}
	#b_title{width: 730px;}
	#b_pw{vertical-align: top;}
	#notice{font-size: 12px; color: #666}
	#pw_wrap{height: 50px; padding: 0px;}
	#btn_wrap{width:500px; text-align: center;}
	.count{color: #aaa}
	.checking{font-size: 14px; color: red;}
	</style>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<div>
	<h1>글쓰기</h1>
	<form action="b_write" method="post" name="b_write">
		<label for="b_title">제목</label><br><input type="text" name="b_title" id="b_title" placeholder="제목을 입력하세요.">
		<br>
		<span id="title_check" class="checking"></span>
		<br>
		<!-- <span id="title_count" class="count">0/100자</span> -->
		
		<label>작성자</label><br><input type="text" name="b_name" id="b_name" placeholder="작성자명을 입력해주세요.">
		<br>
		<span id="name_check" class="checking"></span>
		<br>
		<!-- <span id="name_count" class="count">0/10자</span> -->
		
		<div id="pw_wrap">
		비밀번호<br><input type="text" name="b_pw" id="b_pw" placeholder="비밀번호를 입력해주세요">
		<span id="notice">*수정,삭제시 사용됩니다. 최대 10자리, 영문/숫자만 입력가능합니다.</span>
		<br>
		<span id="pw_check" class="checking"></span>
		<br>
		<!-- <span id="pw_count" class="count">0/10자</span> -->
		</div>
		<br>
		
		<textarea rows="10" cols="100" name="b_content" id="b_content" placeholder="내용을 입력하세요."></textarea>
		<span id="title_check" class="checking"></span>
		<br>
		<span id="content_count" class="count">0/2000자</span>
	</form>
	<div id="btn_wrap">
		<button style="margin-right: 5px;" onclick="write_check()">작성</button>
		<button onclick="history.go(-1)">목록</button>
	</div>
	</div>
	
	<script>
		$(document).ready(function() {
			
/* 			$("#b_title").keypress(function(e) {
				if (e.keyCode == 13) e.preventDefault();
			});
 */			$("#b_title").keyup(function() {
				var content = $(this).val();
				/* $("#title_count").html("<span id='title_count' class='count'>("+content.length+"/100)</span>"); */
				$("#title_check").text("");
				if(content.length>100){
					alert("제목은 최대 100자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 100));
					/* $("#title_count").html("<span id='title_count' class='count'>(100/100)</span>"); */
				}				
			});
			
			
			$("#b_name").keyup(function() {
				var content = $(this).val();
				/* $("#name_count").html("<span id='name_count' class='count'>("+content.length+"/10)</span>"); */
				$("#name_check").text("");
				if(content.length>10){
					alert("작성자명은 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
					/* $("#name_count").html("<span id='name_count' class='count'>(10/10)</span>"); */
				}	
			});
			
			$("#b_pw").keyup(function() {
				var content = $(this).val();
				/* $("#pw_count").html("<span id='pw_count' class='count'>("+content.length+"/10)</span>"); */
				$("#pw_check").text("");
				if(content.length>10){
					alert("비밀번호는 최대 10자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 10));
					/* $("#pw_count").html("<span id='pw_count' class='count'>(10/10)</span>"); */
				}	
			});
			
			$("#b_content").keyup(function() {
				var content = $(this).val();
				$("#content_count").html("<span id='content_count' class='count'>("+content.length+"/2000)</span>");
				if(content.length>2000){
					alert("본문은 최대 2000자까지 입력가능합니다.");
					$(this).val($(this).val().substring(0, 2000));
					$("#content_count").html("<span id='content_count' class='count'>(2000/2000)</span>");
				}	
			});
			
		});
			
			
		function write_check() {
			if($("#b_title").val()==""){
				$("#b_title").focus();
				$("#title_check").text("※제목란을 채워주세요.");
				return;
			}
			
			if($("#b_name").val()==""){
				$("#b_name").focus();
				$("#name_check").text("※작성자란을 채워주세요.");
				return;
			}
			
			if($("#b_pw").val()==""){
				$("#b_pw").focus();
				$("#pw_check").text("※비밀번호란을 채워주세요.");
				return;
			}
			
			var pw_check=/^[A-Za-z0-9+]*$/; 
			
			if(!(pw_check.test(b_write.b_pw.value))){
				alert("비밀번호는 영문/숫자만 입력가능합니다.");
				form.id.focus();
				return false;
			}
			
			if($("#b_content").val()==""){
				$("#b_content").focus();
				$("#b_content").attr("placeholder","내용을 채워주세요.");
				return;
			}else{
				document.b_write.submit();
			}
		}
	
	</script>
</body>
</html>