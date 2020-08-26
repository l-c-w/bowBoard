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
	<input type="hidden" name="type" value="${type }">
		<input type="hidden" name="b_num" value="${b_num }">
		<input type="hidden" name="r_num" value="${r_num }">
	
		<input type="password" name="b_pw" id="b_pw" placeholder="비밀번호를 입력하세요.">
		<button type="button" onclick="go_check('${b_num}','${type }','${cur_page}','${b_step}','${b_group}',${r_num })">확인</button>
	</form>
	<span id="notice" class="checking"></span>
	</div>
	<script>
	
	$(function() {
		  $("#b_pw").focus();
		});
	
	
	function go_check(b_num,type,cur_page,b_step,b_group,r_num) {
		var input_pw= $("#pw").val();
			
		var pw_data = $("form[name=pw_check]").serialize()+"&type="+type;
		
		$.ajax({
			type:"post",
			url:"pw_ok",
			data:pw_data,
			dataType:"json",
			async:false,
			success: function(data) {
				if(data==1){
					if(type=="update"){
					window.close();
					opener.location.href="bupdate_page?b_num="+b_num+"&cur_page="+cur_page;						
					}else if(type=="delete"){
						window.close();
						opener.location.href="b_delete?&b_step="+b_step+"&b_group="+b_group+"&b_num="+b_num+"&cur_page="+cur_page;	
					}else if(type=="r_update"){
						window.close();
						opener.parent.r_change(r_num);
					}else if(type=="r_delete"){
						$.ajax({
							type:"post",
							url:"r_delete",
							data:{"r_num":r_num},
							success: function(data) {
								if(data==1){
								window.close();
								opener.location.reload(true);									
								}
							},error: function() {
								alert("통신에러");
							}
						});
						
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